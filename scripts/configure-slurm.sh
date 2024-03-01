#!/bin/bash

sudo su
source ./utils.sh

HOSTNAME=$(cat /etc/hostname)
MASTER_IP=$(awk 'master0 {print $1}' /etc/hosts)
HOST_IP=$(awk -v HOSTNAME="$HOSTNAME" '$0~HOSTNAME {print $1}' /etc/hosts)
SLURM_CONF=/etc/slurm-llnl/slurm.conf

CLUSTER_NAME=$(getconfval cluster_name)
SELECT_TYPE=$(getconfval select_type_mode)
SELECT_TYPE_PARAMETERS=$(getconfval select_type_parameters)
NODE_LIST=$(getconfval NodeName)
PARTITION_NAME_LINE=$(getconfval PartitionName)


apt install slurm-wlm -y

echo "ClusterName=${CLUSTER_NAME}" > $SLURM_CONF
echo "SlurmCtldHost=master0"  >> $SLURM_CONF
echo "SelectType=${SELECT_TYPE}" >> $SLURM_CONF
echo "SelectTypeParameters=$SELECT_TYPE_PARAMETERS" >> $SLURM_CONF
echo "NodeName=$NODE_LIST" >> $SLURM_CONF
echo "$PARTITION_NAME_LINE" >> $SLURM_CONF
cat ./tests/slurm-template.conf >> $SLURM_CONF




echo "$SRC $HOSTNAME $HOST_IP $MASTER_IP $SLURM_CTLD_HOST $CLUSTER_NAME $SELECT_TYPE_PARAMETERS $SELECT_TYPE"




# Unused until farther notice

#PROCTRACK_TYPE=$(${SRC}/scripts/utils.sh getConfVal proctrack_type)
#RETURN_TO_SERVICE=$(${SRC}/scripts/utils.sh getConfVal return_to_service)
#SLURMCTLD_PID_FILE=$(${SRC}/scripts/utils.sh getConfVal slurmctld_pid_file)
#SLURMD_PID_FILE=$(${SRC}/scripts/utils.sh getConfVal slurmd_pid_file)
#SLURMD_SPOOL_DIR=$(${SRC}/scripts/utils.sh getConfVal slurmd_spool_dir)
#STATE_SAVE_LOCATION=$(${SRC}/scripts/utils.sh getConfVal state_save_location)
#SLURM_USER=$(${SRC}/scripts/utils.sh getConfVal slurm_user)
#SLURM_SCHEDULER_TYPE=$(${SRC}/scripts/utils.sh getConfVal scheduler_type)

