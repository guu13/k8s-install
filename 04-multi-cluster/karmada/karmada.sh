

curl -o /tmp/karmada-dashboard.yaml https://raw.githubusercontent.com/karmada-io/dashboard/main/deploy/karmada-dashboard.yaml
curl -o /tmp/karmada-dashboard-role.yaml https://raw.githubusercontent.com/karmada-io/dashboard/main/deploy/karmada-dashboard-role.yaml

export KUBECONFIG="$HOME/.kube/config" 
kubectl config use-context kubernetes

kubectl delete -f /tmp/karmada-dashboard.yaml
kubectl apply -f /tmp/karmada-dashboard.yaml


export KUBECONFIG="$HOME/.kube/karmada-apiserver.config"
kubectl config use-context karmada-apiserver

kubectl delete -f  /tmp/karmada-dashboard-role.yaml
kubectl apply -f   /tmp/karmada-dashboard-role.yaml


kubectl -n karmada-system get secret $(kubectl -n karmada-system get sa/karmada-dashboard -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"



##################

Local Karmada is running.

To start using your karmada, run:
  export KUBECONFIG="$HOME/.kube/karmada.config"
Please use 'kubectl config use-context karmada-host/karmada-apiserver' to switch the host and control plane cluster.


kubectl config use-context karmada-host
kubectl config use-context karmada-apiserver

To manage your member clusters, run:
  export KUBECONFIG="$HOME/.kube/members.config"
Please use 'kubectl config use-context member1/member2/member3' to switch to the different member cluster.


################################# 

kuse kind-member3

kubectl create ns karmada-system
kubectl delete secret karmada-kubeconfig  -n karmada-system                  
kubectl create secret generic karmada-kubeconfig --from-file=karmada-kubeconfig=./karmada-apiserver.config  -n karmada-system                  

MEMBER_CLUSTER_NAME="member2"
sed -i "s/{member_cluster_name}/${MEMBER_CLUSTER_NAME}/g" karmada-agent.yaml
kubectl apply -f karmada-agent.yaml


--------------

------------------------------------------------------------------------------------------------------
 █████   ████   █████████   ███████████   ██████   ██████   █████████   ██████████     █████████
░░███   ███░   ███░░░░░███ ░░███░░░░░███ ░░██████ ██████   ███░░░░░███ ░░███░░░░███   ███░░░░░███
 ░███  ███    ░███    ░███  ░███    ░███  ░███░█████░███  ░███    ░███  ░███   ░░███ ░███    ░███
 ░███████     ░███████████  ░██████████   ░███░░███ ░███  ░███████████  ░███    ░███ ░███████████
 ░███░░███    ░███░░░░░███  ░███░░░░░███  ░███ ░░░  ░███  ░███░░░░░███  ░███    ░███ ░███░░░░░███
 ░███ ░░███   ░███    ░███  ░███    ░███  ░███      ░███  ░███    ░███  ░███    ███  ░███    ░███
 █████ ░░████ █████   █████ █████   █████ █████     █████ █████   █████ ██████████   █████   █████
░░░░░   ░░░░ ░░░░░   ░░░░░ ░░░░░   ░░░░░ ░░░░░     ░░░░░ ░░░░░   ░░░░░ ░░░░░░░░░░   ░░░░░   ░░░░░
------------------------------------------------------------------------------------------------------
Karmada is installed successfully.

Register Kubernetes cluster to Karmada control plane.

Register cluster with 'Push' mode

Step 1: Use kubectl karmada join to register the cluster to Karmada control panel. --cluster-kubeconfig is members kubeconfig.
(In karmada)~# MEMBER_CLUSTER_NAME=`cat ~/.kube/config  | grep current-context | sed 's/: /\n/g'| sed '1d'`
(In karmada)~# kubectl karmada --kubeconfig /etc/karmada/karmada-apiserver.config  join ${MEMBER_CLUSTER_NAME} --cluster-kubeconfig=$HOME/.kube/config

Step 2: Show members of karmada
(In karmada)~# kubectl  --kubeconfig /etc/karmada/karmada-apiserver.config get clusters


Register cluster with 'Pull' mode

Step 1:  Send karmada kubeconfig and karmada-agent.yaml to member kubernetes
(In karmada)~# scp /etc/karmada/karmada-apiserver.config /etc/karmada/karmada-agent.yaml {member kubernetes}:~

Step 2:  Create karmada kubeconfig secret
 Notice:
   Cross-network, need to change the config server address.
(In member kubernetes)~#  kubectl create ns karmada-system
(In member kubernetes)~#  kubectl create secret generic karmada-kubeconfig --from-file=karmada-kubeconfig=/root/karmada-apiserver.config  -n karmada-system

Step 3: Create karmada agent
(In member kubernetes)~#  MEMBER_CLUSTER_NAME="demo"
(In member kubernetes)~#  sed -i "s/{member_cluster_name}/${MEMBER_CLUSTER_NAME}/g" karmada-agent.yaml
(In member kubernetes)~#  kubectl create -f karmada-agent.yaml

Step 4: Show members of karmada
(In karmada)~# kubectl  --kubeconfig /etc/karmada/karmada-apiserver.config get clusters