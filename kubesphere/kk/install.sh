docker load <  haproxy.tar 
docker load < kube-apiserver.tar 
docker load < kube-controller-manager.tar 
docker load < kube-proxy.tar 
docker load < kube-scheduler.tar 
docker load < coredns.tar 
docker load < pause.tar 
docker load < node.tar 
docker load < pod2daemon-flexvol.tar 
docker load < cni.tar 
docker load < kube-controllers.tar 
docker load < etcd.tar 
docker load < k8s-dns-node-cache.tar 


docker pull  docker.io/calico/cni:v3.21.4
docker pull  docker.io/calico/pod2daemon-flexvol:v3.21.4
docker pull  docker.io/calico/node:v3.21.4
docker pull  docker.io/calico/kube-controllers:v3.21.4