#由于官方源国内无法访问，这里使用阿里云yum源进行替换：
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

yum list kubeadm --showduplicates | sort -r


#安装kubeadm、kubelet、kubectl,注意这里默认安装当前最新版本v1.14.1:
yum remove -y kubeadm kubelet kubectl 
yum install -y kubeadm-1.20.10 kubelet-1.20.10 kubectl-1.20.10
systemctl enable kubelet && systemctl start kubelet



gemfield@master:~$ sudo apt-get update && sudo apt-get install -y ca-certificates curl software-properties-common apt-transport-https curl
gemfield@master:~$ curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -

gemfield@master:~$ sudo tee /etc/apt/sources.list.d/kubernetes.list <<EOF 
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

gemfield@master:~$ sudo apt-get update
gemfield@master:~$ sudo apt-get install -y kubelet kubeadm kubectl
gemfield@master:~$ sudo apt-mark hold kubelet kubeadm kubectl