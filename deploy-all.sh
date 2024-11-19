#!/bin/bash
sudo sysctl -w vm.max_map_count=786432
echo "vm.max_map_count=786432" | sudo tee /etc/sysctl.conf

kubectl create namespace datapipeline

kubectl create secret generic opensearch-certs -n datapipeline --from-file=opensearch-certs/certs
helm install opensearch ./opensearch --namespace datapipeline
helm install opensearch-dashboards ./opensearch-dashboards --namespace datapipeline

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install kube-state-metrics prometheus-community/kube-state-metrics --version 5.27.0 --namespace datapipeline

helm install kafka oci://registry-1.docker.io/bitnamicharts/kafka --version 31.0.0 --namespace datapipeline -f kafka/values.yaml
kubectl rollout status statefulset kafka-controller -n datapipeline
kubectl apply -f kafka-ui/kafka-ui-deployment.yaml -n datapipeline

sudo mkdir -p /var/lib/nifi/nifi-0
sudo mkdir -p /var/lib/nifi/nifi-1
sudo mkdir -p /var/lib/nifi/nifi-2

sudo cp geoip/GeoLite2-City.mmdb /var/lib/nifi/nifi-0
sudo cp geoip/GeoLite2-City.mmdb /var/lib/nifi/nifi-1
sudo cp geoip/GeoLite2-City.mmdb /var/lib/nifi/nifi-2

kubectl apply -k nifi -n datapipeline
