#!/usr/bin/perl -w
#
# program for summarizing variant calling results
# by Jon Ahlinder

use warnings;

die "usage: calc_eucledian_dist.pl <filename of sample x feature data>\n" if ( $#ARGV != 0 );

chomp($file = $ARGV[0]);
#chomp($thres = $ARGV[1]);

open(FILE, "<$file" ) or die "Can't open $file : $!";
chomp(@LISTREF = <FILE>);
close(FILE);

my %pos = ();
my %freq = ();

# read data from file
foreach my $line (@LISTREF){
  @tmp = split(/\t/,$line);
  if($line =~ /^Sample/){
    my $k = 0;
    foreach $el (@tmp){
      if($el !~ /Sample/){
        $pos{$k} = $el;
        $k++;
      }
    }
  }
  else{
    @tmp = split(/\t/,$line);
    my $k = 0;
    my $sample = 0;
    foreach $el (@tmp){
      if($el =~ /[A-Za-z]/){
      #  print "add $el to sample list...\n";
        $sample = $el;
      }
      elsif($el =~ /^$/){
        $freq{$sample}{$pos{$k}} = 0;
        $k++;
      }
      else{
        #print "add $el to output...\n";
        $freq{$sample}{$pos{$k}} = $el*0.01;
        $k++;
      }
    }
  }
}
# calculate eucledian distance
my %dist =();

foreach $sample1 (sort keys %freq){
#  print $sample1;
  foreach $sample2 (sort keys %freq){
    if($sample1 =~ /$sample2/){
      $dist{$sample1}{$sample2} = 0;
    }
    elsif(!exists($dist{$sample1}{$sample2})){
      my $sum = 0;
      foreach $po1 (keys %{$freq{$sample1}}){
      #  foreach $po2 (keys %{$freq{$sample1}}){
        my $sqr = $freq{$sample1}{$po1}-$freq{$sample2}{$po1};
    #    print $sample1 . " " . $sample2 . " " . $freq{$sample1}{$po1} . " " . $freq{$sample2}{$po1} . "\n";
        $sum += $sqr * $sqr;
      #  }
      }
      $dist{$sample1}{$sample2} = sqrt($sum);
    }
  }
#  foreach $po (keys %{$freq{$sample}}){
#    print "\t" . $freq{$sample}{$po};
#  }
#  print "\n";
}
# assess hash content
print "sample";
foreach $sample1 (sort keys %dist){
  print "\t" . $sample1;
}
print "\n";
foreach $sample1 (sort keys %dist){
  print $sample1;
  foreach $sample2 (sort keys %dist){
    print "\t" . $dist{$sample1}{$sample2};
  }
  print "\n";
}
