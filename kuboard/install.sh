sudo docker run -d \
  --restart=unless-stopped \
  --name=kuboard \
  -p 80:80/tcp \
  -p 10081:10081/tcp \
  -e KUBOARD_ENDPOINT="http://10.211.55.34:80" \
  -e KUBOARD_AGENT_SERVER_TCP_PORT="10081" \
  -v /tmp/kuboard-data:/data \
  swr.cn-east-2.myhuaweicloud.com/kuboard/kuboard:v3


用户名： admin
密码： Kuboard123



  https://github.91chi.fun//https://github.com//vmware-tanzu/octant/releases/download/v0.25.0/octant_0.25.0_Linux-64bit.deb





  https://github.91chi.fun//https://github.com/guu13/k8s-install.git

https://github.91chi.fun//https://github.com/cilium/hubble/releases/download/v0.9.0/hubble-linux-amd64.tar.gz