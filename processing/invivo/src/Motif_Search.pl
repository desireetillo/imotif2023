#!/usr/bin/perl
#################################################################################################
#     Name:  Motif_Space_Stat.pl		                                          						#
#     Author:  Ximiao He									                                    #
#     Email:  Ximiao.He@nih.gov  								                                #
#     Date:  2009-12-11										                                    #
#     Last modified:  2009-12-08								                                #
#     Version:  1.0										                                        #
#     Description:  Cluster the GR and cJun according the alignment to the mouse genome.        #
#################################################################################################

# ========12/11/2009 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa -motif ACANNNTGT -strand 2 -position ../result/chr_all_ACANNNTGT.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa -motif TGACTCA -strand 0 -position ../result/chr_all_TGACTCA.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa -motif TGAGTCA -strand 0 -position ../result/chr_all_TGAGTCA.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa -motif CANNNTGT -strand 0 -position ../result/chr_all_CANNNTGT.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa -motif ACANNNTG -strand 0 -position ../result/chr_all_ACANNNTG.plus.pos.txt & 
#2/19/2010
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa -motif CCANNNTGT -strand 0 -position ../result/chr_all_CCANNNTGT.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa -motif ACANNNTGA -strand 0 -position ../result/chr_all_ACANNNTGA.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa -motif TCANNNTGT -strand 0 -position ../result/chr_all_TCANNNTGT.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa -motif ACANNNTGC -strand 0 -position ../result/chr_all_ACANNNTGC.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa -motif GCANNNTGT -strand 0 -position ../result/chr_all_GCANNNTGT.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa -motif ACANNNTGG -strand 0 -position ../result/chr_all_ACANNNTGG.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa -motif CANNNTG -strand 0 -position ../result/chr_all_CANNNTG.plus.pos.txt & 

# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa.masked -motif TGACTCA -strand 0 -position ../result/chr_all_masked_TGACTCA.plus.pos.txt &
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa.masked -motif TGAGTCA -strand 0 -position ../result/chr_all_masked_TGAGTCA.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa.masked -motif ACANNNTGT -strand 2 -position ../result/chr_all_masked_ACANNNTGT.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa.masked -motif CANNNTG -strand 2 -position ../result/chr_all_masked_CANNNTG.pos.txt & 

# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa.masked -motif CCANNNTGT -strand 0 -position ../result/chr_all_masked_CCANNNTGT.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa.masked -motif ACANNNTGA -strand 0 -position ../result/chr_all_masked_ACANNNTGA.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa.masked -motif TCANNNTGT -strand 0 -position ../result/chr_all_masked_TCANNNTGT.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa.masked -motif ACANNNTGC -strand 0 -position ../result/chr_all_masked_ACANNNTGC.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa.masked -motif GCANNNTGT -strand 0 -position ../result/chr_all_masked_GCANNNTGT.plus.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa.masked -motif ACANNNTGG -strand 0 -position ../result/chr_all_masked_ACANNNTGG.plus.pos.txt &

# perl Motif_Search.pl -seq ../result/cJun_All_Sam_20091223.fasta -motif TGACTCA -strand 2 -position ../result/cJun_All_Sam_20091223_TGACTCA.pos.txt &
# perl Motif_Search.pl -seq ../result/GR_AFos_All_1500.fasta -motif ACANNNTGT -strand 2 -position ../result/GR_AFos_All_1500-ACANNNTGT.pos.txt &
# perl Motif_Search.pl -seq ../result/GR_AFos_All_1500.fasta -motif CANNNTGT -strand 2 -position ../result/GR_AFos_All_1500-CANNNTGT.pos.txt &


#3/25/2010
# perl Motif_Search.pl -seq ../result/cJun_All_Sam_20091223.fasta.masked -motif TGACTCA -strand 2 -position ../result/cJun_All_Sam_20091223_TGACTCA.pos.txt.masked &
# perl Motif_Search.pl -seq ../result/cJun_GR_Sam_20091223.fasta.masked -motif TGACTCA -strand 2 -position ../result/cJun_GR_Sam_20091223_TGACTCA.pos.txt.masked &
# perl Motif_Search.pl -seq ../result/cJun_Only_Sam_20091223.fasta.masked -motif TGACTCA -strand 2 -position ../result/cJun_Only_Sam_20091223_TGACTCA.pos.txt.masked &

# perl Motif_Search.pl -seq ../data/Eif2alpha.fasta -motif TGACTCA -strand 2 -position ../result/Eif2alpha_TGACTCA.pos.txt &
# perl Motif_Search.pl -seq ../data/Promoters.fasta -motif CCGGAA -strand 2 -position ../result/Mouse.promoter.CCGGAA.pos.txt &
# perl Motif_Search.pl -seq ../data/Promoters.fasta -motif GCGGAA -strand 2 -position ../result/Mouse.promoter.GCGGAA.pos.txt &
 

# perl Motif_Search.pl -seq ../data/human.promoter.fasta -motif CCGGAA -strand 2 -position ../result/Human.promoter.CCGGAA.pos.txt &
# perl Motif_Search.pl -seq ../data/human.promoter.fasta -motif GCGGAA -strand 2 -position ../result/Human.promoter.GCGGAA.pos.txt &
# perl Motif_Search.pl -seq ../data/cJun_All_Sam_20091223.fasta -motif TCA -strand 2 -position ../result/cJun_All_Sam_20091223.TCA.pos.txt &

#4/30/2010
# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa.masked -motif TGAGTCA -strand 0 -position ../result/chr_all_masked_TGAGTCA.plus.pos.txt & 
# perl Motif_Search.pl -seq ../data/human.promoter.fasta -motif CGCA -strand 2 -position ../result/Human.promoter.CGCA.pos.txt &

# 5/6/2011
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa.masked -motif TTGCGCAA -strand 2 -position ../result/mm9/chr_all_masked.TTGCGCAA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa -motif TTGCGCAA -strand 2 -position ../result/mm9/chr_all.TTGCGCAA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa.masked -motif TTGCGTAA -strand 2 -position ../result/mm9/chr_all_masked.TTGCGTAA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa -motif TTGCGTAA -strand 2 -position ../result/mm9/chr_all.TTGCGTAA.pos.txt & 

# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa.masked -motif AAGCGCTT -strand 2 -position ../result/mm9/chr_all_masked.AAGCGCTT.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa -motif AAGCGCTT -strand 2 -position ../result/mm9/chr_all.AAGCGCTT.pos.txt & 

# 6/13/2011
# perl Motif_Search.pl -seq ../data/dm5/dm5.fasta -motif TTACGCAA -strand 2 -position ../data/dm5/dm5.GT.TTACGCAA.pos.txt & 
# perl Motif_Search.pl -seq ../data/dm5/dm5.fasta -motif GTTTTTTA -strand 2 -position ../data/dm5/dm5.HB.GTTTTTTA.pos.txt &
# perl Motif_Search.pl -seq ../data/dm5/dm5.fasta -motif TTAACCCTTT -strand 2 -position ../data/dm5/dm5.KR.TTAACCCTTT.pos.txt &
# perl Motif_Search.pl -seq ../data/dm5/dm5.fasta -motif AACCCTTT -strand 2 -position ../data/dm5/dm5.KR.AACCCTTT.pos.txt &
# perl Motif_Search.pl -seq ../data/dm5/dm5.fasta -motif TTTATTG -strand 2 -position ../data/dm5/dm5.CAD.TTTATTG.pos.txt &
# perl Motif_Search.pl -seq ../data/dm5/dm5.fasta -motif TTTATGA -strand 2 -position ../data/dm5/dm5.CAD.TTTATGA.pos.txt &
# perl Motif_Search.pl -seq ../data/dm5/dm5.fasta -motif TAATCC -strand 2 -position ../data/dm5/dm5.BCD.TAATCC.pos.txt &

# perl Motif_Search.pl -seq /fdb/genome/mouse-mar2006/chr_all.fa.masked -motif TGACTCA -strand 2 -position ../result/mm8.masked.TGACTCA.pos.txt & 


# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa -motif CCGGANNTNNCGNNNN -strand 2 -position ../result/mm9/chr_all.CCGGANNTNNCGNNNN.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa -motif GCGGANNTNNCGNNNN -strand 2 -position ../result/mm9/chr_all.GCGGANNTNNCGNNNN.pos.txt &
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif CCGGANNTNNCGNNNN -strand 2 -position ../result/hg19/chr_all.CCGGANNTNNCGNNNN.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif GCGGANNTNNCGNNNN -strand 2 -position ../result/hg19/chr_all.GCGGANNTNNCGNNNN.pos.txt &
# 8/28/2012
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr21.fa -motif CG -strand 2 -position ../data/hg19/chr21.CG.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr21.fa.masked -motif CG -strand 2 -position ../data/hg19/chr21.masked.CG.pos.txt &

# perl Motif_Search.pl -seq /fdb/genome/mm9/chr19.fa -motif CG -strand 2 -position ../data/mm9/chr19.CG.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr19.fa.masked -motif CG -strand 2 -position ../data/mm9/chr19.masked.CG.pos.txt &

# 10/11/2012
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa.masked -motif ATCAATCA -strand 2 -position ../result/mm9/mm9.masked.ATCAATCA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa.masked -motif ATCAATCA -strand 2 -position ../result/mm9/mm9.masked.ATCAATCA.pos.txt & 

# 11/16/2012
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa -motif NTGANTCANNNTGANTCAN -strand 2 -position ../result/mm9/mm9.NTGANTCANNNTGANTCAN.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa.masked -motif NTGANTCANNNTGANTCAN -strand 2 -position ../result/mm9/mm9.masked.NTGANTCANNNTGANTCAN.pos.txt & 

# 5/2/2014
# perl Motif_Search.pl -seq ../data/zebrafish/danRer7.fa -motif CG -strand 2 -position ../data/zebrafish/danRer7.CG.pos.txt & 
# perl Motif_Search.pl -seq ../data/coelacanth/latCha1.fa -motif CG -strand 2 -position ../data/coelacanth/latCha1.CG.pos.txt & 

# 5/12/2014
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa -motif CGCAA -strand 2 -position ../result/mm9/chr_all.CGCAA.pos.txt & 

# 11/20/2014
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif TGACTCA -strand 2 -position ../data/hg19/chr_all.TGACTCA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/mm9/chr_all.fa -motif TGACTCA -strand 2 -position ../data/mm9/chr_all.TGACTCA.pos.txt & 

# 3/10/2016
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif TTGCGCAA -strand 2 -position ../data/hg19/chr_all.TTGCGCAA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif TGACGTCA -strand 2 -position ../data/hg19/chr_all.TGACGTCA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif TGACGCAA -strand 2 -position ../data/hg19/chr_all.TGACGCAA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif TGATGCAA -strand 2 -position ../data/hg19/chr_all.TGATGCAA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif CTACGCAA -strand 2 -position ../data/hg19/chr_all.CTACGCAA.pos.txt & 


# 3/14/2016
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif TGACTCA -strand 2 -position ../data/hg19/chr_all.TGACTCA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif CCCCGCCC -strand 2 -position ../data/hg19/chr_all.CCCCGCCC.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif CCGGAA -strand 2 -position ../data/hg19/chr_all.CCGGAA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif CGCGAAA -strand 2 -position ../data/hg19/chr_all.CGCGAAA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif CACGTG -strand 2 -position ../data/hg19/chr_all.CACGTG.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif CGCCTGCG -strand 2 -position ../data/hg19/chr_all.CGCCTGCG.pos.txt & 


# 5/25/2016
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif CATGGTAC -strand 2 -position ../data/hg19/chr_all.CATGGTAC.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif CATCGTAC -strand 2 -position ../data/hg19/chr_all.CATCGTAC.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif TTGCGTGA -strand 2 -position ../data/hg19/chr_all.TTGCGTGA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif TCACGTGA -strand 2 -position ../data/hg19/chr_all.TCACGTGA.pos.txt & 
# perl Motif_Search.pl -seq /fdb/genome/hg19/chr_all.fa -motif CTGCGCAA -strand 2 -position ../data/hg19/chr_all.CTGCGCAA.pos.txt & 


use strict;
use diagnostics;
use warnings;
use Getopt::Long;


my %opts=();
GetOptions(\%opts,"seq:s","motif:s","position:s","strand:s");
unless ((defined $opts{seq}  and defined $opts{motif} and defined $opts{position} and defined $opts{strand}) or defined $opts{help} ){
	&usage (); 
}

open SEQ, $opts{seq} or die "Cannot open file: $opts{seq}!\n";
open POS,">$opts{position}" or die "Cannot create file: $opts{position}!\n";

my $motif = $opts{motif};
my $strand = $opts{strand};

my %promoter=();
my $name=();
my %pattern=();
my $mer	= 0;
my $merMin = 0;
my $merMax = 0;
my %pairStat = ();
my $SeqNum = 0;
my $Tag = 0;

while (<SEQ>)
{
	chomp;
	#chop; #if the sequence is the human and mouse promoter
	if ($_=~/^>(\S+)/) {
		$name=$1;
		#print "Is extracting the sequence of $name\!\n";
	}else{
		$_=~tr/acgt/ACGT/;
	$promoter{$name}.=$_;
	}
}
close SEQ;

foreach my $currentSeq (sort keys %promoter) {
	#print "Searching $motif in the sequence of $currentSeq\n";
	my @Pos = &findMotif($motif,$promoter{$currentSeq},$strand);
	for (my $i=0;$i<@Pos;$i++) {
		my @tmp=split(/\_/,$Pos[$i]);
		my $motifLen = &calculateMotifLen($motif);
		my $stop = $tmp[2]+$motifLen;
		print POS "$currentSeq\t$tmp[2]\t$stop\t$tmp[0]\t$tmp[1]\n";
	}
}


close POS;

print "Job finished!\n";


################################################################################################
#	 Your Sub-function goes here.

sub formatTag{	#add "0" to a certain number as to get the tidy ID/Tag.
	my ($prefix, $CurNumber, $Digit) = @_;

	my $length=length $CurNumber;
	if ( $length <= $Digit) {
		while ( $Digit - $length ++)
			{
				$prefix.="0";
			}
			my $Tag =$prefix.$CurNumber;
			return ($Tag);
	}
	else
	{
		print "Can not format your tag: $CurNumber, it's length more than your required Digits: $Digit. \n";
		exit;
	}
}

sub revdnacomp { #A function to figure out the reverse complement of a DNA sequence 
	my $dna = shift;
	my $revcomp = reverse($dna);
	$revcomp =~ tr/ACGTacgt/TGCAtgca/;
	return $revcomp;
}

sub isPalindromic{
	my $dna = shift;
	my $tag	=0;
	my $tmp = $dna;
	$tmp=~s/\[(\d+)\,(\d+)\]//g;
	if ($tmp eq &revdnacomp($tmp)){
		$tag = 1;
	}
	return $tag;
}

sub calculateMotifLen{ # Calculate the length of the Motif
	my $motif = shift;
	my $tmp = $motif;
	$tmp=~s/\[(\d+)\,(\d+)\]//g;
	my $mer = length($tmp);
	if ($motif=~/\[(\d+)\]/) {
		$mer = $mer + $1 -1;
		return $mer;
	}

	if ($motif=~/\[(\d+)\,(\d+)\]/) {
		my $merMin=$mer + $1 - 1;
		my $merMax=$mer + $2 - 1;	
		return $merMin."_".$merMax;
	}
	return $mer;
}

sub transMotif{ # Transformation of the Motif
	my $motif=shift;
	my $transform = $motif;
	$transform=~tr/[]N/{}w/;
	$transform=~s/w/\\w/g;
	return $transform;
}

sub findMotif{ #find the motif in the given sequence
	my ($motif, $sequence, $strand) = @_;
	my $seqLen=length($sequence);
	my @motifPos = ();
	my $motifLen = &calculateMotifLen($motif);
	my $transform = &transMotif($motif);
	
	if (&isPalindromic($motif) eq "1") {
		$strand = 0;
	} # if the motif is a palindromic sequence, search the sequence on the plus strand only
	
	if ($strand eq "0") {
		if ($motifLen=~/(\d+)\_(\d+)/) {
			my $merMin	= $1;
			my $merMax	= $2;
			for (my $mer=$merMin;$mer<=$merMax;$mer++) {
				for(my $i=0;($i+$mer)<$seqLen;$i++) {
					my $SeqMer=substr($sequence,$i,$mer);
					if ($SeqMer=~/^$transform$/) {
						push (@motifPos,$SeqMer."_+_".$i);
					}
				}
			}
		}else{
			for(my $i=0;($i+$motifLen)<$seqLen;$i++) {
				my $SeqMer=substr($sequence,$i,$motifLen);
				#print "$SeqMer\t$i\n";
				if ($SeqMer=~/^$transform$/) {
						push (@motifPos,$SeqMer."_+_".$i);
				}
			}
		}
		return @motifPos;
	}# Search the motif only in the top strand
	if ($strand eq "1") {
		my $revSeq = &revdnacomp($sequence);
		if ($motifLen=~/(\d+)\_(\d+)/) {
			my $merMin	= $1;
			my $merMax	= $2;
			for (my $mer=$merMin;$mer<=$merMax;$mer++) {
				for(my $i=0;($i+$mer)<$seqLen;$i++) {
					my $SeqMer=substr($revSeq,$i,$mer);
					if ($SeqMer=~/^$transform$/) {
						my $revPos = $seqLen-$i-$mer;
						push (@motifPos,$SeqMer."_-_".$revPos);
					}
				}
			}
		}else{
			for(my $i=0;($i+$motifLen)<$seqLen;$i++) {
				my $SeqMer=substr($revSeq,$i,$motifLen);
				if ($SeqMer=~/^$transform$/) {
						my $revPos = $seqLen-$i-$motifLen;
						push (@motifPos,$SeqMer."_-_".$revPos);
				}
			}
		}
		return @motifPos;
	}#Search the motif only in the bottom strand

	if ($strand eq "2") {

		my $revSeq = &revdnacomp($sequence);
		if ($motifLen=~/(\d+)\_(\d+)/) {
			my $merMin	= $1;
			my $merMax	= $2;
			for (my $mer=$merMin;$mer<=$merMax;$mer++) {
				for(my $i=0;($i+$mer)<$seqLen;$i++) {				
					my $SeqMer=substr($sequence,$i,$mer);
					if ($SeqMer=~/^$transform$/) {
						push (@motifPos,$SeqMer."_+_".$i);
					}	#Plus strand

					my $revSeqMer=substr($revSeq,$i,$mer);
					if ($revSeqMer=~/^$transform$/) {
						my $revPos = $seqLen-$i-$mer;
						push (@motifPos,$revSeqMer."_-_".$revPos);
					}	# Minus strand
				}
			}
		}else{
			for(my $i=0;($i+$motifLen)<$seqLen;$i++) {

				my $SeqMer=substr($sequence,$i,$motifLen);
				if ($SeqMer=~/^$transform$/) {
						push (@motifPos,$SeqMer."_+_".$i);
				}	#Plus strand
				
				my $revSeqMer=substr($revSeq,$i,$motifLen);
				if ($revSeqMer=~/^$transform$/) {
						my $revPos = $seqLen-$i-$motifLen;
						push (@motifPos,$revSeqMer."_-_".$revPos);
				}	#minus Strand
			}# end of for
		}
		return @motifPos;
	} #Search motif on both strands.

}#end of findMotif


sub usage{
    warn <<"_WARN_";  
    
****************************THIS IS A HELP DOCUMENT***************************
	
Description:Give informtion as below: 
	
USAGE:   
	perl $0 -GR input file 1 -cJun input file 2 - output file1 name(contains path)
	
OPINIONS:
	-GR	data.list(contains path), the file of clone position in the genome. must be given  	   
	-cJun	data.list(contains path), the reference file of clusters of clones, position in the genome. must be given  	 
	-o	Output file(contains path), the whole result of clusters of clones. must be given

NOTE:
	Please type "perl $0 help" to display this help document.

****************************THIS IS A HELP DOCUMENT***************************
_WARN_
    exit(1);
}	

# End of Sub-function.
