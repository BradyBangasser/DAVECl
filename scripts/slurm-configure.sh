#!/bin/bash

sudo su
SRC=/home/kira/programing/DAVECl


HOSTNAME=$(cat /etc/hostname)
MASTER_IP=$(awk 'master0 {print $1}' /etc/hosts)
HOST_IP=$(awk -v HOSTNAME="$HOSTNAME" '$0~HOSTNAME {print $1}' /etc/hosts)
SLURM_CONF=/etc/slurm-llnl/slurm.conf

CLUSTER_NAME=$(${SRC}/scripts/utils.sh getConfVal cluster_name)
SLURM_CTLD_HOST=$(${SRC}/scripts/utils.sh getConfVal slurm_ctld_host)

SELECT_TYPE=$(${SRC}/scripts/utils.sh getConfVal select_type)
SELECT_TYPE_PARAMETERS=$(${SRC}/scripts/utils.sh getConfVal select_type_parameters)
NODE_LIST=${}
PARTITION_NAME_LINE=${}


if [ "$MASTER_IP" == "$HOST_IP" ]; then
    apt install slurm-wlm -y

    echo "ClusterName=${CLUSTER_NAME}" > $SLURM_CONF
    echo "SlurmCtldHost=${SLURM_CTLD_HOST}"  >> $SLURM_CONF
    echo "SelectType=${SELECT_TYPE}" >> $SLURM_CONF
    echo "SelectTypeParameters=$SELECT_TYPE_PARAMETERS"


    echo ${SRC}/resources/slurm-template.conf >> $SLURM_CONF



    #slurm.conf





else
    echo "oop"
fi

# Unused until farther notice

#PROCTRACK_TYPE=$(${SRC}/scripts/utils.sh getConfVal proctrack_type)
#RETURN_TO_SERVICE=$(${SRC}/scripts/utils.sh getConfVal return_to_service)
#SLURMCTLD_PID_FILE=$(${SRC}/scripts/utils.sh getConfVal slurmctld_pid_file)
#SLURMD_PID_FILE=$(${SRC}/scripts/utils.sh getConfVal slurmd_pid_file)
#SLURMD_SPOOL_DIR=$(${SRC}/scripts/utils.sh getConfVal slurmd_spool_dir)
#STATE_SAVE_LOCATION=$(${SRC}/scripts/utils.sh getConfVal state_save_location)
#SLURM_USER=$(${SRC}/scripts/utils.sh getConfVal slurm_user)
#SLURM_SCHEDULER_TYPE=$(${SRC}/scripts/utils.sh getConfVal scheduler_type)

