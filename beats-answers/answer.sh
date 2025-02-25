#!/bin/bash

kubectl apply -f ../beats/filebeat-kubernetes.yaml
kubectl apply -f ../beats/metricbeat-kubernetes.yaml
kubectl apply -f ../beats/packetbeat-kubernetes.yaml
kubectl apply -f ../lab/metricbeat-prometheus-answer.yaml
