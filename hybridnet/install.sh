--set

helm uninstall hybridnet -n kube-system

helm install  hybridnet hybridnet/hybridnet -n kube-system \
 --set manager.replicas=1 \
 --set webhook.replicas=1 \
 --set daemon.preferVlanInterfaces='eth1\,enp0s6' \
 --set daemon.preferVxlanInterfaces='eth0\,enp0s5' 


helm install  hybridnet  -n kube-system ./


---
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
    cidr: "10.37.129.1/24"
    start: "10.37.129.100"                           
    end: "10.37.129.200"         
    gateway: "10.37.129.1"
---
apiVersion: networking.alibaba.com/v1
kind: Network
metadata:
  name: underlay-network2
spec:
  netID: 0
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
  netID: 0
  range:
    version: "4"
    cidr: "10.37.132.1/24"
    gateway: "10.37.132.1"
    start: "10.37.132.100"                           
    end: "10.37.132.200"





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
  replicas: 4
  selector:
    matchLabels:
      app: nginx
  strategy:
    type: RollingUpdate
  template:
    metadata:
      annotations:
        networking.alibaba.com/specified-network=underlay-network1
      labels:
        app: nginx
    spec:
      containers:
        - image: nginx:alpine
          imagePullPolicy: IfNotPresent
          name: nginx
~                      