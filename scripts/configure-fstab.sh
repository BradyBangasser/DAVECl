#!/bin/bash

source ./utils.sh

MASTER_IP_ADDR=$(getconfval cluster_master)
IP_SCHEMA=$(getconfval ip_submask)


#-------- apt installs ----------

sudo apt install ntpdate -y

#------- nfs mounting -----------
if getconfval is_db; then
    sudo apt install nfs-kernel-server -y
    UUID=$(Blkid -s UUID -o value -t LABEL="/clusterfs")

    sudo mkdir /clusterfs
    sudo chown nobody.nogroup /clusterfs
    sudo chmod -R 777 /clusterfs

    echo "UUID=${UUID} /clusterfs ext4 defaults 0 2" | sudo tee -a /etc/fstab
    sudo mount -a

    sudo chown nobody.nogroup -R /clusterfs
    sudo chmod -R 766 /clusterfs

    echo "/clusterfs    $IP_SCHEMA (rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports

    sudo exportfs -a

else
    apt install nfs-common -y

    sudo mkdir /clusterfs
    sudo chown nobody.nogroup /clusterfs
    sudo chmod -R 777 /clusterfs

    echo "${MASTER_IP_ADDR}:/clusterfs    /clusterfs    nfs    defaults    0 0" | sudo tee -a /etc/fstab
    sudo mount -a

fi
