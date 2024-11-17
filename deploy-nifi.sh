#!/bin/bash
mkdir -p /var/lib/nifi/nifi-0
mkdir -p /var/lib/nifi/nifi-1
mkdir -p /var/lib/nifi/nifi-2

sudo cp geoip/GeoLite2-City.mmdb /var/lib/nifi/nifi-0
sudo cp geoip/GeoLite2-City.mmdb /var/lib/nifi/nifi-1
sudo cp geoip/GeoLite2-City.mmdb /var/lib/nifi/nifi-2

sudo chown -R 1000:1000 /var/lib/nifi

kubectl delete -k nifi -n datapipeline
kubectl apply -k nifi -n datapipeline
