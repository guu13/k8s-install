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

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.cloud.aliyuncs.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=http://mirrors.cloud.aliyuncs.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF


yum list kubeadm --showduplicates | sort -r


#安装kubeadm、kubelet、kubectl,注意这里默认安装当前最新版本v1.14.1:
dnf remove -y kubeadm kubelet kubectl 
dnf install -y kubeadm-1.26.7 kubelet-1.26.7 kubectl-1.26.7
systemctl enable kubelet && systemctl start kubelet

dnf install -y kubeadm-1.23.17 kubelet-1.23.17 kubectl-1.23.17
systemctl enable kubelet && systemctl start kubelet


########## ubuntu ###########
### https://www.jianshu.com/p/4d696c8a6f41

#禁用默认配置的iptables防火墙服务
ufw disable
#ufw查看当前的防火墙状态：inactive状态是防火墙关闭状态 active是开启状态。
ufw status


# 关闭selinux
sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /etc/selinux/config && setenforce 0

#关闭swap
swapoff -a
yes | cp /etc/fstab /etc/fstab_bak
cat /etc/fstab_bak | grep -v swap > /etc/fstab


cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

# 手动加载模块
sudo modprobe overlay
sudo modprobe br_netfilter

# 设置所需的 sysctl 参数，参数在重新启动后保持不变
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# 应用 sysctl 参数而不重新启动
sudo sysctl --system

#安装ipset和ipvsadm：
apt install -y ipset ipvsadm

### 开启ipvs 转发
sudo modprobe br_netfilter 

# 配置加载模块
cat > /etc/modules-load.d/ipvs.conf << EOF
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack
EOF

# 临时加载
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack

# 开机加载配置，将ipvs相关模块加入配置文件中
cat >> /etc/modules <<EOF
ip_vs_sh
ip_vs_wrr
ip_vs_rr
ip_vs
nf_conntrack
EOF


apt-get update && apt-get install -y apt-transport-https
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

# 查看版本
apt-cache madison kubeadm|head

apt-get update
apt-get remove -y kubeadm kubelet kubectl 
apt-get install kubelet=1.23.17-00 kubeadm=1.23.17-00 kubectl=1.23.17-00





