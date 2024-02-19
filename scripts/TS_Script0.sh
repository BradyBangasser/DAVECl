#!/bin/bash

echo -n "Welcome to Pi Node Setup <MUST BE RUN IN SUDO>"

HOSTNAME=$(hostname)
FSTAB_FILE="/etc/fstab"

#echo "$HOSTNAME" | sudo tee $HOSTNAME_FILE

#-------- apt installs ----------

#sudo apt install ntpdate -y
#sudo apt install nfs-common -y

#------- nfs mounting -----------

#sudo mkdir /clusterfs
#sudo chown nobody.nogroup /clusterfs
#sudo chmod -R 777 /clusterfs

echo $HOSTNAME

#echo "$MASTER_IP_ADDR:/clusterfs    /clusterfs    nfs    defaults    0 0" | sudo tee -a $FSTAB_FILE

