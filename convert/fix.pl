my $buffer = "";
while (<>) {
	$buffer .= $_;
}

$buffer =~ s/h3/h1/g;

$buffer =~ s/
	<p><strong>(.+)<\/strong><\/p>
/
<h2>$1<\/h2>
/xg;

# tbody
$buffer =~ s/<tbody>//g;
$buffer =~ s/<\/tbody>//g;

# tr
$buffer =~ s/<tr>//g;
$buffer =~ s/<\/tr>//g;

# td
$buffer =~ s/<td [^>]+>//g;
$buffer =~ s/<\/td>//g;

# div
$buffer =~ s/<div [^>]+>//g;
$buffer =~ s/<\/div>//g;

print $buffer;
