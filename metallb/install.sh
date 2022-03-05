helm repo add metallb https://metallb.github.io/metallb


helm delete metallb -nkube-system 
helm install -nkube-system  metallb metallb/metallb -f values.yaml