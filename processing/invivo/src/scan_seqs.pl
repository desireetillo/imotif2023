#!/usr/bin/perl
use strict;


if(@ARGV ==3){

    my $seq_file = $ARGV[0];
    my $motif = $ARGV[1];
    my $count_type = $ARGV[2];
    chomp $seq_file;
    chomp $motif;
    chomp $count_type;
    
    if($count_type eq 'positions'){
	my %matches_locations = ();
	my %matches_patterns = ();
	
	open(F, "$seq_file") || die "Couldn't open seq file: $!\n";
	while(my $line = <F>){
	    chomp $line;
	    my ($id, $seq) = split(/\t/, $line);
	    my $rc_motif = reverse $motif;
	    $rc_motif =~ tr/ATGC/TACG/;
	    if($rc_motif eq $motif){
		while($seq =~ /$motif/gi){
		    push @{$matches_locations{$id}}, $-[0];
		    push @{$matches_patterns{$id}}, substr($seq, $-[0],length($motif));
		}
	    }
	    else{
		while($seq =~ /$motif/gi){
		    push @{$matches_locations{$id}}, $-[0];
		    push @{$matches_patterns{$id}}, substr($seq, $-[0],length($motif));
		    
		    while($seq =~ /$rc_motif/gi){
			push @{$matches_locations{$id}}, $-[0];
			push @{$matches_patterns{$id}}, substr($seq, $-[0],length($motif));
		    }
		}
	    }
	}
	close F;
	foreach my $name( keys %matches_locations){
	    print"$name\t", join(",", @{$matches_locations{$name}}), "\t", join(",", @{$matches_patterns{$name}}), "\n";
	}
    }
    

    elsif($count_type eq 'counts'){
	my %matches = ();
	open(F, "$seq_file") || die "Couldn't open seq file: $!\n";
	while(my $line = <F>){
	    chomp $line;
	    my ($id, $seq) = split(/\t/, $line);
	    my $rc_motif = reverse $motif;
	    $rc_motif =~ tr/ATGC/TACG/;
	    if($rc_motif eq $motif){
		while($seq =~ /$motif/gi){
		    $matches{$id}++;
		}
	    }
	    else{
		while($seq =~ /$motif/gi){
		    $matches{$id}++;
		}
		while($seq =~ /$rc_motif/gi){
		    $matches{$id}++;
		}
		
	    }
	}
	close F;
	foreach my $name( keys %matches){
	    print"$name\t$matches{$name}\n";
	}   
    }
    
    elsif($count_type eq 'bed'){
	my %matches = ();
	my $count = 0;
	open(F, "$seq_file") || die "Coudldnt open seq fiel: $!\n";
	while(my $line = <F>){
	    chomp $line;
	    my ($id, $seq) = split(/\t/, $line);
	    my $rc_motif = reverse $motif;
	    $rc_motif =~ tr/ATGC/TACG/;
	    if($rc_motif eq $motif){
		while($seq =~ /$motif/gi){
		    $count++;
		    print "$id\t$-[0]\t", $+[0]-1, "\t$motif\t1\t+\n";
		}
	    }
	    else{
		while($seq =~ /$motif/gi){
		    $count++;
		    print "$id\t$-[0]\t", $+[0]-1, "\t$motif\t1\t+\n";
		}
		
		while($seq =~ /$rc_motif/gi){
		    $count++;
		    print "$id\t$-[0]\t", $+[0]-1, "\t$motif\t1\t-\n";
		}
	    }
	}
    }
    else{
	die "Unrecognized output type: $count_type (valid types: bed,count,positions)\n";
    }
}

else{
    print "scan_seq.pl script to scan a set of sequences in a stab file for a given motif.  output is to stdout\n";
    print "usage: scan_seq.pl <seq file stab> <motif> <output_type: either position list, counts, or bedfile>\n";
}

