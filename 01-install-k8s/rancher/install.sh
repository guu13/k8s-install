docker run -d --restart=unless-stopped --privileged  -p 8080:80 -p 8443:443 rancher/rancher:latest


docker run -d --restart=unless-stopped --privileged  -p 9090:80 -p 9443:443 rancher/rancher:v2.5.12

docker run -dti --restart=unless-stopped --network=host --name rancher -v /data/rancher:/var/lib/rancher/ -v /etc/localtime:/etc/localtime rancher/rancher:stable

docker run --privileged -d --restart=unless-stopped -p 8080:80 -p 8443:443 \
-v /var/lib/rancher:/var/lib/rancher \
-v /var/log/auditlog :/var/log/auditlog \
rancher/rancher:latest




docker run --name rancher -d --restart=unless-stopped --privileged  -p 8080:80 -p 8443:443 -v /var/lib/rancher:/var/lib/rancher rancher/rancher:latest 



docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  -v /root/ssl/rancher.dashena.com.cert.pem:/etc/rancher/ssl/cert.pem \
  -v /root/ssl/rancher.dashena.com.key.pem:/etc/rancher/ssl/key.pem \
  -v /var/lib/rancher:/var/lib/rancher \
  --privileged \
  rancher/rancher:latest \
  --no-cacerts


curl -sfL http://rancher-mirror.cnrancher.com/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -


2.5:
https://rancher.test.dashena.com:8443/     
admin / rancher123456a?

2.6 : 
https://rancher.test.dashena.com:9443/   
user-5s66q / mcx9tfnfhmwv6sdtnztd4wxbhnr5bczhp6fgwb9gfszvhd4pdn8q76


2.5:

https://rancher.test.dashena.com:8443/     
admin / rancher123456a?

2.6 : 
https://rancher.test.dashena.com:9443/   
admin / rancher123456a?