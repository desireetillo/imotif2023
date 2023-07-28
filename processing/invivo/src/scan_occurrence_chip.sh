#!/bin/bash

#SBATCH --partition="norm,ccr"
#SBATCH --mem=3g
#SBATCH --mail-type="ALL"
#SBATCH --time=4:00:00


GENOME=$1
prefix=${GENOME%.*}
prefix=${prefix##*/}
echo -e "UniqueID\tseq\tnumpeaks.$prefix" >${prefix}.numpeaks.tsv

while read p; do
    motif=$(echo $p | awk '{print $6}')
    out=$(echo $p | awk '{print $1}')
    count=$(./scan_seqs.pl $GENOME $motif counts | wc -l)
    if [[ "$count" -gt 0 ]]; then
	echo -e "$out\t$motif\t$count"  >>${prefix}.numpeaks.tsv
    else
	echo -e "$out\t$motif\t0" >>${prefix}.numpeaks.tsv
    fi
done < <(tail -n+2 ../iMotif_array_uniq_probes.trimmed.v3.txt)

