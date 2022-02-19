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



sudo rm -rf $HOME/.kube/*
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


kubectl taint node --all node-role.kubernetes.io/master-

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