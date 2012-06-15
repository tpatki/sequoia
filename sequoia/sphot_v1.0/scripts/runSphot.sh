#!/bin/bash

#Assumes powers of two for number of nodes.

#$1: minimum number of nodes (32)
#$2: maximum number of nodes (128)
#$3: number of threads per node. OpenMP version.

i=$1

while [ $i -le $2 ]
do
      echo "nodes=$i ntasks=$i threads-per-node=$3"
      ./runCL.sh $i $3
  i=$(($i*2))
done

