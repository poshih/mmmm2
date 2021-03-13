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

until ethminer --report-hashrate -U -P stratum1+tcp://0xd1d1419ede629923cce568b4040dde13c132acc1.docker_2@us2.ethermine.org:4444
do 
echo "ethminer crashed with exit code $?.  Respawning.." >&2
sleep 2
done
