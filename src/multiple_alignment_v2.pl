#!/usr/bin/perl -w
#
# program for summarizing variant calling results
# by Jon Ahlinder

use warnings;

die "usage: multiple_alignment.pl <directory of downloaded fasta files> <path to reference genome>\n" if ( $#ARGV != 1 );

chomp($cat = $ARGV[0]);
chomp($ref = $ARGV[1]);

opendir (DIR, $cat) or die $!;

while (my $file = readdir(DIR)) {
  if($file =~ /\.fasta$/ | $file =~ /\.fas$/ | $file =~ /\.fa$/ | $file =~ /\.fna$/){
    print "$file\n";
    @tmp = split(/\//,$ref);
    my $num = scalar @tmp;
    $refname = $ref;
  #  print $refname . "\n";
    $refname =~ s/\///g;
    $refname =~ s/\.//g;
    $refname =~ s/fna$//g;
    $refname =~ s/fasta$//g;
    $refname =~ s/fas$//g;
    $refname =~ s/fa$//g;
    $tmpfile = $file;
    $tmpfile =~ s/\.fna$//g;
    $tmpfile =~ s/\.fasta$//g;
    $tmpfile =~ s/\.fa$//g;
    $tmpfile =~ s/\.fas$//g;
    print "command run: \n";
    $command = "progressiveMauve --output=aligned_data_" . $refname . "_" . $tmpfile . ".xmfa " . $ref . " " . $cat . "/" . $file;
    print $command . "\n";
    system($command);
  }



}
closedir(DIR);

#open(FILE, "<$file" ) or die "Can't open $file : $!";
#chomp(@LISTREF = <FILE>);
#close(FILE);
