sudo apt update

apt install nvme-cli

sudo su

modprobe nvme

modprobe nvme-rdma

 

nvme discover -t rdma -a 10.0.1.2 -s 4420

nvme connect -t rdma -n testsubsystem -a 10.0.1.2 -s 4420

 

nvme discover -t rdma -a 10.0.2.2 -s 4420

nvme connect -t rdma -n testsubsystem2 -a 10.0.2.2 -s 4420
