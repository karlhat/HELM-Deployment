#!/bin/bash
if [ $UID -ne 0 ]
then
  echo "creating serviceaccount tiller"
  kubectl create serviceaccount --namespace kube-system tiller
  echo "Binding the serviceaccount to the admin role called cluster-admin inside the kube-system namespace"
  kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
  echo "Initiating HELM"
  helm init --tiller-image=container-registry.oracle.com/kubernetes_developer/tiller:v2.9.1 --service-account tiller
  echo "updating HELM repo"
  helm repo update
  echo "Updating the tiller-deploy deployment to have the service account"
  kubectl -n kube-system patch deployment tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
else
  echo "Run this script as non-root user"
fi
