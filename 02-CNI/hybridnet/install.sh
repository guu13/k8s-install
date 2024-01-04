
helm repo add hybridnet https://alibaba.github.io/hybridnet/
helm repo update


helm uninstall hybridnet -n kube-system
helm install  hybridnet hybridnet/hybridnet -n kube-system \
 --set manager.replicas=1 \
 --set webhook.replicas=1 \
 --set daemon.preferVlanInterfaces='eth1\,enp0s6' \
 --set daemon.preferVxlanInterfaces='eth0\,enp0s5' 


helm uninstall hybridnet -n kube-system
helm install  hybridnet  -n kube-system \
 --set manager.replicas=1 \
 --set webhook.replicas=1 \
 --set daemon.preferVlanInterfaces='enp0s6\,enp0s5' \
 --set daemon.preferVxlanInterfaces='enp0s5' \
 ./

### for manager and webhoot
kubectl label nodes node6 node-role.kubernetes.io/master=""

### for underlay network
kubectl label nodes node7 network="underlay-network1"
kubectl label nodes node8 node="underlay-network1"


kubectl delete network underlay-network1
kubectl delete subnet underlay-subnet1
cat <<EOF | kubectl apply -f -
apiVersion: networking.alibaba.com/v1
kind: Network
metadata:
  name: cat <<EOF | kubectl apply -f -
apiVersion: networking.alibaba.com/v1
kind: Network
metadata:
  name: underlay-network1
spec:
  netID: 0
  type: Underlay
  nodeSelector:
    node: "underlay-network1"
---
apiVersion: networking.alibaba.com/v1
kind: Subnet
metadata:
  name: underlay-subnet1
spec:
  network: underlay-network1
  netID: 0
  range:
    version: "4"
    cidr: "10.37.129.0/24"
    start: "10.37.129.100"                           
    end: "10.37.129.200"         
    gateway: "10.37.129.1"
EOF


kubectl delete network underlay-network2
kubectl delete subnet underlay-subnet2
cat <<EOF | kubectl apply -f -
apiVersion: networking.alibaba.com/v1
kind: Network
metadata:
  name: underlay-network2
spec:
  netID: 4
  type: Underlay
  nodeSelector:
    network: "underlay-network2"
---
apiVersion: networking.alibaba.com/v1
kind: Subnet
metadata:
  name: underlay-subnet2
spec:
  network: underlay-network2
  netID: 4
  range:
    version: "4"
    cidr: "10.37.132.0/24"
    gateway: "10.37.132.1"
    start: "10.37.132.100"                           
    end: "10.37.132.200"
EOF



cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: nginx-svc
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: NodePort
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  strategy:
    type: RollingUpdate
  template:
    metadata:
      annotations:
        networking.alibaba.com/specified-network: underlay-network1
      labels:
        app: nginx
    spec:
      containers:
        - image: nginx:alpine
          imagePullPolicy: IfNotPresent
          name: nginx
EOF