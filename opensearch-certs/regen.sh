#!/bin/bash
kubectl delete secret opensearch-certs
kubectl create secret generic opensearch-certs -n datapipeline --from-file=certs
