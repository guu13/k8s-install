#配置主机名
hostnamectl set-hostname $1
#修改/etc/hosts
cat >> /etc/hosts << EOF
192.168.0.190 dmz-pi
192.168.0.191 k8s-191
192.168.0.192 k8s-192
192.168.0.193 k8s-193
192.168.0.194 k8s-194
192.168.0.195 k8s-195
EOF

# 开启firewalld防火墙并允许所有流量
systemctl stop firewalld && systemctl disable firewalld
# 关闭selinux
sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /etc/selinux/config && setenforce 0

#关闭swap
swapoff -a
yes | cp /etc/fstab /etc/fstab_bak
cat /etc/fstab_bak | grep -v swap > /etc/fstab
