---- install.sh

###### 非 root 用户 ###########
sudo groupadd docker     #添加docker用户组
sudo gpasswd -a $USER docker     #将登陆用户加入到docker用户组中
newgrp docker     #更新用户组

###############3333

docker rmi $(docker images | grep "none" | awk '{print $3}') 

删除查询到的镜像
docker rmi $(docker image ls -a -q)


###################### non root docker #############

#创建docker组
sudo groupadd docker
#将当前用户加入docker组
sudo gpasswd -a broker docker
#重新启动docker服务
sudo service docker restart
# 设定用户
newgrp docker
# 当前用户包含docker即可操作
groups


