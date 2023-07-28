#!/usr/bin/bash

# writes swarm script to scan occurrences of iMotif sequences in the human genome

GENOME=/fdb/igenomes/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa
echo "#swarm -b 60 genome_scan.sw  --logdir logs -g 6  --merge-output" >genome_scan.sw

# read line by line
while read p; do
    f=$(echo $p | awk '{print $6}')
    out=$(echo $p | awk '{print $1}')
    echo "perl src/Motif_Search.pl -seq $GENOME -motif $f -strand 2 -position result/$out.pos.txt" >>genome_scan.sw
done < <(tail -n+2 ../iMotif_array_uniq_probes.trimmed.v3.txt)

