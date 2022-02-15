sudo docker run -d \
  --restart=unless-stopped \
  --name=kuboard \
  -p 80:80/tcp \
  -p 10081:10081/tcp \
  -e KUBOARD_ENDPOINT="http://10.211.55.34:80" \
  -e KUBOARD_AGENT_SERVER_TCP_PORT="10081" \
  -v /root/kuboard-data:/data \
  swr.cn-east-2.myhuaweicloud.com/kuboard/kuboard:v3


用户名： admin
密码： Kuboard123



  https://github.91chi.fun//https://github.com//vmware-tanzu/octant/releases/download/v0.25.0/octant_0.25.0_Linux-64bit.deb