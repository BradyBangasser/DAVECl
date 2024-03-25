#!/bin/bash

source ./utils.sh

MASTER_IP_ADDR=$(getconfval cluster_master)
IP_SCHEMA=$(getconfval ip_submask)
DEBUG=$(getconfval DEBUG)
IS_DB=$(getconfval is_db)


if [[ "$DEBUG" != "" ]]; then
    DEBUG="true"
else
    DEBUG="false"
fi


#-------- apt installs ----------
if [ "$DEBUG" == "false" ]; then
    sudo apt install ntpdate -y
fi
#------- nfs mounting -----------
if [[ "$IS_DB" == "true" ]]; then
    UUID=$(Blkid -s UUID -o value -t LABEL="/clusterfs")

    awk '{if ($0 !~ /clusterfs/) {print $0}}' /etc/fstab >> fstab.txt
    echo "UUID=${UUID} /clusterfs ext4 defaults 0 2" >> fstab.txt

    awk '{if ($0 !~ /clusterfs/) {print $0}}' /etc/exports exports.txt
    echo "/clusterfs    $IP_SCHEMA (rw,sync,no_root_squash,no_subtree_check)" >> exports.txt

    if [ "$DEBUG" == "false" ]; then
        sudo apt install nfs-kernel-server -y
        sudo mkdir /clusterfs
        sudo chown nobody.nogroup /clusterfs
        sudo chmod -R 777 /clusterfs
        sudo mv fstab.txt /etc/fstab
        sudo mount -a
        sudo chown nobody.nogroup -R /clusterfs
        sudo chmod -R 766 /clusterfs
        sudo mv exports.txt /etc/exports
        sudo exportfs -a
    fi

else
    cp /etc/fstab fstab.txt
    echo "${MASTER_IP_ADDR}:/clusterfs    /clusterfs    nfs    defaults    0 0" >> fstab.txt

    if [ "$DEBUG" == "false" ]; then
        sudo apt install nfs-kernel-server -y
        sudo apt install nfs-common -y
        sudo mkdir /clusterfs
        sudo chown nobody.nogroup /clusterfs
        sudo chmod -R 777 /clusterfs
        sudo mount -a
    fi
fi
