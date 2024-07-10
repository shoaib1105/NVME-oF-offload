''' Execute script as super user i.e run "sudo su" on terminal before running '''


#!/bin/bash
sudo apt install net-tools

#Change Interface "enp7s0np0" to the corresponding smartnic interface that you are going to offload
#Client-ip
sudo ifconfig enp7s0np0 10.0.1.1/24

#Change Interface "enp7s0np0" to the corresponding smartnic interface that you are not going to offload
#Client-ip
sudo ifconfig enp8s0np0 10.0.2.1/24

 
echo "...Setting up NVME Target"

 

echo "1. enabling nvme modules"

modprobe -rv nvme

modprobe nvmet

modprobe nvme num_p2p_queues=3


#modprobe nvmet-rdma offload_mem_start=0xf00000000 offload_mem_size=2048 offload_buffer_size=512

 

echo "2. enable subsystem-1 port 1 IP 10.0.1.2 - NVME target offload"

 

mkdir /sys/kernel/config/nvmet/subsystems/testsubsystem

echo 1 > /sys/kernel/config/nvmet/subsystems/testsubsystem/attr_allow_any_host

echo 1 > /sys/kernel/config/nvmet/subsystems/testsubsystem/attr_offload

mkdir /sys/kernel/config/nvmet/subsystems/testsubsystem/namespaces/1

echo -n /dev/nvme0n1 > /sys/kernel/config/nvmet/subsystems/testsubsystem/namespaces/1/device_path

echo 1 > /sys/kernel/config/nvmet/subsystems/testsubsystem/namespaces/1/enable

mkdir /sys/kernel/config/nvmet/ports/1

echo 4420 > /sys/kernel/config/nvmet/ports/1/addr_trsvcid

echo 10.0.1.2 > /sys/kernel/config/nvmet/ports/1/addr_traddr

echo "rdma" > /sys/kernel/config/nvmet/ports/1/addr_trtype

echo "ipv4" > /sys/kernel/config/nvmet/ports/1/addr_adrfam

ln -s /sys/kernel/config/nvmet/subsystems/testsubsystem/ /sys/kernel/config/nvmet/ports/1/subsystems/testsubsystem

 

 

echo "3. enable subsystem-2 port 2 IP 10.0.2.2 - NVME target not offload"

 

mkdir /sys/kernel/config/nvmet/subsystems/testsubsystem2

echo 1 > /sys/kernel/config/nvmet/subsystems/testsubsystem2/attr_allow_any_host

mkdir /sys/kernel/config/nvmet/subsystems/testsubsystem2/namespaces/2

echo -n /dev/nvme0n1 > /sys/kernel/config/nvmet/subsystems/testsubsystem2/namespaces/2/device_path

echo 1 > /sys/kernel/config/nvmet/subsystems/testsubsystem2/namespaces/2/enable

mkdir /sys/kernel/config/nvmet/ports/2

echo 4420 > /sys/kernel/config/nvmet/ports/2/addr_trsvcid

echo 10.0.2.2 > /sys/kernel/config/nvmet/ports/2/addr_traddr

echo "rdma" > /sys/kernel/config/nvmet/ports/2/addr_trtype

echo "ipv4" > /sys/kernel/config/nvmet/ports/2/addr_adrfam

ln -s /sys/kernel/config/nvmet/subsystems/testsubsystem2/ /sys/kernel/config/nvmet/ports/2/subsystems/testsubsystem2

 

echo "... done"
