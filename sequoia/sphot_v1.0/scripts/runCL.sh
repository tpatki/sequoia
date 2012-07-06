#!/bin/bash
# $1 = number of nodes desired
# $2 = number of threads per node. OpenMP version
set -x

export BMARK_STRING=sphot.$2

#export OMP_NUM_THREADS=$2 

name=`date +%Y_%m_%d_%H_%M_%S_%N`
mkdir $name
cd $name
env >> env
hostname >> info
echo $name >> info
uname -a >> info
srun --nodes=1 --ntasks=1 -ppbatch cat /proc/cpuinfo | grep MHz >> info
echo 'threads-per-node: '$2 >> info
echo 'nodes: '$1 >> info

echo $1 
echo $name

#Copy the right input file
cp ../../input.dat ./input.dat
cp ../../opac.txt ./opac.txt

#ntasks=nodes as you run one task per node.
#Export number of threads per node for OpenMP.

srun --nodes=$1 --ntasks=$1 -ppbatch -e sphot.err -o out.dat --auto-affinity=start=0,verbose,cpt=1 ../sphotCL.sh




