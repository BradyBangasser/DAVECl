# !/usr/bin/env bash

# Written by Brady Bangasser

# This will send needed files to the raspberry pi

SET_SSH_KEY="false"
PI_IP="$1"
USER="pi"

while getopts "kr:" flag; do
    case "${flag}" in
        k) SET_SSH_KEY="true" ;;
        r) USER="$OPTARG" ;;
    esac
done

if [ "$PI_IP" == "" ]; then
    # scream
    echo "I NEED AN IP"
    exit 1
fi

if ! ssh "$USER@$PI_IP"; then
    if ! ping "$PI_IP" -c 1; then 
        echo "Unable to reach $PI_IP"
        exit 1
    fi

    if [ "$SET_SSH_KEY" == "true" ]; then
        if ! stat "~/.ssh/id-rsa.pub"; then
            echo "Attempting to generate keypair"

            
        fi
    fi
fi