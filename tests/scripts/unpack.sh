#!/bin/bash


# USE: This is ment to be used before anything else is run.
# it will move everything into the directory it expects the files
# to be in (The users home directory), this is done with the cp command
# instead of move for the cases of errors happening then you have a back
# up copy of the files.

SC=scripts/configure-

cp ./config/"$1"/dave.conf .
cp ./resources/* .
cp ./scripts/*
