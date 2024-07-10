#Download MLNX OFED
wget https://content.mellanox.com/ofed/MLNX_OFED-23.10-0.5.5.0/MLNX_OFED_LINUX-23.10-0.5.5.0-ubuntu20.04-x86_64.tgz
tar -xvzf MLNX_OFED-23.10-0.5.5.0/MLNX_OFED_LINUX-23.10-0.5.5.0-ubuntu20.04-x86_64.tgz
cd MLNX_OFED_LINUX-23.10-0.5.5.0-ubuntu22.04-x86_64/
sudo apt update
sudo apt install bzip2

#Install MLNX OFED with nvmf
sudo ./mlnxofedinstall --add-kernel-support --with-nvmf
sudo /etc/init.d/openibd restart
sudo update-initramfs -u
sudo reboot

