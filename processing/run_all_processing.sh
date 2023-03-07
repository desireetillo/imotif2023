#!/bin/bash
for i in data_v2/block*txt;
do
#    echo $i;
    base=${i##*/};
    prefix=${base%.*};
    echo "RScript Scripts/compute-SNR-median.R $base $prefix";
    RScript Scripts/compute-SNR-median.R $base $prefix;
done
