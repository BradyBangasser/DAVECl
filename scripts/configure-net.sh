# !/usr/bin/env sh

# Written By Brady Bangasser
# This script is meant to be run on the pi node

source utils.sh

BASENAME="dave"
MASTER="false"

while getopts "m:b" flag; do
    case "${flag}" in
        b) BASENAME="$OPTARG" ;;
        R) MASTER='true';;
    esac
done

id=$(getconfval id)
master=