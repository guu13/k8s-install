DOCKER_IMAGE_TAG=v1.16 make docker-cilium-image
DOCKER_IMAGE_TAG=v1.14.5 make docker-operator-generic-image


DOCKER_IMAGE_TAG=v1.16.0 make docker-cilium-image
DOCKER_IMAGE_TAG=v1.16.0 make docker-operator-generic-image


bpf_sock.o:
这段代码是使用Clang编译器来编译一个C语言源文件,并使用LLC编译器将LLVM中间表示(Intermediate Representation,IR)代码转换为目标平台的机器代码。这里涉及的选项和参数解释如下: 

1. clang: 这是调用Clang编译器的命令。
2. 参数-DENABLE_IPV4=1 -DENABLE_IPV6=1 ...: 这些是预处理器定义,用于在编译时设置各种选项。例如,ENABLE_IPV4和ENABLE_IPV6可能启用IPv4和IPv6支持。
3. -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf: 这两个-I标志指定了包含文件(header files)的搜索路径。编译器会在这些路径下查找需要的头文件。
4. -D__NR_CPUS__=8: 这个预处理器定义设置了可用的CPU核心数量。
5. -O2: 这是一个优化级别,其中-O2表示进行中级优化。
6. -g: 这个标志告诉编译器生成带有调试信息的代码。
7. --target=bpf: 这个标志告诉编译器生成BPF代码。
8. -std=gnu89: 这个标志设置C语言标准为GNU 89,这意味着它使用的是C89标准并启用了一些GNU特定的扩展。
9. -nostdinc: 这个标志告诉编译器不要使用标准库的默认包含路径。
10. -emit-llvm: 这个标志告诉编译器输出LLVM中间表示而不是汇编或机器代码。
11. -Wall -Wextra -Werror -Wshadow ...: 这些是编译器警告选项,用于检测代码中的潜在问题。
12. -c bpf_sock.c -o bpf_sock.ll: 这将C源文件bpf_sock.c编译为LLVM中间表示文件bpf_sock.ll。

13. llc -march=bpf -mcpu=v3 -filetype=obj -o bpf_sock.o bpf_sock.ll: 这是使用LLC编译器将LLVM中间表示文件转换为目标平台的机器代码对象文件(.o文件)。这里的选项指定目标架构为BPF、目标CPU为v3等。

总结起来,这段代码使用Clang编译器编译C源文件,生成LLVM中间表示文件,然后使用LLC编译器将中间表示转换为目标平台的机器代码对象文件。这通常用于底层系统编程或低级开发,特别是在BPF(Berkeley Packet Filter)环境中。

clang -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_ROUTING=1 -DPOLICY_VERDICT_NOTIFY=1 -DALLOW_ICMP_FRAG_NEEDED=1 -DENABLE_IDENTITY_MARK=1 -DMONITOR_AGGREGATION=3 -DCT_REPORT_FLAGS=0x0002 
      -DENABLE_HOST_FIREWALL=1 -DENABLE_ICMP_RULE=1 -DENABLE_CUSTOM_CALLS=1 -DENABLE_SRV6=1 -DENABLE_L7_LB=1 -DENABLE_MASQUERADE_IPV4=1 
      -DENABLE_MASQUERADE_IPV6=1 -DENABLE_SRC_RANGE_CHECK=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 
      -DENABLE_DSR_ICMP_ERRORS=1 -DENABLE_DSR=1 -DENABLE_DSR_HYBRID=1 -DENABLE_IPV4_FRAGMENTS=1 -DENABLE_BANDWIDTH_MANAGER=1 
      -DENABLE_EGRESS_GATEWAY=1 -DENABLE_VTEP=1 -DENABLE_TPROXY=1 -DENABLE_HOST_ROUTING=1 -DETH_HLEN=0 -DENABLE_NAT_46X64=1 -DENABLE_NAT_46X64_GATEWAY=1 
      -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1 
      -I/home/barry/work/code/cilium/cilium/bpf/include 
      -I/home/barry/work/code/cilium/cilium/bpf 
      -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm 
      -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough 
      -c bpf_sock.c -o bpf_sock.ll
llc -march=bpf -mcpu=v3 -filetype=obj -o bpf_sock.o bpf_sock.ll



"[-DENABLE_IPV4=1 ]"; 
    clang -DENABLE_IPV4=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV4=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 ]"; 
    clang -DENABLE_IPV4=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV4=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_IPV4_FRAGMENTS=1 ]"; 
    clang -DENABLE_IPV4=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_IPV4_FRAGMENTS=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV6=1 ]"; 
    clang -DENABLE_IPV6=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 ]";
    clang -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 ]";
    clang -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 ]"; 
    clang -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 ]"; 
    clang -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 ]"; 
    clang -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 ]"; 
    clang -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_L7_LB=1 ]"; 
    clang -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_L7_LB=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_L7_LB=1 -DENABLE_EGRESS_GATEWAY=1 -DENABLE_MASQUERADE_IPV4=1 -DENABLE_MASQUERADE_IPV6=1 ]"; 
    clang -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_L7_LB=1 -DENABLE_EGRESS_GATEWAY=1 -DENABLE_MASQUERADE_IPV4=1 -DENABLE_MASQUERADE_IPV6=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV4=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 ]"; 
    clang -DENABLE_IPV4=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV4=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_L7_LB=1 ]"; 
    clang -DENABLE_IPV4=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_L7_LB=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;   
" [-DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 ]"; 
    clang -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_SRC_RANGE_CHECK=1 ]"; 
    clang -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_SRC_RANGE_CHECK=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 ]"; 
    clang -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 ]"; 
    clang -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1 ]"; 
    clang -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1 -DENABLE_SOCKET_LB_HOST_ONLY=1 ]"; 
    clang -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1 -DENABLE_SOCKET_LB_HOST_ONLY=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1 -DENABLE_SOCKET_LB_HOST_ONLY=1 -DENABLE_L7_LB=1 -DENABLE_SCTP=1 ]"; 
    clang -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1 -DENABLE_SOCKET_LB_HOST_ONLY=1 -DENABLE_L7_LB=1 -DENABLE_SCTP=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;   
" [-DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1 -DENABLE_SOCKET_LB_HOST_ONLY=1 -DENABLE_L7_LB=1 -DENABLE_SCTP=1 -DENABLE_VTEP=1 ]"; 
    clang -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1 -DENABLE_SOCKET_LB_HOST_ONLY=1 -DENABLE_L7_LB=1 -DENABLE_SCTP=1 -DENABLE_VTEP=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_DSR=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_GENEVE=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1 -DENABLE_SOCKET_LB_HOST_ONLY=1 -DENABLE_L7_LB=1 -DENABLE_SCTP=1 -DENABLE_HIGH_SCALE_IPCACHE=1 -DDSR_ENCAP_IPIP=2]"; 
    clang -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_DSR=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_GENEVE=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1 -DENABLE_SOCKET_LB_HOST_ONLY=1 -DENABLE_L7_LB=1 -DENABLE_SCTP=1 -DENABLE_HIGH_SCALE_IPCACHE=1 -DDSR_ENCAP_IPIP=2 -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1 -DENABLE_SOCKET_LB_HOST_ONLY=1 -DENABLE_L7_LB=1 -DENABLE_SCTP=1 -DENABLE_VTEP=1 -DENABLE_CLUSTER_AWARE_ADDRESSING=1 -DENABLE_INTER_CLUSTER_SNAT=1 ]"; 
    clang -DENABLE_IPV6=1 -DENCAP_IFINDEX=1 -DTUNNEL_MODE=1 -DENABLE_NODEPORT=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_SESSION_AFFINITY=1 -DENABLE_BANDWIDTH_MANAGER=1 -DENABLE_SRC_RANGE_CHECK=1 -DLB_SELECTION=1 -DLB_SELECTION_MAGLEV=1 -DENABLE_SOCKET_LB_HOST_ONLY=1 -DENABLE_L7_LB=1 -DENABLE_SCTP=1 -DENABLE_VTEP=1 -DENABLE_CLUSTER_AWARE_ADDRESSING=1 -DENABLE_INTER_CLUSTER_SNAT=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_DSR=1 -DFROM_HOST=1 ]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_DSR=1 -DFROM_HOST=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_MASQUERADE_IPV4=1 -DENABLE_MASQUERADE_IPV6=1 ]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_MASQUERADE_IPV4=1 -DENABLE_MASQUERADE_IPV6=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_WIREGUARD=1 -DENABLE_NODEPORT=1 -DENABLE_MASQUERADE_IPV4=1 -DENABLE_MASQUERADE_IPV6=1 ]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_WIREGUARD=1 -DENABLE_NODEPORT=1 -DENABLE_MASQUERADE_IPV4=1 -DENABLE_MASQUERADE_IPV6=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 ]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DENABLE_DSR_HYBRID=1 ]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DENABLE_DSR_HYBRID=1  -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DENABLE_DSR_HYBRID=1 -DTUNNEL_MODE=1 -DTUNNEL_PROTOCOL=TUNNEL_PROTOCOL_VXLAN]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DENABLE_DSR_HYBRID=1 -DTUNNEL_MODE=1 -DTUNNEL_PROTOCOL=TUNNEL_PROTOCOL_VXLAN -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DENABLE_DSR_HYBRID=1 -DTUNNEL_MODE=1 -DTUNNEL_PROTOCOL=TUNNEL_PROTOCOL_GENEVE]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DENABLE_DSR_HYBRID=1 -DTUNNEL_MODE=1 -DTUNNEL_PROTOCOL=TUNNEL_PROTOCOL_GENEVE -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_NONE=1 -DDSR_ENCAP_IPIP=2]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_NONE=1 -DDSR_ENCAP_IPIP=2 -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_IPIP=1 -DDSR_ENCAP_NONE=2]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_IPIP=1 -DDSR_ENCAP_NONE=2 -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_GENEVE=1 -DDSR_ENCAP_IPIP=2]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_GENEVE=1 -DDSR_ENCAP_IPIP=2 -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DENABLE_CAPTURE=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_NONE=1 -DDSR_ENCAP_IPIP=2]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DENABLE_CAPTURE=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_NONE=1 -DDSR_ENCAP_IPIP=2 -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DENABLE_CAPTURE=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_IPIP=1 -DENABLE_SCTP=1 -DDSR_ENCAP_NONE=2]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DENABLE_CAPTURE=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_IPIP=1 -DENABLE_SCTP=1 -DDSR_ENCAP_NONE=2 -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll;    
" [-DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DENABLE_CAPTURE=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_GENEVE=1 -DENABLE_SCTP=1 -DDSR_ENCAP_IPIP=2]"; 
    clang -DDISABLE_LOOPBACK_LB=1 -DENABLE_NODEPORT_ACCELERATION=1 -DENABLE_IPV4=1 -DENABLE_IPV6=1 -DENABLE_NODEPORT=1 -DENABLE_DSR=1 -DENABLE_CAPTURE=1 -DDSR_ENCAP_MODE=1 -DDSR_ENCAP_GENEVE=1 -DENABLE_SCTP=1 -DDSR_ENCAP_IPIP=2 -I/home/barry/work/code/cilium/cilium/bpf/include -I/home/barry/work/code/cilium/cilium/bpf -D__NR_CPUS__=8 -O2 -g --target=bpf -std=gnu89 -nostdinc -emit-llvm -Wall -Wextra -Werror -Wshadow -Wno-address-of-packed-member -Wno-unknown-warning-option -Wno-gnu-variable-sized-type-not-at-end -Wdeclaration-after-statement -Wimplicit-int-conversion -Wenum-conversion -Wimplicit-fallthrough -c bpf_xdp.c -o bpf_xdp.ll; 
    llc -march=bpf -mcpu=v3 -o /dev/null bpf_xdp.ll; 