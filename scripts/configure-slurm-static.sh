#!/bin/bash

source ./utils.sh

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
    echo This is a master.
else
    if [ $DEBUG == "false" ]; then
        sudo cp /clusterfs/munge.key /etc/munge/munge.key
        sudo cp -r /clusterfs/slurm-llnl /etc/slurm-llnl/

        sudo systemctl enable munge
        sudo systemctl start munge

        sudo systemctl enable slurmd
        sudo systemctl start slurmd
    fi
fi
