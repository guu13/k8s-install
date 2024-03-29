####### ip route get ip 查看到达该ip地址的路由信息
ip route get 111.192.168.101


###### 默认路由（Default route），是对IP数据包中的目的地址找不到存在的其他路由时，路由器所选择的路由。目的地不在路由器的路由表里的所有数据包都会使用默认路由。
#####  这条路由一般会连去另一个路由器，而这个路由器也同样处理数据包: 如果知道应该怎么路由这个数据包，则数据包会被转发到已知的路由；否
#####  则，数据包会被转发到默认路由，从而到达另一个路由器。每次转发，路由都增加了一跳的距离。
ip route : default via 10.211.55.1 dev enp0s5 proto dhcp metric 100 
route -n : 0.0.0.0         10.211.55.1     0.0.0.0         UG    100    0        0 enp0s5
######## 将通向容器ip的请求导向veth： cali69ed1f6eccd ,进而让请求直达容器内的网卡。
10.234.114.101 dev cali69ed1f6eccd scope link 
###### 表示发往192.168.97.0/26网段的报文都会被丢弃且不会回复源端。
####### 配置这条路由的原因是：这台机器上的calico网络可分配的cidr是192.168.97.0/26，容器里访问同网段的其他IP时，配置该路由以避免报文被发到外部。
blackhole 10.234.114.0/24 proto bird 
### 要访问calico网络中的某个网段，需要以对应的node IP为网关，通过eth0发包。也就是说通过这两条路由，可以将部分网段（目的IP）的包经由eth0发送到正确的地方。
10.234.93.0/24 via 10.211.55.52 dev tunl0 proto bird onlink 
