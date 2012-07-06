#!/bin/bash


find . -name 'out_answers*' -print | sort -n > tmp
cat tmp | xargs grep sec | cut -d "=" -f 2 | sed -n '1~2p' | sed 's/[ \t]*//g' > .time

find . -name 'info*' -print | sort -n > tmp2
cat tmp2 | xargs grep threads | cut -d ":" -f 3 | sed 's/[ \t]*//g' > .cores
cat tmp2 | xargs grep nodes | cut -d ":" -f 3 |sed 's/[ \t]*//g'  > .nodes
cat tmp2 | xargs grep MHz | sed -n '1~16p' | cut -d ":" -f 3 > .freq

find . -name '*mpiP*' -print | sort -n > tmp3
cat tmp3 | xargs  grep '\*' | cut -d ":" -f 2 | grep -v '[a-z]' | tr -s "\t" " " | cut -d " " -f 5 > .mpitime

paste -d ' ' .freq .nodes .cores .time .mpitime > .table
sed '1 i freq nodes threads/node time mpipercent' .table > table.out

rm tmp
rm tmp2
#rm .freq .cores .nodes .time .table

