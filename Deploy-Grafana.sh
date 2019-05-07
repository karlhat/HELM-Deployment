#!/bin/bash
echo "Installing grafana using HELM and persistence volumes"
helm install --name grafana stable/grafana  --set persistence.enabled=true --set persistence.existingClaim=nfs-claim-grafana
echo "Exposing Grafana deployment using a Nodeport, the assigned port is 30300"
kubectl expose deployment grafana --type=NodePort --name=grafana-service --target-port=3000 --overrides '{ "apiVersion": "v1","spec":{"ports":[{"port":3000,"protocol":"TCP","targetPort":3000,"nodePort":30300}]}}'
