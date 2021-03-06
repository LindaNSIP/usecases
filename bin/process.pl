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

system "pandoc $infile -o $outfile --template template/materialize/template/template.html --toc --toc-depth=2";

$outfile =~ s/html$/docx/;
system "pandoc $infile -o $outfile --reference-docx=sample/pandoc/template.docx --toc --toc-depth=2";
