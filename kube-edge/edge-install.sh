./keadm init --advertise-address=124.70.53.45 --kube-config=$HOME/.kube/config --kubeedge-version=1.8.2


./keadm join --cloudcore-ipport=124.70.53.45:10000 --kubeedge-version=1.8.2 --token=d850152dbdeeafb248a0b133d0cf00542119255d462baa14fa8ded1f98447be0.eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NDAwMTI0NDh9.OoXcxzaSm5S4n1RUhGVFk1_BfMml-rxGkgj4dy6T1sY





kubectl apply -f https://raw.githubusercontent.com/kubeedge/kubeedge/release-1.8/build/crds/devices/devices_v1alpha2_device.yaml
kubectl apply -f https://raw.githubusercontent.com/kubeedge/kubeedge/release-1.8/build/crds/devices/devices_v1alpha2_devicemodel.yaml
kubectl apply -f https://raw.githubusercontent.com/kubeedge/kubeedge/release-1.8/build/crds/reliablesyncs/cluster_objectsync_v1alpha1.yaml
kubectl apply -f https://raw.githubusercontent.com/kubeedge/kubeedge/release-1.8/build/crds/reliablesyncs/objectsync_v1alpha1.yaml


#keadm
nohup cloudcore  > cloudcore.log 2>&1 &

systemctl restart edgecore


# 二进制
# cloud server
nohup ./cloudcore --config cloudcore.yaml > cloudcore.log 2>&1 &

# worker edge 
nohup ./edgecore --config edgecore.yaml > edgecore.log 2>&1 &




echo ODEzNTZjY2MwODIzMmIxMTU0Y2ExYmI5MmRlZjY4YWQwMGQ3ZDcwOTIzYmU3YjcyZWZmOTVlMTdiZTk5MzdkNS5leUpoYkdjaU9pSklVekkxTmlJc0luUjVjQ0k2SWtwWFZDSjkuZXlKbGVIQWlPakUxT0RreE5qRTVPRGw5LmpxNENXNk1WNHlUVkpVOWdBUzFqNkRCdE5qeVhQT3gxOHF5RnFfOWQ4WFkK |base64 -d
# then we get:
81356ccc08232b1154ca1bb92def68ad00d7d70923be7b72eff95e17be9937d5.eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODkxNjE5ODl9.jq4CW6MV4yTVJU9gAS1j6DBtNjyXPOx18qyFq_9d8XY
