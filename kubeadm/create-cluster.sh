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

kubeadm init --pod-network-cidr=172.200.0.0/16  --service-cidr=172.100.0.0/16 --config=kubeadm-config.yaml --upload-certs -v=10 | tee kubeadm-init.log

1.15 kubeadm init --pod-network-cidr=172.200.0.0/16  --service-cidr=172.100.0.0/16 --config=kubeadm-config.yaml --upload-certs | tee kubeadm-init.log
#1.14 kubeadm init --config=kubeadm-config.yaml --experimental-upload-certs | tee kubeadm-init.log


## 172.100.0.0/16 (172.100.0.1 , 172.100.255.254, 65534)
## 172.200.0.0/16 (172.200.0.1 , 172.200.255.254, 65534)
## 
kubeadm init --pod-network-cidr=172.200.0.0/16  --service-cidr=172.100.0.0/16  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers


kubeadm config images pull --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers


### -- cilium ipv4
kubeadm init --skip-phases=addon/kube-proxy --pod-network-cidr=172.200.0.0/16  --service-cidr=172.100.0.0/16  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers


### -- cilium ipv6
kubeadm init --skip-phases=addon/kube-proxy --pod-network-cidr=172.200.0.0/16,fd74:ca9b:0172:0019::/110  --service-cidr=172.100.0.0/16,fd74:ca9b:0172:0018::/110  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers


sudo rm -rf $HOME/.kube/*
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


kubectl taint node --all node-role.kubernetes.io/master-

kubeadm token create --print-join-command

