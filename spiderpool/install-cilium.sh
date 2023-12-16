kubectl patch crd/spiderippools.spiderpool.spidernet.io -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl patch crd/spidercoordinators.spiderpool.spidernet.io -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl patch crd/spiderendpoints.spiderpool.spidernet.io -p '{"metadata":{"finalizers":[]}}' --type=merge


kubeadm init  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.26.7 --skip-phases=addon/kube-proxy

helm uninstall cilium --namespace kube-system
helm install cilium cilium/cilium --version 1.14.3 \
--namespace kube-system \
--set kubeProxyReplacement=strict \
--set k8sServiceHost=10.211.55.3 \
--set k8sServicePort=6443 \
--set cni.exclusive=false

helm uninstall spiderpool --namespace kube-system
helm install spiderpool spiderpool/spiderpool -n kube-system \
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
  - "10.211.55.150-10.211.55.199"
  subnet: 10.211.55.0/24
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


ANNOTATION_MULTUS="v1.multus-cni.io/default-network: kube-system/macvlan-conf"
NAME=ipvlan
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: ipvlan
  labels:
    app: ipvlan
spec:
  selector:
    matchLabels:
      app: ipvlan
  template:
    metadata:
      name: ipvlan
      labels:
        app: ipvlan
      annotations:
        v1.multus-cni.io/default-network: kube-system/macvlan-conf
    spec:
      containers:
      - name: test-app
        image: nginx
        imagePullPolicy: IfNotPresent
        ports:
        - name: http
          containerPort: 80
          protocol: TCP
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: ipvlan
spec:
  selector:
    app: ipvlan
  type: ClusterIP
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: 80
EOF