# !/usr/bin/env sh

# Copy and Paste functions from this or use source/.

# Written by Brady Bangasser

CONFIGPATH="../tests/node.conf"

# this does not work in a sudo su
getconfval() {
    echo "heree"
    # echo $(cat $CONFIGPATH | grep $1 | awk '{print $2}')
}