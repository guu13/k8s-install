kubectl patch crd/spiderippools.spiderpool.spidernet.io -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl patch crd/spidercoordinators.spiderpool.spidernet.io -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl patch crd/spiderendpoints.spiderpool.spidernet.io -p '{"metadata":{"finalizers":[]}}' --type=merge


kubeadm init  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.26.7 --skip-phases=addon/kube-proxy

kubeadm init  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.23.17 --skip-phases=addon/kube-proxy

kubeadm config images pull --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.23.17

DOCKER_IMAGE_TAG=v1.14.5.2 make docker-cilium-image
DOCKER_IMAGE_TAG=v1.14.7 make docker-operator-generic-image
cat  /sys/kernel/debug/tracing/trace_pipe

helm repo add cilium https://helm.cilium.io/

helm uninstall cilium --namespace kube-system
sudo cilium cleanup

helm install cilium /home/barry/work/helm-charts/cilium/ --version 1.14.5 \
--namespace kube-system \
--set kubeProxyReplacement=strict \
--set k8sServiceHost=10.211.55.11 \
--set k8sServicePort=6443 \
--set operator.replicas=1 \
--set cni.exclusive=false \
--set debug.enabled=true \
--set debug.verbose='flow kvstore envoy datapath policy' \
--set image.useDigest=false \
--set operator.image.useDigest=false \
--set image.repository="quay.io/cilium/cilium" \
--set image.tag="v1.14.5.1" \
--set operator.image.repository="quay.io/cilium/operator" \
--set operator.image.tag="v1.14.5" 
  
helm upgrade cilium /home/barry/work/helm-charts/cilium/ --version 1.14.5 \
--namespace kube-system \
--set kubeProxyReplacement=strict \
--set k8sServiceHost=10.211.55.11 \
--set k8sServicePort=6443 \
--set operator.replicas=1 \
--set cni.exclusive=false \
--set debug.enabled=true \
--set debug.verbose='flow kvstore envoy datapath policy' \
--set image.useDigest=false \
--set operator.image.useDigest=false \
--set image.repository="quay.io/cilium/cilium" \
--set image.tag="v1.14.5.2" \
--set operator.image.repository="quay.io/cilium/operator" \
--set operator.image.tag="v1.14.5" 
 


helm repo add spiderpool https://spidernet-io.github.io/spiderpool
helm repo update spiderpool

helm uninstall spiderpool --namespace kube-system
helm install spiderpool spiderpool/spiderpool -n kube-system --version v0.8.3 \
    --set multus.multusCNI.defaultCniCRName="whq-cni-conf" \
    --set  coordinator.podCIDRType=none \
    --set global.imageRegistryOverride=ghcr.m.daocloud.io \
    --set spiderpoolAgent.loglevel=debug

cat <<EOF | kubectl apply -f -
apiVersion: spiderpool.spidernet.io/v2beta1
kind: SpiderIPPool
metadata:
  name: ippool-enp0s5
spec:
  gateway: 10.211.55.1
  ips:
  - "10.211.55.200-10.211.55.254"
  subnet: 10.211.55.0/24
  multusName:
    - kube-system/whq-cni-conf
EOF

kubectl delete SpiderMultusConfig -n kube-system   whq-cni-conf 
cat <<EOF | kubectl apply -f -
apiVersion: spiderpool.spidernet.io/v2beta1
kind: SpiderMultusConfig
metadata:
  name: whq-cni-conf
  namespace: kube-system
spec:
  enableCoordinator: true
  cniType: macvlan
  macvlan:
    master: ["enp0s5"]
    ippools:
      ipv4: ["ippool-enp0s5"]
EOF