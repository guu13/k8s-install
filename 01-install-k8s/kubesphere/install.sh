
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-8.5.2111.repo

yum install socat ipvsadm conntrack timedatex -y


export KKZONE=cn

rm -rf ./kubekey/node*

 ./kk create cluster -f config.yaml


 ./kk delete cluster -f config.yaml