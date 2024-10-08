sudo rm -rf /root/.kube
sudo rm -rf /etc/cni/net.d/
#sudo kubeadm init  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.23.17 --skip-phases=addon/kube-proxy
#sudo kubeadm init  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.23.17
kubeadm init  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.26.7
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl taint node --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane-



kubeadm init --pod-network-cidr=172.200.0.0/16  --service-cidr=172.100.0.0/16 --config=kubeadm-config.yaml --upload-certs -v=10 | tee kubeadm-init.log

#1.15 kubeadm init --pod-network-cidr=172.200.0.0/16  --service-cidr=172.100.0.0/16 --config=kubeadm-config.yaml --upload-certs | tee kubeadm-init.log
#1.14 kubeadm init --config=kubeadm-config.yaml --experimental-upload-certs | tee kubeadm-init.log


kubeadm init  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --config=kubeadm-config.yaml

## 172.100.0.0/16 (172.100.0.1 , 172.100.255.254, 65534)
## 172.200.0.0/16 (172.200.0.1 , 172.200.255.254, 65534)
## 
kubeadm init --pod-network-cidr=10.244.0.0/16 --service-cidr=172.100.0.0/16 --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.23.10

kubeadm init --pod-network-cidr=10.244.0.0/16 --service-cidr=172.100.0.0/16 --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.26.7

kubeadm init  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.29.5
kubeadm init  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.26.7
kubeadm init  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.26.7 --skip-phases=addon/kube-proxy

kubeadm config images pull --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.26.7

kubeadm config images pull --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --kubernetes-version=1.29.5

### -- cilium ipv4
kubeadm init --skip-phases=addon/kube-proxy --pod-network-cidr=172.200.0.0/16  --service-cidr=172.100.0.0/16  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers


crictl pull registry-vpc.cn-hangzhou.aliyuncs.com/google_containers/pause:3.9
crictl pull registry-vpc.cn-zhangjiakou.aliyuncs.com/guu13/terway:latest

yum install iproute-tc -y

sudo rm -rf $HOME/.kube/*
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


kubectl taint node --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

### -- cilium ipv6
kubeadm init --skip-phases=addon/kube-proxy --pod-network-cidr=172.200.0.0/16,fd74:ca9b:0172:0019::/110  --service-cidr=172.100.0.0/16,fd74:ca9b:0172:0018::/110  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers



kubeadm token create --print-join-command


kubeadm join 10.211.55.34:6443 --token izxy19.yhi9dgj1qsuddwnj --discovery-token-ca-cert-hash sha256:cf4d8307cb18cb0cc0663979f0192d5f3443241e321d40e95d77499969b2843c 

alias kpod="kubectl get po -A -owide"
alias ksvc="kubectl get svc -A -owide"
alias kdel="kubectl delete po -n"
alias klog="kubectl logs -f -n"
alias kexec="kubectl exec -it -n"
alias kdesc="kubectl describe po -n"


#####################  

sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's#SystemdCgroup = false#SystemdCgroup = true#g' /etc/containerd/config.toml
sudo sed -i 's#sandbox_image = "registry.k8s.io/pause:3.6"#sandbox_image = "registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.9"#g' /etc/containerd/config.toml
sudo systemctl restart containerd