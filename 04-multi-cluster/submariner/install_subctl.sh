curl https://get.submariner.io | VERSION=0.10.1 bash


export PATH=$PATH:/root/.local/bin

// 隧道ping通， curl tcp http 不通 ethtool  -K vx-submariner tx-checksum-ip-generic off

apiVersion: crd.projectcalico.org/v1
kind: IPPool
metadata:
  name: default-ipv4-ippool-add2
spec:
  cidr: 242.0.0.0/8
  disabled: true
  natOutgoing: false


gateway.submariner.io/public-ip: ipv4:10.49.38.74

gateway.submariner.io/public-ip: ipv4:10.49.38.77



------------  golobal net ----------------------------
subctl deploy-broker --globalnet --operator-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 

subctl join broker-info.subm --globalnet --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid west

subctl join broker-info.subm --globalnet --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid east

subctl join broker-info.subm --globalnet --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid north

------------  none golobal net ----------------------------
subctl deploy-broker  --operator-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 

subctl join broker-info.subm  --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid east

subctl join broker-info.subm  --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid west

subctl join broker-info.subm  --operator-debug --pod-debug --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid north

--------------------  health-check=false   ----------------------

subctl deploy-broker --operator-debug health-check=false --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 

subctl join broker-info.subm --operator-debug --pod-debug --health-check=false  --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid east

subctl join broker-info.subm --operator-debug --pod-debug  --health-check=false --repository registry.cn-hangzhou.aliyuncs.com/submariner --version 0.13.0 --clusterid west

-----------------       --health-check      ----------------------

kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-operator:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-route-agent:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-gateway:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/lighthouse-coredns:0.13.0 --name east
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/lighthouse-agent:0.13.0 --name east

kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-operator:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-route-agent:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/submariner-gateway:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/lighthouse-coredns:0.13.0 --name west
kind load docker-image registry.cn-hangzhou.aliyuncs.com/submariner/lighthouse-agent:0.13.0 --name west


kind load docker-image quay.io/submariner/submariner-operator:0.13.0 --name broker

kind load docker-image registry.cn-hangzhou.aliyuncs.com/google_samples_thepoy/cassandra:v13 --name east

kind load docker-image  tutum/dnsutils:latest --name 

gateway.submariner.io/public-ip: ipv4:172.18.0.5




-----

docker save -o registry.cn-beijing.aliyuncs.com/kubesphereio/kube-controllers:v3.23.2
docker save -o registry.cn-beijing.aliyuncs.com/kubesphereio/kube-apiserver:v1.23.8
docker save -o registry.cn-beijing.aliyuncs.com/kubesphereio/kube-proxy:v1.23.8
docker save -o registry.cn-beijing.aliyuncs.com/kubesphereio/kube-controller-manager   v1.23.8   2b7c5a039984   2 months ago    125MB
docker save -o registry.cn-beijing.aliyuncs.com/kubesphereio/kube-scheduler            v1.23.8   afd180ec7435   2 months ago    53.5MB
docker save -o registry.cn-beijing.aliyuncs.com/kubesphereio/coredns                   1.8.6     a4ca41631cc7   10 months ago   46.8MB
docker save -o registry.cn-beijing.aliyuncs.com/kubesphereio/pause                     3.6       6270bb605e12   12 months ago   683kB
docker save -o registry.cn-beijing.aliyuncs.com/kubesphereio/etcd                      v3.4.13   d1985d404385   24 months ago   83.8MB
docker save -o registry.cn-beijing.aliyuncs.com/kubesphereio/k8s-dns-node-cache        1.15.12   5340ba194ec9   2 years ago     107MB



---------



kubectl taint node --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane-


