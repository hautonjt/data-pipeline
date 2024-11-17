#!/bin/bash

cd ~/5g-monarch/request_translator
python3 test_api.py --json_file requests/request_slice.json submit
cd ..
./bin/k8s-ue-pinger.sh open5gs