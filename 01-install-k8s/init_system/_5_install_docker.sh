# 安装依赖软件包
yum install -y yum-utils device-mapper-persistent-data lvm2

# 添加Docker repository，这里改为国内阿里云yum源
yum-config-manager \
  --add-repo \
  http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
  
# docker version
yum list docker-ce --showduplicates | sort -r

# 安装docker-ce
yum install -y docker-ce-20.10.23-3.el8

## 创建 /etc/docker 目录
mkdir -p /etc/docker

# 配置 daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
}
EOF
#注意，由于国内拉取镜像较慢，配置文件最后追加了阿里云镜像加速配置。

#mkdir -p /etc/systemd/system/docker.service.d

# 重启docker服务
systemctl daemon-reload && systemctl restart docker && systemctl enable docker


///////////////
