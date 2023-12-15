ib_write_bw -R  -d rxe_55 -a -F
ib_write_bw -R  -d rxe_55 -i 1 10.211.55.97 -n 1000 -a -F


// https://blog.csdn.net/qq_41596356/article/details/128150563
ib_send_bw -d rxe_55
ib_send_bw -d rxe_0 10.211.55.97


soft-RoCE:

rdma link add rxe_55 type rxe netdev enp0s5
rdma link add rxe_129 type rxe netdev enp0s6
rdma link add rxe_132 type rxe netdev enp0s7


nmcli con add con-name enp0s6 type ethernet ifname enp0s6
nmcli con add con-name enp0s7 type ethernet ifname enp0s7