kubeadm init  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.26.7

/// 还没发现产品里需要这种模式
/// LB-only模式旨在在既无法连接到kube-apiserver也无法连接到kvstore的负载均衡节点上运行。在此模式下，服务应通过Cilium REST API进行配置。
/// The LB-only mode is intended to be run on load-balancing nodes which have connectivity neither to kube-apiserver nor kvstore.
/// In this mode services are supposed to be configured via Cilium REST API.


helm upgrade cilium cilium/cilium --version 1.14.5 \
--namespace kube-system \
--set image.repository="quay.io/cilium/cilium" \
--set image.tag="v1.14.5" \
--set operator.image.repository="quay.io/cilium/operator" \
--set operator.image.tag="v1.14.5" \
--set k8sServiceHost=10.211.55.3 \
--set k8sServicePort=6443 \
--set operator.replicas=1 \
--set cni.exclusive=false \
--set debug.enabled=true \
--set debug.verbose='flow kvstore envoy datapath policy' \
--set image.useDigest=false \
--set operator.image.useDigest=false \
--set cni.install=true \
--set loadBalancer.standalone=true



helm uninstall spiderpool --namespace kube-system
helm install spiderpool spiderpool/spiderpool --version v0.8.3 \
--namespace kube-system \
--set multus.multusCNI.defaultCniCRName="whq-cni-conf" \
--set global.imageRegistryOverride=ghcr.m.daocloud.io \
--set spiderpoolAgent.loglevel=debug


cat <<EOF | kubectl apply -f -
apiVersion: spiderpool.spidernet.io/v2beta1
kind: SpiderIPPool
metadata:
  name: ippool-enp0s5
spec:
  default: true
  ips:
  - "10.211.55.200-10.211.55.254"
  subnet: 10.211.55.0/24
  gateway: 10.211.55.1
  multusName: 
  - kube-system/whq-cni-conf
EOF


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