#!/usr/bin/env perl

=pod

=head1 fig.pl --- fix hideous MP4 files that pretend to be GIFs.

usage:

=over

fig.pl [-ci] file

=back

This utility deals with files whose extension is ".gif", but actually
contain MP4 videos.  This has became common with online gifs,
especially on i.reddit and imgur where when a file is downloaded, it
can't be played because of this practice, which is probably employed
to save bandwidth.

By default, this tool checks the initial bytes of the .gif file, and
if necessary, changes its suffix with the correct one.

By default, if the new name is the same with that of an existing file,
the utility will exit with a non-zero status code.  However, if the
"-i" flag is passed, then it'll prompt for the new name in case of a
name clash.

=cut

use v5.24;
use strict;
use warnings;

use File::Basename qw(fileparse);
use Getopt::Long;

my $convert = 0;
my $interactive = 0;

GetOptions("convert|c" => \$convert, "interactive|i" => \$interactive)
    or die "Parsing command line: $!";

my $file = shift @ARGV or die "Too few arguments";

# The string to look for in order to determine if a file is actually
# an MP4 file.  The first line from the initial character should
# match.
my $prefix = "    ftypisom";

my $fh;
my $bytes;

open($fh, "<", $file) or die "IO error: $!: \`$file'";

read($fh, $bytes, length($prefix));

die "Not a video file: $file" unless $bytes eq $prefix;

my ($sname, $spath, $ssuffix) = fileparse $file;

# Renove the suffix(es) from the file name.
my @sparts = split /\./, $sname;
my $sroot = $sparts[0];

unless($spath eq "./"){
    chdir $spath;
    say "In $spath";
}

my $newname = $sroot . ".mp4";
while (-e $newname) {
	if ($interactive) {
	    say "A file with name \`$newname' exists.";
	    say "Please enter a new name for $sname:";
	    my $newname = <STDIN>;
	    chomp $newname;
	} else {
	    die "File exists: $newname";
	}
}
rename $file, $newname or die "Rename $file => $newname: $!";
say "Renamed: $sname => $newname";

