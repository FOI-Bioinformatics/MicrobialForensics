#!/usr/bin/perl -w
#
# program for calculating genetic variation in a sample x feature matrix
# by Jon Ahlinder

use warnings;

die "usage: calc_genetic_variation.pl <filename of sample x feature data> <measure: 1 is variation, 2 is gene diversity>\n" if ( $#ARGV != 1 );

chomp($file = $ARGV[0]);
chomp($method = $ARGV[1]);

open(FILE, "<$file" ) or die "Can't open $file : $!";
chomp(@LISTREF = <FILE>);
close(FILE);

foreach $line (@LISTREF){
  @tmp = split(/\t/,$line);
  $nloci = scalar(@tmp)-1;
  print "The number of SNPs is: " . $nloci . "\n";
  $sample = $tmp[0];
  #my $pos = 1;
  if ($sample !~ m/Sample/){
    my $var = 0.0;
    foreach $fr (@tmp){
      if($fr !~ m/^[A-Za-z]/){
        my $fr2 = $fr * 0.01;
        if($method==1){
          $var += $fr2*(1.0-$fr2);
        }
        else{
          $var += $fr2*$fr2;
        }
      #$feature{$sample}{$pos} = $fr;
      #$pos++;
      }
    }
    if($method==1){ print $sample . "\t" . $var . "\n"; }
    else{
      $var2 = 1-$var/$nloci;
      print $sample . "\t" . $var2 . "\n";
    }
  }
}
