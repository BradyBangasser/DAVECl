#!/bin/bash

source ./utils.sh

MASTER_IP_ADDR=$(getconfval cluster_master)
IP_SCHEMA=$(getconfval ip_submask)
DEBUG=$(getconfval DEBUG)
NODE_COUNT=$(getconfval number_of_nodes)
IS_DB=$(getconfval is_db)

NODE_LIST=('')
BASE_NAME=$(getconfval cluster_name)

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
    UUID=$(blkid -s UUID -o value -t LABEL="/clusterfs")

    awk '{if ($0 !~ /clusterfs/) {print $0}}' /etc/fstab > fstab.tmp
    echo "UUID=${UUID} /clusterfs ext4 defaults 0 2" >> fstab.tmp

    awk '{if ($0 !~ /clusterfs/) {print $0}}' /etc/exports > exports.tmp
    echo "/clusterfs    "$IP_SCHEMA"(rw,sync,no_root_squash,no_subtree_check)" >> exports.tmp

    for ((i = 0; i < $NODE_COUNT; i++)); do
        NODE_LIST+=($BASE_NAME$i)
    done
    cp /etc/hosts.allow hosts.allow.tmp
    echo "nfs: ${NODE_LIST[@]}" >> hosts.allow.tmp

    if [ "$DEBUG" == "false" ]; then
        sudo mv hosts.allow.tmp /etc/hosts.allow
        sudo apt install nfs-kernel-server -y
        sudo mkdir /clusterfs
        sudo chown nobody.nogroup /clusterfs
        sudo chmod -R 777 /clusterfs
        sudo mv fstab.tmp /etc/fstab
        sudo mount -a
        sudo chown nobody.nogroup -R /clusterfs
        sudo chmod -R 766 /clusterfs
        sudo mv exports.tmp /etc/exports
        sudo exportfs -a
    fi

else
    cp /etc/fstab fstab.tmp
    echo "${MASTER_IP_ADDR}:/clusterfs    /clusterfs    nfs    defaults    0 0" >> fstab.tmp

    if [ "$DEBUG" == "false" ]; then
        sudo apt install nfs-kernel-server -y
        sudo apt install nfs-common -y
        sudo mkdir /clusterfs
        sudo chown nobody.nogroup /clusterfs
        sudo chmod -R 777 /clusterfs
        sudo mount -a
    fi
fi
