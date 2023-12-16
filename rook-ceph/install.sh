## 清理 ##
rm -rf /var/lib/rook/
dd if=/dev/zero of="/dev/sdb" bs=1M count=100 oflag=direct,dsync
dd if=/dev/zero of="/dev/sdc" bs=1M count=100 oflag=direct,dsync
dd if=/dev/zero of="/dev/sdd" bs=1M count=100 oflag=direct,dsync


DISK="/dev/sdb"
sgdisk --zap-all $DISK

dd if=/dev/zero of="$DISK" bs=1M count=100 oflag=direct,dsync

blkdiscard $DISK

DISK="/dev/sdc"
sgdisk --zap-all $DISK

dd if=/dev/zero of="$DISK" bs=1M count=100 oflag=direct,dsync

blkdiscard $DISK

DISK="/dev/sdd"
sgdisk --zap-all $DISK

dd if=/dev/zero of="$DISK" bs=1M count=100 oflag=direct,dsync

blkdiscard $DISK


####  ####
registry.k8s.io/sig-storage/csi-attacher:v3.4.0
registry.k8s.io/sig-storage/csi-snapshotter:v6.0.1
registry.k8s.io/sig-storage/csi-resizer:v1.4.0
registry.k8s.io/sig-storage/csi-provisioner:v3.1.0
quay.io/cephcsi/cephcsi:v3.6.2   
quay.io/cephcsi/cephcsi:v3.6.2   
quay.io/ceph/ceph:v16.2.10                                                                                                                                                                                                            
quay.io/ceph/ceph:v16.2.10                                                                                                                                                                                                            
quay.io/ceph/ceph:v16.2.10                                                                                                                                                                                                     
rook/ceph:v1.9.9

docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/csi-attacher:v3.4.0
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/csi-snapshotter:v6.0.1
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/csi-resizer:v1.4.0
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/csi-provisioner:v3.1.0
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/csi-node-driver-registrar:v2.5.1

docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/csi-attacher:v3.4.0 registry.k8s.io/sig-storage/csi-attacher:v3.4.0
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/csi-snapshotter:v6.0.1 registry.k8s.io/sig-storage/csi-snapshotter:v6.0.1
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/csi-resizer:v1.4.0 registry.k8s.io/sig-storage/csi-resizer:v1.4.0 
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/csi-provisioner:v3.1.0 registry.k8s.io/sig-storage/csi-provisioner:v3.1.0
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/csi-node-driver-registrar:v2.5.1 registry.k8s.io/sig-storage/csi-node-driver-registrar:v2.5.1

#########
kubectl apply -f /root/whq/rook-1.9.9/deploy/examples/operator.yaml 
kubectl apply -f /root/whq/rook-1.9.9/deploy/examples/cluster.yaml 

kubectl delete -f /root/whq/rook-1.9.9/deploy/examples/cluster.yaml 

kubectl delete -f /root/whq/rook-1.9.9/deploy/examples/operator.yaml 


kubectl create -f common.yaml
kubectl create -f operator.yaml

// 该条命令执行前可用"kubectl -n rook-ceph get pod"命令查看""rook-ceph-operator "是否已经是running状态了
kubectl create -f cluster.yaml

// 为ceph集群创建一个工具pod，有了该工具pod就可以在该pod里基于该ceoh集群执行ceph相关命令了
kubectl create -f toolbox.yaml

##### label ####### 
kubectl label nodes node1 ceph-mon=enabled
kubectl label nodes node2 ceph-osd=enabled



kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo
