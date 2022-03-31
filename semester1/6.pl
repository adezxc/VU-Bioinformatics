#!/usr/bin/perl

use strict;
use warnings;

my @input;
my $line;
my %complement = (
    'A' => 'T',
    'T' => 'A',
    'G' => 'C',
    'C' => 'G',
);
my %values = (
    'AA' => -1.00,
    'AT' => -0.88,
    'TA' => -0.58,
    'CA' => -1.45,
    'GT' => -1.44,
    'CT' => -1.28,
    'GA' => -1.30,
    'CG' => -2.17,
    'GC' => -2.24,
    'GG' => -1.84,
);


if ( scalar(@ARGV) != 0 ) {
    @input = @ARGV;
} else {
    print "Enter FASTA files that you want to analyze \n";
    print "<Ctrl>-D to terminate \n";
    @input = <STDIN>;
}

chomp @input;

for ( @input ) {
    open( my $input, '<', $_ ) or die $0, ':', $_, ':failed to open file:';
    for ( <> ) {
        $line = $_;
        if ((substr $line, 0, 1) eq '>') {
            print $line;
        } else {
            $line += $_;
            next;
        }
    }

    close $input;
}

