#!/bin/bash

file=$1
#echo "{y##*/}"
prefix="${file##*/}"

for i in `seq 1 8`;
do
    cat $file | tr -d '"' | grep -E "^Block\b" >block.$i.${prefix};
    grep -E "^$i\b" $file >>block.$i.${prefix};
done    

