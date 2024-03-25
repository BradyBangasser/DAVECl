#!/bin/bash

# Copy and Paste functions from this or use source/.

# Written by Brady Bangasser

# CONFIGPATH="../tests/node.conf"

CONFIGPATH="./dave.conf"

# this does not work in a sudo su
getconfval() {
    cat $CONFIGPATH | grep $1 | awk '{d = "";
                            for (f=2; f<=NF; ++f)
                                {printf("%s%s", d, $f); d = OFS};
                                    printf("\n") }'
}
