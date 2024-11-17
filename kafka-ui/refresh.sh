#!/bin/bash

kubectl $1 -f kafka-ui-deployment.yaml -n datapipeline
