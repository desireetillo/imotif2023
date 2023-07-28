#!/bin/bash

#SBATCH --partition="norm,ccr"
#SBATCH --mem=3g
#SBATCH --mail-type="ALL"
#SBATCH --time=4:00:00


GENOME=$1
prefix=${GENOME%.*}
prefix=${prefix##*/}
#echo -e "UniqueID\tseq\tcount.$prefix" >${prefix}.counts.tsv

mkdir -p $prefix
while read p; do
    motif=$(echo $p | awk '{print $6}')
    out=$(echo $p | awk '{print $1}')
    ./scan_seqs.pl $GENOME $motif counts | add_column.pl -s $out >$prefix/$out.$prefix.cnt
done < <(tail -n +2 ../iMotif_array_uniq_probes.trimmed.v3.txt)
