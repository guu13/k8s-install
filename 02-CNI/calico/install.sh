kubectl apply -f https://github.com/projectcalico/calico/blob/master/manifests/calico.yaml
kubectl wait --for=condition=ready -l k8s-app=calico-node  pod -n kube-system 