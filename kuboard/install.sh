sudo docker run -d \
  --restart=unless-stopped \
  --name=kuboard \
  -p 8080:80/tcp \
  -p 10081:10081/tcp \
  -e KUBOARD_ENDPOINT="http://rancher.test.dashena.com:8080" \
  -e KUBOARD_AGENT_SERVER_TCP_PORT="10081" \
  -v /var/lib/kuboard:/data \
  swr.cn-east-2.myhuaweicloud.com/kuboard/kuboard:v3


sudo docker run -d \
  --restart=unless-stopped \
  --name=kuboard \
  -p 9080:80/tcp \
  -p 10081:10081/tcp \
  -e KUBOARD_ENDPOINT="http://barry.org:9080" \
  -e KUBOARD_AGENT_SERVER_TCP_PORT="10081" \
  -v /var/lib/kuboard:/data \
  swr.cn-east-2.myhuaweicloud.com/kuboard/kuboard:v3


用户名： admin
密码： Kuboard123


