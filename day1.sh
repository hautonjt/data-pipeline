#!/bin/bash

cd
git clone https://github.com/niloysh/testbed-automator.git
git clone https://github.com/niloysh/open5gs-k8s.git
git clone https://github.com/niloysh/5g-monarch.git

cd testbed-automator
./install.sh
cd ..

cd open5gs-k8s
./deploy-all.sh
cd ..

cd 5g-monarch
./deploy-all.sh

cd request_translator
python3 test_api.py --json_file requests/request_slice.json submit
cd ..
./bin/k8s-ue-pinger.sh open5gs