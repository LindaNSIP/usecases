#!/usr/bin/perl
use perl5i::2;

sub getfile {
	my ($includename) = @_;
	print STDERR " include = $includename\n";
	open (my $IF, $includename);
	my $ret = "";
	while (<$IF>) {
		$ret .= $_;
	}
	close $IF;
	return $ret;
}

my $infile = $ARGV[0];
my $outfile = $infile;
$outfile =~ s/docs/build/;
$outfile =~ s/mdx$/md/;

my $dir = $infile;
$dir =~ s/[^\/]+$//;

print STDERR "$infile -> $outfile\n";

open (my $INFILE, $infile);
open (my $OUTFILE, "> $outfile");

chdir $dir;

my $buffer = "";
while(<$INFILE>) {
	$buffer .= $_;
}

$buffer =~ s/
	^include (.+)$
/
	getfile($1)
/mxge;

# XXX Need to fix relative root path URLs
# $buffer =~ s|/docs/|../|g;

print $OUTFILE $buffer;

