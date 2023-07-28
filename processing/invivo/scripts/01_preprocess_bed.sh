#!/bin/bash

mkdir bed;
# download bed files
wget "https://www.encodeproject.org/files/ENCFF035OPG/@@download/ENCFF035OPG.bed.gz" -O bed/HNRNPK_HepG2.ENCFF035OPG.bed.gz
wget "https://www.encodeproject.org/files/ENCFF505RNR/@@download/ENCFF505RNR.bed.gz" -O bed/HNRNPK_K562.ENCFF505RNR.bed.gz

gunzip bed/*gz

# sort bed files:
sort -k1,1 -k2,2n bed/HNRNPK_HepG2.ENCFF035OPG.bed >bed/HNRNPK_HepG2.ENCFF035OPG.sorted.bed
sort -k1,1 -k2,2n bed/HNRNPK_K562.ENCFF505RNR.bed >bed/HNRNPK_K562.ENCFF505RNR.sorted.bed

# merge peak locations
module load bedtools;

bedtools merge -i bed/HNRNPK_HepG2.ENCFF035OPG.sorted.bed -c 7,9 -o max,max >bed/HNRNPK_HepG2.ENCFF035OPG.merged_wscore.bed
bedtools merge -i bed/HNRNPK_K562.ENCFF505RNR.sorted.bed -c 7,9 -o max,max >bed/HNRNPK_K562.ENCFF505RNR.merged_wscore.bed


# extract sequence (run as slurm job)

sbatch ./src/exract_sequence.sh bed/HNRNPK_HepG2.ENCFF035OPG.merged_wscore.bed
sbatch ./src/exract_sequence.sh bed/HNRNPK_K562.ENCFF505RNR.merged_wscore.bed
