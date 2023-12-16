cat <<EOF | kubectl apply -f -
apiVersion: spiderpool.spidernet.io/v2beta1
kind: SpiderIPPool
metadata:
  name: ippool-enp0s5
spec:
  ips:
  - "10.211.55.200-10.211.55.254"
  subnet: 10.211.55.0/24
  gateway: 10.211.55.1
  multusName: 
  - kube-system/ipvlan-enp0s5
EOF



MACVLAN_MASTER_INTERFACE="enp0s5"
cat <<EOF | kubectl apply -f -
apiVersion: spiderpool.spidernet.io/v2beta1
kind: SpiderMultusConfig
metadata:
  name: macvlan-conf
  namespace: kube-system
spec:
  cniType: macvlan
  macvlan:
    master:
    - ${MACVLAN_MASTER_INTERFACE}
EOF


IPVLAN_MASTER_INTERFACE="enp0s5"
CNI_CHAINING_MODE="terway-chainer"
cat <<EOF | kubectl apply -f -
apiVersion: k8s.cni.cncf.io/v1
kind: NetworkAttachmentDefinition
metadata:
  name: ipvlan-enp0s5
  namespace: kube-system
spec:
  config: |
   {
     "cniVersion": "0.4.0",
     "name": "${CNI_CHAINING_MODE}",
     "plugins": [
      {
         "type": "ipvlan",
         "mode": "l2",
         "master": "${IPVLAN_MASTER_INTERFACE}",
         "ipam": {
           "type": "spiderpool"
         },
         "logOptions": {
           "logLevel": "debug",
           "logFile": "/var/log/spidernet/spiderpool.log"
         }
      },
      {
        "type": "cilium-cni",
        "enable-debug": true,
        "log-file": "/var/log/cilium-cni.log"
      },
     {
        "type": "coordinator",
        "logOptions": {
           "logLevel": "debug",
           "logFile": "/var/log/spidernet/coordinator.log"
        }
     }]
   }
EOF

IPVLAN_MASTER_INTERFACE="enp0s5"
CNI_CHAINING_MODE="terway-chainer"
cat <<EOF | kubectl apply -f -
apiVersion: k8s.cni.cncf.io/v1
kind: NetworkAttachmentDefinition
metadata:
  name: ipvlan-enp0s5
  namespace: kube-system
spec:
  config: |
   {
     "cniVersion": "0.4.0",
     "name": "${CNI_CHAINING_MODE}",
     "plugins": [
      {
         "type": "ipvlan",
         "mode": "l2",
         "master": "${IPVLAN_MASTER_INTERFACE}",
         "ipam": {
           "type": "spiderpool"
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
     }]
   }
EOF


IPVLAN_MASTER_INTERFACE="enp0s5"
CNI_CHAINING_MODE="terway-chainer"
cat <<EOF | kubectl apply -f -
apiVersion: k8s.cni.cncf.io/v1
kind: NetworkAttachmentDefinition
metadata:
  name: ipvlan-enp0s5
  namespace: kube-system
spec:
  config: |
   {
     "cniVersion": "0.4.0",
     "name": "${CNI_CHAINING_MODE}",
     "plugins": [
      {
         "type": "ipvlan",
         "mode": "l2",
         "master": "${IPVLAN_MASTER_INTERFACE}",
         "ipam": {
           "type": "spiderpool"
         },
         "logOptions": {
           "logLevel": "debug",
           "logFile": "/var/log/spidernet/spiderpool.log"
         }
      },
      {
        "type": "cilium-cni",
        "enable-debug": true,
        "log-file": "/var/log/cilium-cni.log"
      }]
   }
EOF



IPVLAN_MASTER_INTERFACE="enp0s5"
CNI_CHAINING_MODE="terway-chainer"
cat <<EOF | kubectl apply -f -
apiVersion: k8s.cni.cncf.io/v1
kind: NetworkAttachmentDefinition
metadata:
  name: ipvlan-enp0s5
  namespace: kube-system
spec:
  config: |
   {
     "cniVersion": "0.4.0",
     "name": "${CNI_CHAINING_MODE}",
     "plugins": [
      {
         "type": "ipvlan",
         "mode": "l2",
         "master": "${IPVLAN_MASTER_INTERFACE}",
         "ipam": {
           "type": "spiderpool"
         },
         "logOptions": {
           "logLevel": "debug",
           "logFile": "/var/log/spidernet/spiderpool.log"
         }
      }
   }
EOF