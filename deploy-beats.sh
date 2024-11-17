#!/bin/bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install kube-state-metrics prometheus-community/kube-state-metrics --version 5.27.0 --namespace datapipeline

kubectl apply -f beats -n datapipeline