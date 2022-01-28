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

# ipv4 native routing Vxlan Geneve 模式
helm delete cilium -nkube-system 
helm install cilium cilium/cilium --version 1.11.0 \
    --namespace kube-system \
    --set debug.enabled=true \
    --set operator.replicas=1 \
    --set devices=enp0s5 \
    --set kubeProxyReplacement=strict \
    --set k8sServiceHost=10.211.55.34 \
    --set k8sServicePort=6443 \
    --set hubble.relay.enabled=true \
    --set hubble.ui.enabled=true 

# ipv4 native routing 模式
helm delete cilium -nkube-system 
helm install cilium cilium/cilium --version 1.11.0 \
 --namespace kube-system \
 --set debug.enabled=true \
 --set operator.replicas=1 \
 --set devices=enp0s5 \
 --set tunnel=disabled \
 --set autoDirectNodeRoutes=true \
 --set kubeProxyReplacement=strict \
 --set loadBalancer.mode=hybrid \
 --set ipv4NativeRoutingCIDR=172.200.0.0/16 \
 --set ipam.operator.clusterPoolIPv4PodCIDR=172.200.0.0/16 \
 --set ipam.operator.clusterPoolIPv4MaskSize=26 \
 --set k8sServiceHost=10.211.55.34 \
 --set k8sServicePort=6443 \
 --set hubble.relay.enabled=true \
 --set hubble.ui.enabled=true 



#####   #############
--set loadBalancer.acceleration=native \
level=fatal msg="Error while creating daemon" error="invalid daemon configuration: native routing cidr must be configured with option 
--ipv4-native-routing-cidr in combination with --enable-ipv4-masquerade --tunnel=disabled --ipam=cluster-pool --enable-ipv4=true" subsys=daemon
#############


#### IPV6 ipv4 2stack

helm install cilium cilium/cilium --version 1.11.0 \
 --namespace kube-system \
 --set debug.enabled=true \
 --set tunnel=disabled \
 --set operator.replicas=1 \
 --set kubeProxyReplacement=strict \
 --set k8sServiceHost=10.211.55.30 \
 --set k8sServicePort=6443 \
 --set ipv6.enabled=true \
 --set ipv4NativeRoutingCIDR=172.200.0.0/16 \
 --set ipam.operator.clusterPoolIPv4PodCIDR=172.200.0.0/16 \
 --set ipam.operator.clusterPoolIPv4MaskSize=26 \
 --set loadBalancer.acceleration=native \
 --set hubble.relay.enabled=true \
 --set hubble.ui.enabled=true 



-- fdb2:2c26:f4e4:0:b1ca:d2d0:e90f:f0f/64 , FDB2:2C26:F4E4:0000:0000:0000:0000:0000 ； FDB2:2C26:F4E4:0000:FFFF:FFFF:FFFF:FFFF
-- fd74:ca9b:0172:0019::/110 ； fd74:ca9b:0172:0019:0000:0000:0000:0000 ；fd74:ca9b:0172:0019:0000:0000:0003:ffff    ； 262,144
-- fd74:ca9b:0172:0018::/110 ； fd74:ca9b:0172:0018:0000:0000:0000:0000  ；fd74:ca9b:0172:0018:0000:0000:0003:ffff   ； 262,144


kubectl exec -it -n kube-system cilium-9b5s2 -- cilium status --verbose
kubectl exec -it -n kube-system cilium-9b5s2 -- cilium service list