
# 
# 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
#

# cilium-health ip 
kubectl exec -it -n kube-system cilium-g2lwk -- ip netns exec cilium-health ip addr


#### monitor event type ： agent capture debug drop l7 policy-verdict recorder trace

kubectl exec -it -n kube-system cilium-6svpw -- cilium monitor --type trace -vv
kubectl exec -it -n kube-system cilium-6svpw -- cilium monitor -type trace -vv -hex


level=info msg="Initializing dissection cache..." subsys=monitor
Ethernet	{Contents=[..14..] Payload=[..94..] SrcMAC=de:eb:36:0a:d8:21 DstMAC=aa:ab:bb:d3:01:08 EthernetType=IPv4 Length=0}
IPv4	{Contents=[..20..] Payload=[..70..] Version=4 IHL=5 TOS=0 Length=90 Id=42315 Flags=DF FragOffset=0 TTL=63 Protocol=TCP Checksum=42793 SrcIP=172.200.0.112 DstIP=10.211.55.30 Options=[] Padding=[]}
TCP	{Contents=[..32..] Payload=[..38..] SrcPort=39670 DstPort=10250 Seq=3030219 Ack=2007295670 DataOffset=8 FIN=false SYN=false RST=false PSH=true ACK=true URG=false ECE=false CWR=false NS=false Window=502 Checksum=61301 Urgent=0 Options=[TCPOption(NOP:), TCPOption(NOP:), TCPOption(Timestamps:3989597580/3076174462 0xedcc6d8cb75ab27e)] Padding=[]}
  Failed to decode layer: No decoder for layer type Payload
CPU 01: MARK 0xade976e2 FROM 3006 to-stack: 104 bytes (104 captured), state established, , identity 52663->host, orig-ip 0.0.0.0

Failed to decode layer: No decoder for layer type Payload

#### monitor event type ： agent capture debug drop l7 policy-verdict recorder trace



# ipv4 默认是 封装模式（--set tunnel=vxlan ）， 支持 Vxlan 和 Geneve 
# Q: --set bpf.masquerade=true, 跳过 网络协议栈 启用bpf， 
# A: level=info msg="BPF host routing requires enable-bpf-masquerade. Falling back to legacy host routing (enable-host-legacy-routing=true)." subsys=daemon

helm delete cilium -nkube-system 
helm install cilium cilium/cilium --version 1.11.0 \
    --namespace kube-system \
    --set debug.enabled=true \
    --set debug.verbose=datapath \
    --set operator.replicas=1 \
    --set devices=enp0s5 \
    --set bpf.masquerade=true \
    --set kubeProxyReplacement=strict \
    --set sockops.enabled=true \
    --set k8sServiceHost=10.211.55.34 \
    --set k8sServicePort=6443 

# ipv4 native routing ， hybrid 模式
helm delete cilium -nkube-system 
helm install cilium cilium/cilium --version 1.11.1 \
 --namespace kube-system \
 --set debug.enabled=true \
 --set debug.verbose=datapath \
 --set operator.replicas=1 \
 --set devices=enp0s5 \
 --set tunnel=disabled \
 --set autoDirectNodeRoutes=true \
 --set kubeProxyReplacement=strict \
 --set sockops.enabled=true \
 --set loadBalancer.mode=hybrid \
 --set ipv4NativeRoutingCIDR=172.200.0.0/16 \
 --set ipam.operator.clusterPoolIPv4PodCIDR=172.200.0.0/16 \
 --set ipam.operator.clusterPoolIPv4MaskSize=26 \
 --set k8sServiceHost=10.211.55.34 \
 --set k8sServicePort=6443 

# ipv4 native routing ， DSR 模式
helm delete cilium -nkube-system 
helm install cilium cilium/cilium --version 1.11.0 \
 --namespace kube-system \
 --set debug.enabled=true \
 --set operator.replicas=1 \
 --set devices=enp0s5 \
 --set tunnel=disabled \
 --set autoDirectNodeRoutes=true \
 --set kubeProxyReplacement=strict \
 --set loadBalancer.mode=dsr \
 --set ipv4NativeRoutingCIDR=172.200.0.0/16 \
 --set ipam.operator.clusterPoolIPv4PodCIDR=172.200.0.0/16 \
 --set ipam.operator.clusterPoolIPv4MaskSize=26 \
 --set k8sServiceHost=10.211.55.34 \
 --set k8sServicePort=6443 

 # ipv4 native routing ， XDP 模式
helm delete cilium -nkube-system 
helm install cilium cilium/cilium --version 1.11.0 \
 --namespace kube-system \
 --set debug.enabled=true \
 --set operator.replicas=1 \
 --set devices=enp0s5 \
 --set tunnel=disabled \
 --set autoDirectNodeRoutes=true \
 --set kubeProxyReplacement=strict \
 --set loadBalancer.acceleration=native \
 --set loadBalancer.mode=hybrid \
 --set ipv4NativeRoutingCIDR=172.200.0.0/16 \
 --set ipam.operator.clusterPoolIPv4PodCIDR=172.200.0.0/16 \
 --set ipam.operator.clusterPoolIPv4MaskSize=26 \
 --set k8sServiceHost=10.211.55.34 \
 --set k8sServicePort=6443 

 // ### Enable use of per endpoint routes instead of routing via the cilium_host interface.
 --set endpointRoutes.enabled=true \

 ### BPF sockmap支持加速本地进程通信。 可通过选项 --sockops-enable 
 ####  socket options acceleration.
 --set sockops.enabled=true

# hubble
helm upgrade cilium cilium/cilium --version 1.11.0 \
--namespace kube_system \
--reuse-values \



#####   ############# 
--set tunnel=disabled  native routing 模式， 要配置 ipv4NativeRoutingCIDR  \
level=fatal msg="Error while creating daemon" error="invalid daemon configuration: native routing cidr must be configured with option 
--ipv4-native-routing-cidr in combination with --enable-ipv4-masquerade --tunnel=disabled --ipam=cluster-pool --enable-ipv4=true" subsys=daemon
#############


#### IPV6 ipv4 2stack

helm install cilium cilium/cilium --version 1.11.0 \
 --namespace kube-system \
 --set debug.enabled=true \
 --set tunnel=disabled \
 --set operator.replicas=1 \
 --set kubeProxyReplacement=strict \
 --set k8sServiceHost=10.211.55.30 \
 --set k8sServicePort=6443 \
 --set ipv6.enabled=true \
 --set ipv4NativeRoutingCIDR=172.200.0.0/16 \
 --set ipam.operator.clusterPoolIPv4PodCIDR=172.200.0.0/16 \
 --set ipam.operator.clusterPoolIPv4MaskSize=26 \
 --set loadBalancer.acceleration=native \
 --set hubble.relay.enabled=true \
 --set hubble.ui.enabled=true 



-- fdb2:2c26:f4e4:0:b1ca:d2d0:e90f:f0f/64 , FDB2:2C26:F4E4:0000:0000:0000:0000:0000 ； FDB2:2C26:F4E4:0000:FFFF:FFFF:FFFF:FFFF
-- fd74:ca9b:0172:0019::/110 ； fd74:ca9b:0172:0019:0000:0000:0000:0000 ；fd74:ca9b:0172:0019:0000:0000:0003:ffff    ； 262,144
-- fd74:ca9b:0172:0018::/110 ； fd74:ca9b:0172:0018:0000:0000:0000:0000  ；fd74:ca9b:0172:0018:0000:0000:0003:ffff   ； 262,144


kubectl exec -it -n kube-system cilium-9b5s2 -- cilium status --verbose
kubectl exec -it -n kube-system cilium-9b5s2 -- cilium service list