# !/usr/bin/env sh

# Written By Brady Bangasser

# requires sudo perms
# THIS SCRIPT IS MEANT TO BE RUN ON YOUR COMPUTER WHILE CONNECTED TO THE SWITCH
# This program will fail if executed on any of the pi nodes


# Tasks
# Scan ips on interface and return only the ones with with the PI OS

ips=$(sudo arp-scan -l | grep PI)

echo $ips