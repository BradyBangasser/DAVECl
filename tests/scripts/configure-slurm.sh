#!/bin/bash

source ./utils.sh

HOSTNAME=$(cat /etc/hostname)
MASTER_IP=$(awk 'master0 {print $1}' /etc/hosts)
HOST_IP=$(awk -v HOSTNAME="$HOSTNAME" '$0~HOSTNAME {print $1}' /etc/hosts)
SLURM_CONF=/etc/slurm-llnl/slurm.conf

CLUSTER_NAME=$(getconfval cluster_name)
SELECT_TYPE=$(getconfval select_type_mode)
SELECT_TYPE_PARAMETERS=$(getconfval select_type_parameters)
NODE_LIST=$(getconfval node_line)
PARTITION_NAME_LINE=$(getconfval PartitionName)

IS_MASTER=$(getconfval is_master)
DEBUG=$(getconfval DEBUG)

if [[ "$DEBUG" != "" ]]; then
    DEBUG="true"
else
    DEBUG="false"
fi

if [[ "$IS_MASTER" != "" ]]; then
    is_master="true"
fi

if [ $IS_MASTER == "true" ]; then

    cat << config0 > slurm.conf.tmp
ClusterName=${CLUSTER_NAME}
SlurmCtldHost=$HOSTNAME
SelectType=$SELECT_TYPE
SelectTypeParameters=$SELECT_TYPE_PARAMETERS
$NODE_LIST
$PARTITION_NAME_LINE
config0

    cat ./slurm-template.conf >> slurm.conf.tmp

    if [ $DEBUG == "false" ]; then
        sudo apt install slurm-wlm -y
        sudo apt install ntpdate -y

        mv slurm.conf.tmp /etc/slurm-llnl/slurm.conf

        sudo cp ./cgroup.conf /etc/slurm-llnl/cgroup.conf
        sudo cp ./cgroup-allowed-devices.conf /etc/slurm-llnl/cgroup_allowed_devices_file.conf

        sudo cp slurm.conf cgroup.conf cgroup_allowed_devices_file.conf /clusterfs
        sudo cp /etc/munge/munge.key /clusterfs

        sudo systemctl enable munge
        sudo systemctl start munge

        sudo systemctl enable slurmd
        sudo systemctl start slurmd

        sudo systemctl enable slurmctld
        sudo systemctl start slurmctld
    fi
else
    if [ $DEBUG == "false" ]; then
        sudo apt install slurmd slurm-client -y
        sudo cp /clusterfs/munge.key /etc/munge/munge.key
        sudo cp /clusterfs/slurm.conf /etc/slurm-llnl/slurm.conf
        sudo cp /clusterfs/cgroup* /etc/slurm-llnl

        sudo systemctl enable munge
        sudo systemctl start munge

        sudo systemctl enable slurmd
        sudo systemctl start slurmd
    fi
fi

# echo "$SRC $HOSTNAME $HOST_IP $MASTER_IP $SLURM_CTLD_HOST $CLUSTER_NAME $SELECT_TYPE_PARAMETERS $SELECT_TYPE"

#---------------------Unused until farther notice-----------------------------

#PROCTRACK_TYPE=$(${SRC}/scripts/utils.sh getConfVal proctrack_type)
#RETURN_TO_SERVICE=$(${SRC}/scripts/utils.sh getConfVal return_to_service)
#SLURMCTLD_PID_FILE=$(${SRC}/scripts/utils.sh getConfVal slurmctld_pid_file)
#SLURMD_PID_FILE=$(${SRC}/scripts/utils.sh getConfVal slurmd_pid_file)
#SLURMD_SPOOL_DIR=$(${SRC}/scripts/utils.sh getConfVal slurmd_spool_dir)
#STATE_SAVE_LOCATION=$(${SRC}/scripts/utils.sh getConfVal state_save_location)
#SLURM_USER=$(${SRC}/scripts/utils.sh getConfVal slurm_user)
#SLURM_SCHEDULER_TYPE=$(${SRC}/scripts/utils.sh getConfVal scheduler_type)

