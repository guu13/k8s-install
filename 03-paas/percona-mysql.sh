#### 主备 ####
helm repo add percona https://percona.github.io/percona-helm-charts/
helm repo update


helm install percona-server-mysql-operator percona/ps-operator --namespace operator

helm uninstall percona-server-mysql-operator --namespace operator
helm install percona-server-mysql-operator --namespace operator .

helm install my-db percona/ps-db

helm uninstall my-db --namespace operator
helm install my-db  --namespace operator --set backup.enabled=false .
helm uninstall my-db --namespace mysql-db
helm install my-db  --namespace mysql-db --set backup.enabled=false .

### yaml deploy #####
kubectl apply --server-side -f deploy/crd.yaml

kubectl create namespace mysql
kubectl config set-context $(kubectl config current-context) --namespace=mysql

kubectl apply -f deploy/rbac.yaml

kubectl apply -f deploy/operator.yaml

kubectl create -f deploy/secrets.yaml

kubectl apply -f deploy/cr.yaml

kubectl run -i --rm --tty percona-client --image=percona:8.0 --restart=Never -- bash -il
mysql -h cluster1-mysql-primary -uroot -proot_password


#### #### 

ROOT_PASSWORD=$(kubectl -n mysql-db get secrets my-db-ps-db-secrets -o jsonpath="{.data.root}" | base64 --decode)
  kubectl -n mysql-db exec -ti \
    my-db-ps-db-mysql-0 -- mysql -uroot -p"$ROOT_PASSWORD"


select * from performance_schema.replication_group_members;


create database whq ;
use whq;

CREATE TABLE students (  
  id INT PRIMARY KEY,  
  name VARCHAR(50)  
);

INSERT INTO students (id, name) VALUES (5, '张三5');  
INSERT INTO students (id, name) VALUES (6, '李四6');

