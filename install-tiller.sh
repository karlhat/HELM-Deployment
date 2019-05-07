!#/bin/bash
echo "creating serviceaccount tiller"
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
echo "Initiating HELM"
helm init --tiller-image=container-registry.oracle.com/kubernetes_developer/tiller:v2.9.1 --service-account tiller
echo "updating HELM repo"
helm repo update
