#!/usr/bin/perl -w
#
# program for adding zeros to frequency matrix
# by Jon Ahlinder

use warnings;

die "usage: list2matrix.pl <filename of output from distats.pl software>\n" if ( $#ARGV != 0 );

chomp($file = $ARGV[0]);

open(FILE, "<$file" ) or die "Can't open $file : $!";
chomp(@LISTREF = <FILE>);
close(FILE);

foreach $line (@LISTREF){
  if($line !~ /^Species/){
    @tmp = split(/\t/,$line);
    $dist{$tmp[1]}{$tmp[3]} = $tmp[4];
    $dist{$tmp[3]}{$tmp[1]} = $dist{$tmp[1]}{$tmp[3]};
    $dist{$tmp[1]}{$tmp[1]} = 0;
    $dist{$tmp[3]}{$tmp[3]} = 0;
  }
}

print "Sample";
foreach $id1 (sort keys %dist){
  print "\t" . $id1;
}
print "\n";
foreach $id1 (sort keys %dist){
  print $id1;
  foreach $id2 (sort keys %{$dist{$id1}}){
    print "\t" . $dist{$id1}{$id2};


  }
  print "\n";
}
