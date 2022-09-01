docker load < submariner-operator.tar 
docker load < submariner-route-agent.tar
docker load < submariner-gateway.tar 
docker load < lighthouse-coredns.tar
docker load < lighthouse-agent.tar
docker load < submariner-gateway.tar
docker load < nettest.tar

docker load < dig.tar
docker load < nginx.tar
docker load < kindest.1.23.4.tar

docker load < cni.3.21.6.tar 
docker load < kube-controllers.3.21.6.tar 
docker load < node.3.21.6.tar 
docker load < pod2daemon-flexvol.3.21.6.tar 


---broker
su - broker

kind delete cluster --name broker
cd /data
kind create cluster --image kindest/node:v1.23.4 --config /data/kind/broker.yaml

kubectl taint node --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-operator:0.13.0 --name broker

#subctl deploy-broker --globalnet --operator-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 
subctl deploy-broker --operator-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 
chmod 755 /data/broker-info.subm


---east
su - east

kind delete cluster --name east

kind create cluster --image kindest/node:v1.23.4 --config /data/kind/east.yaml

kubectl taint node --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

kind load docker-image docker.io/calico/cni:v3.21.6 --name east
kind load docker-image docker.io/calico/pod2daemon-flexvol:v3.21.6 --name east
kind load docker-image docker.io/calico/node:v3.21.6 --name east
kind load docker-image docker.io/calico/kube-controllers:v3.21.6 --name east
kind load docker-image tutum/dnsutils:latest --name east
kind load docker-image nginx:alpine --name east

kubectl apply -f /data/calico-v3.21.6.yaml 

kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-operator:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-route-agent:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-gateway:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/lighthouse-coredns:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/lighthouse-agent:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-globalnet:0.13.0 --name east


kubectl apply -f /data/east-ippool.yaml

subctl join /data/broker-info.subm --globalnet --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid east 
# subctl join /data/broker-info.subm --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid east 


---west
su - west

kind delete cluster --name west

kind create cluster --image kindest/node:v1.23.4 --config /data/kind/west.yaml
kubectl taint node --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

kind load docker-image docker.io/calico/cni:v3.21.6 --name west
kind load docker-image docker.io/calico/pod2daemon-flexvol:v3.21.6 --name west
kind load docker-image docker.io/calico/node:v3.21.6 --name west
kind load docker-image docker.io/calico/kube-controllers:v3.21.6 --name west

kubectl apply -f /data/calico-v3.21.6.yaml 


kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-operator:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-route-agent:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-gateway:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/lighthouse-coredns:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/lighthouse-agent:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-globalnet:0.13.0 --name west


kubectl apply -f /data/west-ippool.yaml

subctl join /data/broker-info.subm --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid west 

#subctl join /data/broker-info.subm --globalnet --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid west 


----------------------------------------------------------------------------

gateway.submariner.io/public-ip: ipv4:172.18.0.5

gateway.submariner.io/public-ip: ipv4:172.18.0.8

--------------

kind load docker-image registry.cn-hangzhou.aliyuncs.com/google_samples_thepoy/cassandra:v13 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/google_samples_thepoy/cassandra:v13 --name east

-----------------
kubectl create ns db 
kubectl apply -f cassandra-svc.yaml

subctl export service -ndb cassandra

kubectl apply -f east-cassandra-statefulset.yaml

kubectl apply -f west-cassandra-statefulset.yaml 