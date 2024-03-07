#!/bin/bash
#!/bin/bash
echo hello!

mkdir ./results

./scripts/configure-net.sh
./scripts/configure-fstab.sh
./scripts/configure-slurm.sh

