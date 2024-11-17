#!/bin/bash

helm install kafka oci://registry-1.docker.io/bitnamicharts/kafka --version 31.0.0 --namespace datapipeline -f kafka/values.yaml
kubectl rollout status statefulset kafka-controller -n datapipeline
kubectl apply -f kafka-ui/kafka-ui-deployment.yaml -n datapipeline