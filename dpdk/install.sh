https://www.jianshu.com/p/61c855582921

https://www.cnblogs.com/wt11/p/15417103.html

export RTE_SDK=/root/dpdk-stable-19.11.14/
export RTE_TARGET=x86_64-native-linux-gcc 
export RTE_TARGET=x86_64-native-linuxapp-gcc 


[root@bitway l3fwd]# cat /etc/default/grub 
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="crashkernel=auto resume=UUID=d37b2443-dee6-4145-a2e8-5aa02d7be110 rd.lvm.lv=centos/swap rhgb quiet console=ttyS0,115200 default_hugepagesz=1G hugepagesz=1G hugepages=4"
GRUB_DISABLE_RECOVERY="true"
GRUB_ENABLE_BLSCFG=true