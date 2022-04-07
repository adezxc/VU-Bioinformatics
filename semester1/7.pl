#!/usr/bin/perl

use strict;
use warnings;


die "You need to provide atleast one argument!" unless scalar(@ARGV) != 0;
my $trim = $ARGV[0];
my @chars = split(// , $trim); 
my $trim_regex = '';
my $trim_position = 0;
my $position = 0;
my ($product, @input, $head, $initial_position, );
my $seq = '';

my %fasta = (
    "R" => '[AG]',
    "Y" => '[CT]',
    "K" => '[GT]',
    "M" => '[AC]',
    "S" => '[CG]',
    "W" => '[AT]',
    "B" => '[CGT]',
    "D" => '[AGT]',
    "H" => '[ACT]',
    "V" => '[ACG]',
    "N" => '[ACGT]',
    "A" => '[A]',
    "C" => '[C]',
    "G" => '[G]',
    "T" => '[T]',
);

for (my $i = 0; $i < length($trim); $i++ ) {
    if ($chars[$i] ne '/') {
        $trim_regex = $trim_regex . $fasta{$chars[$i]};
    } else {
        $trim_position = $i;
    }
}

if ( scalar(@ARGV) != 1 ) {
    @input = @ARGV[1..$#ARGV];
} else {
    @input = <STDIN>;
    chomp @input;
}
my $i = 0;
for (@input) {
    open( my $file, '<', $_ ) or die $0, ':', $_, ':failed to open file:';
    my $fasta = join( '', <$file> );
    while ( $fasta =~ /(>[^\n]*)\n([^>]*)/g ) {
        $head = $1;
        $seq  = $2;
        $seq =~ s/\R//g;
        while ( $seq =~ /$trim_regex/g ) {
            $initial_position = $position;
            $position = "@+" + $trim_position - length($trim) + 1;
            if ( $position - $initial_position != 0 ) {
                print $head, " ", $position + 1, "\n";
                $product = substr( $seq, $initial_position, $position - $initial_position );
                print $product, "\n";
            }
        }
        print $head, "\n";
        print substr( $seq, $position, length($seq) - $position ), "\n";
        $initial_position = $position = 0;
    }
    close $file;
}

