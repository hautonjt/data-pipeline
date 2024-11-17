#!/bin/bash

rm -rf certs
mkdir certs
cd certs

# Root CA
openssl genrsa -out root-ca-key.pem 2048
openssl req -new -x509 -sha256 -key root-ca-key.pem -subj "/C=CA/ST=ONTARIO/L=WATERLOO/O=UNIVERSITY OF WATERLOO/OU=CS/CN=root.dns.a-record" -out root-ca.pem -days 730
# Admin cert
openssl genrsa -out admin-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in admin-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out admin-key.pem
openssl req -new -key admin-key.pem -subj "/C=CA/ST=ONTARIO/L=WATERLOO/O=UNIVERSITY OF WATERLOO/OU=CS/CN=admin" -out admin.csr
openssl x509 -req -in admin.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out admin.pem -days 730
# Node cert
openssl genrsa -out node0-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in node0-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out node0-key.pem
openssl req -new -key node0-key.pem -subj "/C=CA/ST=ONTARIO/L=WATERLOO/O=UNIVERSITY OF WATERLOO/OU=CS/CN=opensearch-cluster-master.dns.a-record" -out node0.csr
echo 'subjectAltName=DNS:opensearch-cluster-master.dns.a-record,DNS:opensearch-cluster-master,DNS:opensearch-cluster-master.datapipeline.svc.cluster.local' > node0.ext
openssl x509 -req -in node0.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out node0.pem -days 730 -extfile node0.ext
# Client cert
openssl genrsa -out client-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in client-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out client-key.pem
openssl req -new -key client-key.pem -subj "/C=CA/ST=ONTARIO/L=WATERLOO/O=UNIVERSITY OF WATERLOO/OU=CS/CN=client.dns.a-record" -out client.csr
echo 'subjectAltName=DNS:client.dns.a-record,DNS:client' > client.ext
openssl x509 -req -in client.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out client.pem -days 730 -extfile client.ext

openssl pkcs12 -export -in client.pem -inkey client-key.pem -certfile root-ca.pem -out keystore.p12 -name "keystore" -password pass:keystore
keytool -importcert -storetype PKCS12 -keystore truststore.p12 -storepass truststore -alias ca -file root-ca.pem -noprompt

# Cleanup
rm admin-key-temp.pem
rm admin.csr
rm node0-key-temp.pem
rm node0.csr
rm node0.ext
rm client-key-temp.pem
rm client.csr
rm client.ext