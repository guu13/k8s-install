
helm uninstall spiderpool --namespace kube-system

helm install spiderpool spiderpool/spiderpool --namespace kube-system \
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