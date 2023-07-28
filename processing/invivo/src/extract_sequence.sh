#!/bin/bash
#SBATCH --mem=10g
#SBATCH --mail-type="ALL"
#SBATCH --time=4:00:00
#SBATCH --partition="ccr,norm"


module load bedtools
genome_sequence=/fdb/igenomes/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa

peak_file=$1
samp_name=${peak_file%.*}
samp_name=${samp_name##*/}
peaksfa=${samp_name}".fa"
peaksstab=${samp_name}".stab"
mkdir seq
echo $peak_file $samp_name
bedtools getfasta -fi $genome_sequence -bed $peak_file -fo seq/$peaksfa

# convert to stab

cat seq/$peaksfa | ./src/fasta2stab.pl >seq/$peaksstab
