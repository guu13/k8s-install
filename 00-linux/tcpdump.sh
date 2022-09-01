01、抓取所有网络包，并在terminal中显示抓取的结果，将包以十六进制的形式显示。
tcpdump 
02、抓取所有的网络包，并存到 result.cap 文件中。
tcpdump -w result.cap
03、抓取所有的经过eth0网卡的网络包，并存到 result.cap 文件中。
tcpdump -i eth0 -w result.cap
04、抓取源地址是192.168.1.100的包，并将结果保存到 result.cap 文件中。
tcpdump src host 192.168.1.100 -w result.cap 
05、抓取地址包含是192.168.1.100的包，并将结果保存到 result.cap 文件中。
tcpdump host 192.168.1.100 -w result.cap 
06、抓取目的地址包含是192.168.1.100的包，并将结果保存到 result.cap 文件中。
tcpdump dest host 192.168.1.100 -w result.cap 
07、抓取主机地址为 192.168.1.100 的数据包
tcpdump -i eth0 -vnn host 192.168.1.100
08、抓取包含192.168.1.0/24网段的数据包
tcpdump -i eth0 -vnn net 192.168.1.0/24
09、抓取网卡eth0上所有包含端口22的数据包
tcpdump -i eth0 -vnn port 22
10、抓取指定协议格式的数据包，协议格式可以是「udp,icmp,arp,ip」中的任何一种,例如以下命令：
tcpdump udp  -i eth0 -vnn
11、抓取经过 eth0 网卡的源 ip 是 192.168.1.100 数据包，src参数表示源。
tcpdump -i eth0 -vnn src host 192.168.1.100
12、抓取经过 eth0 网卡目的 ip 是 192.168.1.100 数据包，dst参数表示目的。
 tcpdump -i eth0 -vnn dst host 192.168.1.100
13、抓取源端口是22的数据包
tcpdump -i eth0 -vnn src port 22
14、抓取源ip是 192.168.1.100 且目的ip端口是22的数据包
tcpdump -i eth0 -vnn src host 192.168.1.100 and dst port 22
15、抓取源ip是192.168.1.100或者包含端口是22的数据包
tcpdump -i eth0 -vnn src host 192.168.1.100 or port 22
16、抓取源ip是192.168.1.100且端口不是22的数据包
tcpdump -i eth0 -vnn src host 192.168.1.100 and not port 22
17、抓取源ip是192.168.1.100且目的端口是22，或源ip是192.168.1.102且目的端口是80的数据包。
tcpdump -i eth0 -vnn ( src host 192.168.1.100 and dst port 22 ) or ( src host 192.168.1.102 and dst port 80 )
18、把抓取的数据包记录存到/tmp/result文件中，当抓取100个数据包后就退出程序。
tcpdump –i eth0 -vnn -w /tmp/result -c 100
19、从/tmp/result记录中读取tcp协议的数据包
tcpdump -i eth0  tcp  -vnn -r /tmp/result
20、想要截获所有192.168.1.100 的主机收到的和发出的所有的数据包：
tcpdump host 192.168.1.100
21、如果想要获取主机192.168.1.100除了和主机192.168.1.101之外所有主机通信的ip包，使用命令：
tcpdump ip host 192.168.1.100 and ! 192.168.1.101
22、如果想要获取主机 192.168.1.100 接收或发出的 telnet 包，使用如下命令：
tcpdump tcp port 23 host192.168.1.100

