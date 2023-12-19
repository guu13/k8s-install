

kind delete cluster --name cluster-hub  
kind create cluster --image  kindest/node:v1.23.4  --config broker.yaml  --config cluster-hub.yaml 

kind delete cluster --name cluster-hub 
kind create cluster --config cluster-worker1.yaml 

kind create cluster --config cluster-worker2.yaml 



kind delete cluster --name hub 
export POD_CIDR=10.100.0.0/16
export SERVICE_CIDR=172.100.0.0/16
hack/create-cluster.sh hub $HOME/.kube/hub.config


kind create cluster --image kindest/node:v1.23.4 --config /data/kind/east.yaml


#vim my-cluster-multi-node.yaml	
#一共两个节点，一个主节点，一个从节点。	
kind: Cluster	
apiVersion: kind.x-k8s.io/v1alpha4
name: broker
networking:
  podSubnet: "10.100.0.0/16"
  serviceSubnet: "172.100.0.0/16"
nodes:	
- role: control-plane
- role: worker


#vim my-cluster-multi-node.yaml	
#一共两个节点，一个主节点，一个从节点。	
kind: Cluster	
apiVersion: kind.x-k8s.io/v1alpha4
name: east
networking:
  podSubnet: "10.110.0.0/16"
  serviceSubnet: "172.110.0.0/16"
nodes:	
- role: control-plane
- role: worker


#vim my-cluster-multi-node.yaml	
#一共两个节点，一个主节点，一个从节点。	
kind: Cluster	
apiVersion: kind.x-k8s.io/v1alpha4
name: west
networking:
  podSubnet: "10.120.0.0/16"
  serviceSubnet: "172.120.0.0/16"
nodes:	
- role: control-plane
- role: worker


kind load docker-image quay.io/submariner/submariner-operator:0.13.0 --name east
kind load docker-image quay.io/submariner/submariner-route-agent:0.13.0 --name east
kind load docker-image quay.io/submariner/submariner-gateway:0.13.0 --name east
kind load docker-image quay.io/submariner/lighthouse-coredns:0.13.0 --name east
kind load docker-image quay.io/submariner/lighthouse-agent:0.13.0 --name east

kind load docker-image quay.io/submariner/submariner-operator:0.13.0 --name west
kind load docker-image quay.io/submariner/submariner-route-agent:0.13.0 --name west
kind load docker-image quay.io/submariner/submariner-gateway:0.13.0 --name west
kind load docker-image quay.io/submariner/lighthouse-coredns:0.13.0 --name west
kind load docker-image quay.io/submariner/lighthouse-agent:0.13.0 --name west


docker pull docker.io/calico/cni:v3.21.4
docker pull docker.io/calico/pod2daemon-flexvol:v3.21.4
docker pull docker.io/calico/node:v3.21.4
docker pull docker.io/calico/kube-controllers:v3.21.4

kind load docker-image docker.io/calico/cni:v3.21.4 --name west
kind load docker-image docker.io/calico/pod2daemon-flexvol:v3.21.4 --name west
kind load docker-image docker.io/calico/node:v3.21.4 --name west
kind load docker-image docker.io/calico/kube-controllers:v3.21.4 --name west