#!/usr/bin/perl

use strict;
use warnings;

my @input;

scalar(@ARGV) != 0 or die "You need to provide atleast one argument!";
my $trim = $ARGV[1];

if ( scalar(@ARGV) != 1 ) {
    @input = @ARGV;
} else {
    print "Enter FASTA files that you want to analyze \n";
    print "<Ctrl>-D to terminate \n";
    @input = <STDIN>;
}
 