#!/bin/bash


# Compile genome occurrences

echo "New_ID,hg38_occurrences" >imotif_hg38_occurrences.csv
for i in result/IMOTIF*txt;
do
    id=$(basename $i)
    pref=${id%%.*}
    count=`wc -l $i | cut.pl -f 1 -d " "`
    echo "$pref,$count" >>imotif_hg38_occurrences.csv;
done

cat imotif_hg38_occurrences.csv | tr ',' '\t' | ./src/join.pl ../info/iMotif_array_uniq_probes.trimmed.v3.txt - | ./src/join.pl ../info/iMotif_array_uniq_probes.id2seqclass.tab  - >iMotif_array_uniq_probes.hg38_occurrences.txt

# Compile chipseq ocurrences

./src/join.pl HNRNPK_HepG2.ENCFF035OPG.merged.counts.tsv HNRNPK_K562.ENCFF505RNR.merged.counts.tsv \
| ./src/cut.pl -f 1-3,6 \
| ./src/join.pl iMotif_array_v2_uniq_probes_info.woccurrence.tsv - \
| ./src/join.pl - ../analysis/data/imotif_array_v2.protein_SNR.avg_reps.tab -1 2 -2 1 \
| ./src/cut.pl -f 1-9,11,12,14 \
>iMotif_array_v2_HNRNPK_motif_analysis.tsv

bash ./src/get_max_avg.sh HNRNPK_K562.ENCFF505RNR.merged.wscore
bash ./src/get_max_avg.sh HNRNPK_HepG2.ENCFF035OPG.merged_wscore

./src/join.pl HNRNPK_HepG2.ENCFF035OPG.merged.max_avg_peak_score.tsv HNRNPK_K562.ENCFF505RNR.merged.max_avg_peak_score.tsv
| ./src/join.pl iMotif_array_v2_HNRNPK_motif_analysis.tsv -
| ./cut.pl -f 1-11,13-20,12 >iMotif_array_v2_HNRNPK_motif_analysis.invivo_scores.tsv
