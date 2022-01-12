#!/bin/bash

#Define cleanup procedure
cleanup() {
    echo "Container stopped, performing cleanup..."
    sudo nvidia-smi -pl 220
    exit 0
}

#Trap SIGTERM
trap 'cleanup' SIGTERM

DISPLAY=:0 nvidia-settings -a GPUMemoryTransferRateOffsetAllPerformanceLevels=1600

sudo nvidia-smi -pm 1
sudo nvidia-smi -pl 120

until ethminer --report-hashrate -U -P stratum1+tcp://0x6e8D42f653Cd04960f13C02eEE2A33338A28ab6a.docker_2@us2.ethermine.org:4444
do 
echo "ethminer crashed with exit code $?.  Respawning.." >&2
sleep 2
done
