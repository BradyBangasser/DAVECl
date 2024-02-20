#!/bin/bash

sudo su

echo -n "Welcome to Pi Node Setup <MUST BE RUN IN SUDO>"

HOSTNAME=$(hostname)
MASTER_IP_ADDR=$(cat /etc/hosts | grep master | awk '{print $1}')
IP_SCHEMA=$(cat /etc/hosts | grep master | awk '{print $1}')
IP_SCHEMA=${IP_SCHEMA:0:8}

#-------- apt installs ----------

apt install ntpdate -y

#------- nfs mounting -----------

if [ "$HOSTNAME" == "master" ]; then
    apt install nfs-kernel-server -y
    UUID=$(Blkid -s UUID -o value -t LABEL="/clusterfs")

    mkdir /clusterfs
    chown nobody.nogroup /clusterfs
    chmod -R 777 /clusterfs

    echo "UUID=$UUID /clusterfs ext4 defaults 0 2" | tee -a /etc/fstab
    mount -a

    chown nobody.nogroup -R /clusterfs
    chmod -R 766 /clusterfs

    echo "/clusterfs    $IP_SCHEMA.0/24 (rw,sync,no_root_squash,no_subtree_check)" | tee -a /etc/exports

    exportfs -a


else
    apt install nfs-common -y

    mkdir /clusterfs
    chown nobody.nogroup /clusterfs
    chmod -R 777 /clusterfs

    echo "$MASTER_IP_ADDR:/clusterfs    /clusterfs    nfs    defaults    0 0" | tee -a /etc/fstab
    mount -a

fi
