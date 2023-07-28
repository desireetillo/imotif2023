#!/bin/bash

#SBATCH --partition="norm,ccr"
#SBATCH --mem=3g
#SBATCH --mail-type="ALL"
#SBATCH --time=4:00:00


GENOME=$1
prefix=${GENOME%.*}
prefix=${prefix##*/}
echo -e "UniqueID\tseq\tcount.$prefix" >${prefix}.counts.tsv

while read p; do
    motif=$(echo $p | awk '{print $6}')
    out=$(echo $p | awk '{print $1}')
    count=$(./scan_seqs.pl $GENOME $motif counts | awk -F'\t' '{sum+=$2;}END{print sum;}')
    if [[ "$count" -gt 0 ]]; then
	echo -e "$out\t$motif\t$count"  >>${prefix}.counts.tsv
    else
	echo -e "$out\t$motif\t0" >>${prefix}.counts.tsv
    fi
done < <(tail -n +2 ../iMotif_array_uniq_probes.trimmed.v3.txt)

