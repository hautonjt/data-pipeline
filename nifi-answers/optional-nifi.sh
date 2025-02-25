#!/bin/bash
kubectl delete -k ../nifi -n datapipeline --wait=true
kubectl wait --for=delete po/nifi-0 
kubectl wait --for=delete po/nifi-1
kubectl wait --for=delete po/nifi-2
cp -rp ./flow.xml.optional.gz /etc/nifi/nifi-0/conf/flow.xml.gz
cp -rp ./flow.xml.optional.gz /etc/nifi/nifi-1/conf/flow.xml.gz
cp -rp ./flow.xml.optional.gz /etc/nifi/nifi-2/conf/flow.xml.gz
rm -rf /etc/nifi/nifi-0/conf/flow.json.gz
rm -rf /etc/nifi/nifi-1/conf/flow.json.gz
rm -rf /etc/nifi/nifi-2/conf/flow.json.gz

kubectl apply -k ../nifi -n datapipeline
