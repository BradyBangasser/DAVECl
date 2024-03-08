# DAVECl
Scripts and other resources for building the DAVE cluster at Bethel University.
Things to note going into this is that you will want to have a basic understanding
of HPC and the like otherwise filling out the config files alone will be a challange.
This was all built for Bethels server needs and may not work for your own so you
may need to tinker around a bit to get it to work.

## Outline
There are a few specific needs that were met with this repo, but mainly
it was to automate a lot of the grindy bash commands for the setup.

## Usage
Some things to note, it will not always catch fire if you do things out of order
but there is a very good chance it will. Start setup with the master node/nodes
and then repeat from there.
The simple usage is quite simple in nature and the steps are as follows:
1. Edit the config file (config/config.txt) with the apropreate values for your
clusters needs.

2. Make a directory for each node (in config) and then copy config.txt into
that directory.

    - Fill out the remaining variables in the config.txt for the individule
    nodes as marked in the config file.

3. In the project root directory run `./scripts/unpack.sh $1` where $1 is what
node you currently want to set up and then cd to your home directory.

4. Then it is time to set up the network for the node, run `./configure-network.sh`

5. Set up the Network File System by running `./configure-fstab.sh`

6. Set up Slurm and friends by running `./configure-slurm`

7. Celabrate as you are one node closer to completion

## Food for thought
You should change the name from DAVE for your own cluster (or not, its funny)\
If you see something wrong feel free to open an issue, we will try to fix it.
