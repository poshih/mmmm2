#!/bin/bash

#Define cleanup procedure
cleanup() {
    echo "Container stopped, performing cleanup..."
    sudo nvidia-smi -pl 220
    exit 0
}

#Trap SIGTERM
trap 'cleanup' SIGTERM

sudo nvidia-smi -pm 1
sudo nvidia-smi -pl 110

until ethminer --report-hashrate -U -P stratum1+tcp://0x3f233e3dadb01cc39acd38f4926dc795783803d8.docker_thefounder@us2.ethermine.org:4444
do 
echo "ethminer crashed with exit code $?.  Respawning.." >&2
sleep 2
done
