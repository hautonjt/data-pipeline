#!/bin/bash

cd "$(dirname "$0")"

cd ..

sudo sysctl -w vm.max_map_count=786432
echo "vm.max_map_count=786432" | sudo tee /etc/sysctl.conf

kubectl create namespace datapipeline

sudo mkdir -p /var/lib/nifi/nifi-0
sudo mkdir -p /var/lib/nifi/nifi-1
sudo mkdir -p /var/lib/nifi/nifi-2

sudo mkdir -p /etc/nifi/nifi-0
sudo mkdir -p /etc/nifi/nifi-1
sudo mkdir -p /etc/nifi/nifi-2

sudo cp geoip/GeoLite2-City.mmdb /var/lib/nifi/nifi-0
sudo cp geoip/GeoLite2-City.mmdb /var/lib/nifi/nifi-1
sudo cp geoip/GeoLite2-City.mmdb /var/lib/nifi/nifi-2

sudo chown -R 1000:1000 /var/lib/nifi
sudo chown -R 1000:1000 /etc/nifi

kubectl apply -k nifi -n datapipeline

kubectl create secret generic opensearch-certs -n datapipeline --from-file=opensearch-certs/certs
helm install opensearch ./opensearch --namespace datapipeline
helm install opensearch-dashboards ./opensearch-dashboards --namespace datapipeline

helm install kafka oci://registry-1.docker.io/bitnamicharts/kafka --version 31.0.0 --namespace datapipeline -f kafka/values.yaml
kubectl rollout status statefulset kafka-controller -n datapipeline
kubectl apply -f kafka-ui/kafka-ui-deployment.yaml -n datapipeline
