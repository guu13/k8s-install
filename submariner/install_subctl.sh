curl https://get.submariner.io | VERSION=0.10.1 bash


export PATH=$PATH:/root/.local/bin



apiVersion: crd.projectcalico.org/v1
kind: IPPool
metadata:
  name: default-ipv4-ippool-add2
spec:
  cidr: 242.0.0.0/8
  disabled: true
  natOutgoing: false


gateway.submariner.io/public-ip: ipv4:10.49.38.74


subctl join broker-info.subm --clusterid 3874 --globalnet


