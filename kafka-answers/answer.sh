#!/bin/bash

echo "This script may print errors. These errors are safe."

kubectl cp ./config.properties kafka-controller-0:/tmp

kubectl exec kafka-controller-0 -- /opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic filebeat --delete --command-config /tmp/config.properties
kubectl exec kafka-controller-0 -- /opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic filebeat --create --partitions 3 --replication-factor 2 --command-config /tmp/config.properties --config min.insync.replicas=2 --config local.retention.ms=86400000

kubectl exec kafka-controller-0 -- /opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic metricbeat --delete --command-config /tmp/config.properties
kubectl exec kafka-controller-0 -- /opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic metricbeat --create --partitions 3 --replication-factor 2 --command-config /tmp/config.properties --config min.insync.replicas=2 --config local.retention.ms=86400000

kubectl exec kafka-controller-0 -- /opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic packetbeat --delete --command-config /tmp/config.properties
kubectl exec kafka-controller-0 -- /opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic packetbeat --create --partitions 3 --replication-factor 2 --command-config /tmp/config.properties --config min.insync.replicas=2 --config local.retention.ms=86400000

kubectl exec kafka-controller-0 -- /opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic prometheus --delete --command-config /tmp/config.properties
kubectl exec kafka-controller-0 -- /opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic prometheus --create --partitions 3 --replication-factor 2 --command-config /tmp/config.properties --config min.insync.replicas=2 --config local.retention.ms=86400000

kubectl exec kafka-controller-0 -- rm -rf /tmp/config.properties
