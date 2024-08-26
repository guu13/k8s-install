

online:   https://appscode.com/issue-license

https://github.com/bytebuilders/offline-license-server#api-reference

###  cluster ####
kubectl get ns kube-system -o=jsonpath='{.metadata.uid}'

offline-license-server issue-full-license \
  --email=52shisan99@163.com \
  --name=barrywang \
  --product=dashen \
  --cluster=03a5824f-1a10-419b-9bbf-40954b2b7fc9 \
  --expiry-date=2030-12-31 \
  --duration=P1Y

# --duration flag used https://pkg.go.dev/github.com/rickb777/date/period for parsing duration.


helm uninstall kubedb -n kubedb
kubectl get crd -o name | grep kubedb.com | xargs kubectl delete

  helm install kubedb oci://ghcr.io/appscode-charts/kubedb \
  --version v2024.2.14 \
  --namespace kubedb --create-namespace \
  --set-file global.license=/root/operator/kubedb/license.txt \
  --wait --burst-limit=10000 --debug

  

helm install kubedb oci://ghcr.io/appscode-charts/kubedb \
  --version v2023.12.28 \
  --namespace kubedb --create-namespace \
  --set-file global.license=/root/operator/kubedb/license.txt \
  --wait --burst-limit=10000 --debug