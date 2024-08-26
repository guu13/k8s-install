kubeadm init  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.23.17 --skip-phases=addon/kube-proxy

kubectl taint node --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

cat  /sys/kernel/debug/tracing/trace_pipe

kubeadm token create --print-join-command

helm uninstall cilium --namespace kube-system
sudo cilium cleanup
helm install cilium /home/barry/work/helm-charts/cilium/  --version 1.16.0 \
  --namespace=kube-system \
  --set cni.chainingMode=generic-veth \
  --set cni.customConf=true \
  --set cni.configMap=cni-configuration \
  --set kubeProxyReplacement=strict \
  --set routingMode=native \
  --set enableIPv4Masquerade=false \
  --set bpf.hostLegacyRouting=true \
  --set k8sServiceHost=10.211.55.12 \
  --set k8sServicePort=6443 \
  --set operator.replicas=1 \
  --set debug.enabled=true \
  --set debug.verbose='flow kvstore envoy datapath policy' \
  --set image.useDigest=false \
  --set operator.image.useDigest=false \
  --set image.repository="quay.io/cilium/cilium" \
  --set image.tag="v1.16.0" \
  --set operator.image.repository="quay.io/cilium/operator" \
  --set operator.image.tag="v1.16.0" 

helm uninstall spiderpool --namespace kube-system
helm install spiderpool /home/barry/work/helm-charts/spiderpool/  --version v0.8.3 \
--namespace kube-system \
--set multus.multusCNI.defaultCniCRName="whq-cni-conf" \
--set global.imageRegistryOverride=ghcr.m.daocloud.io \
--set spiderpoolAgent.loglevel=debug \
--set muluts.enableMultusConfig=false \
--set multus.multusCNI.install=false


cat <<EOF | kubectl apply -f -
apiVersion: spiderpool.spidernet.io/v2beta1
kind: SpiderIPPool
metadata:
  name: ippool-enp0s5
spec:
  default: true
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

cat <<EOF | kubectl apply -f -
apiVersion: k8s.cni.cncf.io/v1
kind: NetworkAttachmentDefinition
metadata:
  name: whq-cni-conf
  namespace: kube-system
spec:
  config: |
   {
     "cniVersion": "0.4.0",
     "name": "generic-veth",
     "plugins": [
      {
         "type": "macvlan",
         "mode": "bridge",
         "master": "enp0s5",
         "ipam": {
           "type": "spiderpool",
           "default_ipv4_ippool":["ippool-enp0s5"]
         },
         "logOptions": {
           "logLevel": "debug",
           "logFile": "/var/log/spidernet/spiderpool.log"
         }
      },
      {
        "type": "coordinator",
        "logOptions": {
           "logLevel": "debug",
           "logFile": "/var/log/spidernet/coordinator.log"
        }
      },
      {
        "type": "cilium-cni",
        "enable-debug": true,
        "log-file": "/var/log/cilium-cni.log"
      }]
   }
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: cni-configuration
  namespace: kube-system
data:
  cni-config: |-
   {
     "cniVersion": "0.4.0",
     "name": "generic-veth",
     "plugins": [
      {
         "type": "macvlan",
         "mode": "bridge",
         "master": "enp0s5",
         "ipam": {
           "type": "spiderpool",
           "default_ipv4_ippool":["ippool-enp0s5"]
         },
         "logOptions": {
           "logLevel": "debug",
           "logFile": "/var/log/spidernet/spiderpool.log"
         }
      },
      {
        "type": "coordinator",
        "logOptions": {
           "logLevel": "debug",
           "logFile": "/var/log/spidernet/coordinator.log"
        }
      },
      {
        "type": "cilium-cni",
        "enable-debug": true,
        "log-file": "/var/log/cilium-cni.log"
      }]
   }
EOF



helm install cilium ./cilium -n kube-system  --version 1.14.6 
--set kubeProxyReplacement=strict 
--set k8sServiceHost=100.2.231.111 
--set k8sServicePort=6443 
--set tunnel=disabled 
--set autoDirectNodeRoutes=true 
--set ipv4NativeRoutingCIDR=10.0.0.0/8 
--set ipam.mode=cluster-pool 
--set ipam.operator.clusterPoolIPv4PodCIDRList=10.0.0.0/8 
--set ipam.operator.clusterPoolIPv4MaskSize=24 
--set bpf.masquerade=true 
--set bpf.hostRouting=false 
--set installNoConntrackIptablesRules=true 
--set securityContext.privileged=true