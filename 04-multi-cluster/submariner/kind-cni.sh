docker load < submariner-operator.tar 
docker load < submariner-route-agent.tar
docker load < submariner-gateway.tar 
docker load < lighthouse-coredns.tar
docker load < lighthouse-agent.tar
docker load < lighthouse-agent.tar
docker load < nettest.tar
docker load < dig.tar
docker load < nginx.tar


---broker
su - broker

kind delete cluster --name broker
cd /data
kind create cluster --image kindest/node:v1.23.4 --config /data/kind/broker.yaml

kubectl taint node --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-operator:0.13.0 --name broker

# subctl deploy-broker --globalnet --operator-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 
subctl deploy-broker --operator-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 

chmod 755 /data/broker-info.subm


---east
su - east

kind delete cluster --name east

kind create cluster --image kindest/node:v1.23.4 --config /data/kind/east-cni.yaml

kubectl taint node --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-operator:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-route-agent:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-gateway:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/lighthouse-coredns:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/lighthouse-agent:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-globalnet:0.13.0 --name east
kind load docker-image tutum/dnsutils:latest --name east
kind load docker-image nginx:alpine --name east

kubectl create ns east
kubectl create ns west
kubectl apply -f /data/east-nginx.yaml
kubectl apply -f dig.yaml

# subctl join /data/broker-info.subm --globalnet --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid east 
subctl join /data/broker-info.subm --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid east 

---west
su - west

kind delete cluster --name west

kind create cluster --image kindest/node:v1.23.4 --config /data/kind/west-cni.yaml

kubectl taint node --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-operator:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-route-agent:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-gateway:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/lighthouse-coredns:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/lighthouse-agent:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-globalnet:0.13.0 --name west
kind load docker-image tutum/dnsutils:latest --name west
kind load docker-image nginx:alpine --name west

kubectl create ns east
kubectl create ns west
kubectl apply -f west-nginx.yaml
kubectl apply -f dig.yaml

#subctl join /data/broker-info.subm --globalnet --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid west 
subctl join /data/broker-info.subm --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid west 


----------------------------------------------------------------------------
kubectl edit node  east-worker
kubectl edit node  west-worker

gateway.submariner.io/public-ip: ipv4:172.18.0.5

gateway.submariner.io/public-ip: ipv4:172.18.0.8

--------------

subctl unexport service nginx -n east 
subctl export service nginx -n east 

kubectl get svcim -A

subctl unexport service  nginx -n west
subctl export service nginx -n west 

kubectl get svcim -A

------------

kind load docker-image registry.cn-hangzhou.aliyuncs.com/google_samples_thepoy/cassandra:v13 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/google_samples_thepoy/cassandra:v13 --name east


kubectl create ns db
kubectl apply -f cassandra-svc.yaml 
subctl export service -ndb cassandra

kubectl apply -f east-cassandra-statefulset.yaml

kubectl apply -f west-cassandra-statefulset.yaml

-----------------
kubectl create ns db 
kubectl apply -f cassandra-svc.yaml

subctl export service -ndb cassandra

kubectl apply -f east-cassandra-statefulset.yaml

kubectl apply -f west-cassandra-statefulset.yaml 