#!/usr/bin/perl -w
#
# program for summarizing variant calling results
# by Jon Ahlinder

use warnings;

die "usage: extract_variants_from_vcf_file.pl <filename of .vcf file>\n" if ( $#ARGV != 0 );

chomp($file = $ARGV[0]);
#chomp($thres = $ARGV[1]);

open(FILE, "<$file" ) or die "Can't open $file : $!";
chomp(@LISTREF = <FILE>);
close(FILE);

# sample order
my @sample = ("A2","A4-10","A4-11","A4-12","A4-13","A4-14","A4-15","A4-9","A6-10","A6-11","A6-12","A6-13","A6-14","A6-15","A6-9","A8-10","A8-11","A8-12","A8-13","A8-14","A8-15","A8-9","B2","B4-1","B4-2","B4-3","B4-4","B4-5","B4-6","B4-7","B6-1","B6-2","B6-3","B6-4","B6-5","B6-6","B6-7","B8-1","B8-2","B8-3","B8-4","B8-5","B8-6","B8-7","FSC237ClpB","A10-9","A10-10","A10-11","A10-12","A10-13","A10-14","A10-15","B10-1","B10-2","B10-3","B10-4","B10-5","B10-6","B10-7","A26-9","A26-10","A26-11","A26-12","A26-13","A26-14","A26-15","B26-1","B26-2","B26-3","B26-4","B26-5","B26-6","B26-7");

my @pos = ();

foreach my $line (@LISTREF){
  if($line !~ /\#/){
    @tmp = split('\t',$line);
    push(@pos,$tmp[1]);
    # print $tmp[9] . "\n";
    my $j = 0;
    my $k = 0;
    foreach $el (@tmp){
      if($j > 8){
        @tmpfreq = split('\:',$el);
        $tmpfreq[6] =~ s/\%$//;
  #      print "k = " . $k . " sample: " . $sample[$k] . "\n";
        $data{$sample[$k]}{$pos[$#pos]} = $tmpfreq[6];
        $k++;
      }
      $j ++;
    }
  #  print $tmpfreq[6] . "\n";
  }
}
# print sample x variant table
print "Sample";
foreach $el (@pos){
  print "\t" . $el;
}
print "\n";

foreach $samp (sort keys %data){
  print $samp;
    foreach $pos (sort {$a <=> $b} keys %{$data{$samp}}){
      print "\t" . $data{$samp}{$pos};

    }
  print "\n";
}
