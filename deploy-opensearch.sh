#!/bin/bash
sudo sysctl -w vm.max_map_count=786432
sudo echo "vm.max_map_count=786432" >> /etc/sysctl.conf

kubectl create namespace datapipeline
kubectl create secret generic opensearch-certs -n datapipeline --from-file=opensearch-certs/certs
helm install opensearch ./opensearch --namespace datapipeline
helm install opensearch-dashboards ./opensearch-dashboards --namespace datapipeline
kubectl rollout status statefulset opensearch-cluster-master -n datapipeline