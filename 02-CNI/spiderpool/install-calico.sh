kubectl apply -f https://github.com/projectcalico/calico/blob/master/manifests/calico.yaml
kubectl wait --for=condition=ready -l k8s-app=calico-node  pod -n kube-system 

https://raw.githubusercontent.com/projectcalico/calico/v3.26.4/manifests/calico-vxlan.yaml

- name: CALICO_IPV4POOL_VXLAN
  value: "vxlan"

calico_backend: "vxlan"

# 编辑calico-node ds
kubectl edit ds calico-node -n kube-system

# 新增环境变量（指定使用网卡interface=bond4）
- name: IP_AUTODETECTION_METHOD
  value: interface=enp0s5

kubectl set env daemonset/calico-node -n kube-system IP_AUTODETECTION_METHOD=interface=enp0s5



helm uninstall spiderpool --namespace kube-system 
helm install spiderpool spiderpool/spiderpool --namespace kube-system  \
    --set coordinator.mode=overlay \
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
  - "10.211.55.150-10.211.55.199"
  subnet: 10.211.55.0/24
  multusName:
    - kube-system/macvlan-whq-conf
EOF

cat <<EOF | kubectl apply -f -
apiVersion: spiderpool.spidernet.io/v2beta1
kind: SpiderIPPool
metadata:
  name: ippool-enp0s6
spec:
  gateway: 10.37.129.1
  ips:
  - "10.37.129.150-10.37.129.199"
  subnet: 10.37.129.0/24
  multusName:
    - kube-system/macvlan-whq-conf
EOF

kubectl delete SpiderMultusConfig -n kube-system   macvlan-whq-conf
cat <<EOF | kubectl apply -f -
apiVersion: spiderpool.spidernet.io/v2beta1
kind: SpiderMultusConfig
metadata:
  name: macvlan-whq-conf
  namespace: kube-system
spec:
  enableCoordinator: true
  cniType: macvlan
  macvlan:
    master: ["enp0s6"]
    ippools:
      ipv4: ["ippool-enp0s6"]
EOF

kubectl delete deploy nginx
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      annotations:
        v1.multus-cni.io/default-network: kube-system/macvlan-whq-conf
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
        imagePullPolicy: IfNotPresent
        ports:
        - name: http
          containerPort: 80
          protocol: TCP
EOF


ip rule add from 110.37.129.0/24 table 1000
ip r add 10.37.129.0/24 via 10.244.3.100 dev vxlan.calico onlink table 1000


# 路由会被 Calcio felix 删除 ， 认为是过期的 old的路由 ， 不应该存在
# 2023-12-17 21:14:03.591 [INFO][173] felix/route_table.go 902: Remove old route dest=10.37.129.153/32 ifaceName="vxlan.calico" 
# ifaceRegex="^vxlan.calico$" ipVersion=0x4 routeProblems=[]string{"unexpected route", "incorrect gateway"} tableIndex=254
ip r add 10.37.129.153 via 10.244.3.105 dev vxlan.calico onlink ; ip r add 10.37.129.171 via 10.244.33.180 dev vxlan.calico onlink


ip r add 10.37.129.0/24 dev vxlan.calico onlink