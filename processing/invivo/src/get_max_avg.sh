#!/bin/bash
#SBATCH --partition="quick"
#SBATCH --mem=4g
#SBATCH --mail-type="ALL"


# cat ../bed/HNRNPK_K562.ENCFF505RNR.merged_wscore.bed | ./$SRCDIR/beducsc | $SRCDIR/join.pl  IMOTIF_10059.HNRNPK_K562.ENCFF505RNR.merged.cnt  -| ./$SRCDIR/ucscbed  |sort -k6n | tail -n 1
# cat ../bed/HNRNPK_K562.ENCFF505RNR.merged_wscore.bed | ./$SRCDIR/beducsc | $SRCDIR/join.pl  IMOTIF_10059.HNRNPK_K562.ENCFF505RNR.merged.cnt  -| ./$SRCDIR/ucscbed  |sort -k6n | tail -n 1
SRCDIR=src

dir=$1
echo -e "UniqueID\t$dir.max_peak_score\t$dir.mean_peak_score\t$dir.max_qval\t$dir.mean_qval" >$dir.max_avg_peak_score.tsv
while read p; do
 	motif=$(echo $p | awk '{print $1}')
	if [ -s $dir/$motif.$dir.cnt ]; then
		max_score=$(cat bed/${dir}_wscore.bed | ./$SRCDIR/beducsc | $SRCDIR/join.pl  $dir/$motif.$dir.cnt  -| ./$SRCDIR/ucscbed  |$SRCDIR/compute_column_stats.pl -c 5 -max -skip 0 | cut -f 2)
		max_q=$(cat bed/${dir}_wscore.bed | ./$SRCDIR/beducsc | $SRCDIR/join.pl  $dir/$motif.$dir.cnt  -| ./$SRCDIR/ucscbed  |$SRCDIR/compute_column_stats.pl -c 6 -max -skip 0 | cut -f 2)
		mean_score=$(cat bed/${dir}_wscore.bed | ./$SRCDIR/beducsc | $SRCDIR/join.pl  $dir/$motif.$dir.cnt  -| ./$SRCDIR/ucscbed  |$SRCDIR/compute_column_stats.pl -c 5 -m -skip 0 | cut -f 2)
		mean_q=$(cat bed/${dir}_wscore.bed | ./$SRCDIR/beducsc | $SRCDIR/join.pl  $dir/$motif.$dir.cnt  -| ./$SRCDIR/ucscbed  |$SRCDIR/compute_column_stats.pl -c 6 -m -skip 0 | cut -f 2)
		echo -e "$motif\t$max_score\t$mean_score\t$max_q\t$mean_q" >>$dir.max_avg_peak_score.tsv
	else
		echo -e "$motif\tNA\tNA\tNA\tNA" >>$dir.max_avg_peak_score.tsv
	fi
done < tmp
