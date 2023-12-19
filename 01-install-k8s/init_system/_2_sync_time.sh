# 安装chrony：
yum install -y chrony
cp /etc/chrony.conf{,.bak}
# 注释默认ntp服务器
sed -i 's/^server/#&/' /etc/chrony.conf
# 指定上游公共 ntp 服务器
cat >> /etc/chrony.conf << EOF
server 0.asia.pool.ntp.org iburst
server 1.asia.pool.ntp.org iburst
server 2.asia.pool.ntp.org iburst
server 3.asia.pool.ntp.org iburst
EOF

# 设置时区
timedatectl set-timezone Asia/Shanghai
# 重启chronyd服务并设为开机启动：
systemctl enable chronyd && systemctl restart chronyd

#验证,查看当前时间以及存在带*的行
timedatectl && chronyc sources

