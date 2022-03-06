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

kind delete cluster --name cluster-hub  

kind create cluster  --config cluster-hub.yaml 

kind delete cluster --name cluster-hub 
kind create cluster --config cluster-worker1.yaml 

kind create cluster --config cluster-worker2.yaml 



kind delete cluster --name hub 
export POD_CIDR=10.100.0.0/16
export SERVICE_CIDR=172.100.0.0/16
hack/create-cluster.sh hub $HOME/.kube/hub.config