-- 配置对方的 svc 和 pod

cat > svcwestcluster.yaml <<EOF
  apiVersion: projectcalico.org/v3
  kind: IPPool
  metadata:
    name: svcwestcluster
  spec:
    cidr: 172.233.0.0/18
    natOutgoing: false
    disabled: true
  EOF

  cat > podwestcluster.yaml <<EOF
  apiVersion: projectcalico.org/v3
  kind: IPPool
  metadata:
    name: podwestcluster
  spec:
    cidr: 172.233.64.0/18
    natOutgoing: false
    disabled: true
  EOF

DATASTORE_TYPE=kubernetes KUBECONFIG=~/.kube/config  calicoctl create -f svccluster2.yaml
DATASTORE_TYPE=kubernetes KUBECONFIG=~/.kube/config  calicoctl create -f podcluster2.yaml
