
# Scripts

## configure-fstab
Script edits /etc/fstab to set up automounting on all nodes to the NFS server. Used in script `p2-run.sh`

## configure-net.sh
Script configures the network and is ran on all nodes. Must have node configuration filled out. Recomended to be ran with `p1-run.sh` **RESTARTS THE DEVICE! **

## configure-slurm.sh
Script installs nessisary packages for slurm to be ran. The script is easy to mess up configuration for so double check that the node lines are filled out properly. Used in `p2-run.sh`

## p1-run.sh
Script is the first thing ran when setting up any given node. Run from project root. **RESTARTS THE DEVICE**

## p2-run.sh
Script is ran after reboot of the node from `p1-run.sh` and completes the rest of the setup of the node. Run from home directory (~/)

## send-to-pi.sh
Script sends proper files to rasbery-pis using ssh **NOT WORKING AND NOT A PRIORITY**

## unpack.sh
Script copys the scripts for configuration into the home directory (~/). Used in `p1-run.sh`

## utils.sh
Script contains the utilitys for reading from config files in this repo and contains the function getconfval. Used in `p1-run.sh` and `p2-run.sh`

# Contribution and Usage Notes
All scripts assume that all the resources that they need are in the same directory that they are in. This includes other called on scripts and config files. The only exception as of now is `unpack.sh`
Please document scripts and add them to the README.md if needed. Keep track of dependecys as well and try to limit anything that may be a inconsitent.
