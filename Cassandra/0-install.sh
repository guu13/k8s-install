https://helm.k8ssandra.io/stable

helm search repo k8ssandra
helm pull k8ssandra/k8ssandra

kubectl create namespace k8ssandra
kubectl create secret generic cassandra-admin-secret --from-literal=username=cassandra-admin --from-literal=password=cassandra-admin-password -n k8ssandra

kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

k8s.gcr.io/kube-state-metrics/kube-state-metrics:v2.2.0
k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.0

docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-webhook-certgen:v1.0
docker pull registry.cn-hangzhou.aliyuncs.com/guu13/kube-state-metrics:v2.2.0


helm delete k8ssandra -n k8ssandra

kubectl create namespace k8ssandra
kubectl create secret generic cassandra-admin-secret --from-literal=username=cassandra-admin --from-literal=password=cassandra-admin-password -n k8ssandra
helm install k8ssandra -n k8ssandra ./

docker load < state-metrics.tar   ==   ctr -n=k8s.io i  import state-metrics.tar


cassandra:
  auth:
    superuser:
      secret: cassandra-admin-secret
  cassandraLibDirVolume:
    storageClass: localpath
  clusterName: multi-cluster
  datacenters:
  - name: dc1
    size: 3
    racks:
    - name: rack1
    - name: rack2
    - name: rack3


docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-webhook-certgen:v1.0
docker pull registry.cn-hangzhou.aliyuncs.com/guu13/kube-state-metrics:v2.2.0
docker pull  docker.io/k8ssandra/cass-operator:v1.10.4
docker pull  stargateio/stargate-4_0:v1.0.52
docker pull  docker.io/alpine:3.12.2
docker pull  docker.io/library/alpine:3.12.2
docker pull  quay.io/kiwigrid/k8s-sidecar:1.14.2
docker pull  grafana/grafana:7.5.11
docker pull  quay.io/prometheus-operator/prometheus-operator:v0.52.0
docker pull  docker.io/k8ssandra/reaper-operator:v0.3.5
docker pull  k8ssandra/cass-management-api:4.0.0-v0.1.37
docker pull  docker.io/datastax/cass-config-builder:1.0.4
docker pull  docker.io/k8ssandra/system-logger:6c64f9c4
docker pull  docker.io/busybox:1.35.0
docker pull  docker.io/thelastpickle/cassandra-reaper:3.1.1
docker pull quay.io/prometheus-operator/prometheus-config-reloader:v0.52.0
docker pull quay.io/prometheus/prometheus:v2.28.1


helm list -n k8ssandra

kubectl get cassandradatacenters -n k8ssandra

-- cassandra-admin-secret
kubectl get secret cassandra-admin-secret -n k8ssandra -o jsonpath="{.data.username}" | base64 --decode ; echo


kubectl get secret cassandra-admin-secret -n k8ssandra  -o jsonpath="{.data.password}" | base64 --decode ; echo

kubectl expose deployment k8ssandra-grafana --type=NodePort --name=grafana-out -n k8ssandra


-- 
kubectl get pods -n k8ssandra -o jsonpath="{.items[*].status.podIP}" --selector cassandra.datastax.com/seed-node=true


nodetool  -u cassandra-admin -pw cassandra-admin-password  status



使用Stargate访问K8ssandra，Springboot整合Cassandra https://zhuanlan.zhihu.com/p/416447262 

Cassandra入门学习 https://blog.csdn.net/qq_44625080/article/details/123608736






gcloud compute networks subnets create dev-k8ssandra-subnet2 --network=dev-k8ssandra-network --range=10.2.0.0/20 --region=us-central1

gcloud beta container clusters create "k8ssandra-2" --region "us-central1" --machine-type "e2-highmem-8" 
--disk-type "pd-standard" --disk-size "100" --num-nodes "1" 
--network dev-k8ssandra-network --subnetwork dev-k8ssandra-subnet2 --node-locations "us-central1-b","us-central1-c","us-central1-f"

gcloud compute firewall-rules create k8ssandra-multi-region-rule --direction=INGRESS 
--network=dev-k8ssandra-network --action=ALLOW --rules=all --source-ranges=10.0.0.0/20,10.2.0.0/20,10.56.0.0/14,10.24.0.0/14





helm delete k91 -n k91
kubectl create namespace k91
kubectl create secret generic cassandra-admin-secret --from-literal=username=cassandra-admin --from-literal=password=cassandra-admin-password -n k91
helm install k91 -n k91 ./



helm install k8ssandra -n k2 ./
kubectl create namespace k2
kubectl create secret generic cassandra-admin-secret --from-literal=username=cassandra-admin --from-literal=password=cassandra-admin-password -n k2
helm install k2 -n k2 ./



----------- podname.clusterID.svcname.namespace.svc.clusterset.local

dig cassandra-0.cassandra.db.svc.cluster.local

dig cassandra.db.svc.clusterset.local

dig cassandra-0.dc3891.cassandra.db.svc.clusterset.local


kubectl run cqlsh --image=nuvo/docker-cqlsh cqlsh cassandra 9042


-----------------


