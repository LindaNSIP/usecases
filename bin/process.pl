#!/usr/bin/perl
use perl5i::2;
use File::Path;

my $infile = $ARGV[0];
my $outfile = $infile;
$outfile =~ s/build/output/;
$outfile =~ s/md$/html/;

my $indir = $infile;
$indir =~ s/[^\/]+$//;

my $outdir = $outfile;
$outdir =~ s/[^\/]+$//;

print STDERR "$infile -> $outfile\n";

mkpath $outdir;

system "pandoc $infile -o $outfile --template sample/pandoc/standalone.html --toc --toc-depth=2";
