# Configuration Files
This is the directory you should put all of your node configurations in.

Fill out the config.txt file with the required information then,
use mkdir/(node hostname) and then copy the config.txt file.

After this is completed then go to the head directory and run the command
"./scripts/unpack.sh $1" where $1 if the hostname of the node that you
want this node to be it is recommended to do the rest of the prosses on the
head node first and make sure you follow the correct script order.

**After** unpacking go to your home directory and run:
1) ./configure-net.sh

**Net config will restart your node.**

2) ./configure-fstab.sh
3) ./configure-slurm.sh

Then celabrate, if all has gone well you are one node closer to victory!
