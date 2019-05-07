#!/bin/bash
echo "Deploying Prometheus chart using PVC"
helm install --name prometheus stable/prometheus  --set server.persistentVolume.existingClaim=nfs-claim-prometheus --set alertmanager.persistentVolume.existingClaim=nfs-claim-prometheus --set pushgateway.persistentVolume.existingClaim=nfs-claim-prometheus
echo "Exposing Prometheus Server in the port 30090"
kubectl expose deployment prometheus-server --type=NodePort --name=prometheus-server-svc  --target-port=9090 --overrides '{ "apiVersion": "v1","spec":{"ports":[{"port":9090,"protocol":"TCP","targetPort":9090,"nodePort":30090}]}}'
echo "Exposing Prometheus Alertmanager in the port 30093"
kubectl expose deployment prometheus-alertmanager --type=NodePort --name=prometheus-alertmanager-svc --target-port=9093 --overrides '{ "apiVersion": "v1","spec":{"ports":[{"port":9093,"protocol":"TCP","targetPort":9093,"nodePort":30093}]}}'
