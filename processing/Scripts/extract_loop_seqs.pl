#!/usr/bin/perl
use strict;

# extract_loop_seqs.pl
# Des
# script to extract loop sequences from iMotif probe sequence
# usage:  perl extract_loop_seqs.pl >info/iMotif_array_v2_uniq_probes.loops.txt

my $file="info/iMotif_array_v2_uniq_probes.txt";
open(F, "$file") || die "Couldn't open $file: $!\n";

while(my $line=<F>){
	chomp $line;
	if($line =~ /^New/){
		print "$line\tnseq\tloop1\tloop2\tloop3\n";
	}
	else{
		my $loop1=".";
		my $loop2=".";
		my $loop3=".";
		
		my ($nid, $seqClass,$probeIDs,$seqs,@etc) = split(/\t/, $line);
		my $nseq=substr($seqs, 0, -8);
#		print $nseq, "\n";
		if($seqClass eq "2_Cs"){
		 #   print $nseq;
		    if($nseq =~ /[C]{2}([ACTG]{1,19})[C]{2}([ACTG]{1,19})[C]{2}([ACTG]{1,19})[C]{2}/){

				$loop1=$1;
				$loop2=$2;
				$loop3=$3;	
			}
		}
		elsif($seqClass eq "3_Cs"){
			if($nseq =~ /[C]{3}([ACTG]{1,19})[C]{3}([ACTG]{1,19})[C]{3}([ACTG]{1,19})[C]{3}/){
				$loop1=$1;
				$loop2=$2;
				$loop3=$3;	
			}
		}
		elsif($seqClass eq "4_Cs"){
			if($nseq =~ /[C]{4}([ACTG]{1,19})[C]{4}([ACTG]{1,19})[C]{4}([ACTG]{1,19})[C]{4}/){
				$loop1=$1;
				$loop2=$2;
				$loop3=$3;	
			}
		}
		elsif($seqClass eq "5_10_Cs"){
			if($nseq =~ /[C]{5,10}([ACTG]{1,19})[C]{5,10}([ACTG]{1,19})[C]{5,10}([ACTG]{1,19})[C]{5,10}/){
				$loop1=$1;
				$loop2=$2;
				$loop3=$3;	
			}
		}
		$loop1=~ s/[C]{1,}$//;
		$loop2=~ s/[C]{1,}$//;
		$loop3=~ s/[C]{1,}$//;
		print "$line\t$nseq\t$loop1\t$loop2\t$loop3\n";
	
	}
}
close F;
