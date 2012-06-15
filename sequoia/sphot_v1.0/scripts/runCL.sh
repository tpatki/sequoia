#!/bin/bash
# $1 = number of nodes desired
# $2 = number of threads per node. OpenMP version
set -x

export BMARK_STRING=sphot.$2

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


#if [ $2 -le 8 ]
#then

#        sh ~/local/src/power/setcpufreq.sh 1200000 8 15
#fi

#ntasks=nodes as you run one task per node.
#Export number of threads per node for OpenMP.

export OMP_NUM_THREADS=$2 
srun --nodes=$1 --ntasks=$1 -ppbatch -e sphot.err -o out.dat --auto-affinity=start=0,verbose,cpt=1 ../sphotCL.sh $1

#Reset all cores back to original freq which is 2600000 after the run
#sh ~/local/src/power/setcpufreq.sh 2600000 0 15




