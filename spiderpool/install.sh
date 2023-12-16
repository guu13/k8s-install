kubectl patch crd/spiderippools.spiderpool.spidernet.io -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl patch crd/spidercoordinators.spiderpool.spidernet.io -p '{"metadata":{"finalizers":[]}}' --type=merge

helm repo add spiderpool https://spidernet-io.github.io/spiderpool
helm repo update spiderpool

helm install spiderpool spiderpool/spiderpool --namespace kube-system \
--set multus.multusCNI.defaultCniCRName="macvlan-conf" \
--set global.imageRegistryOverride=ghcr.m.daocloud.io \
--set spiderpoolAgent.loglevel=debug


helm uninstall spiderpool --namespace kube-system
helm install spiderpool --namespace kube-system ./


helm uninstall cilium-chaining --namespace kube-system
helm install cilium-chaining --namespace kube-system ./charts/cilium-chaining/


registry.cn-hangzhou.aliyuncs.com/library/


