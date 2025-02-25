#!/bin/bash
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

kubectl delete -k nifi -n datapipeline 2>&1 > /dev/null
kubectl apply -k nifi -n datapipeline
