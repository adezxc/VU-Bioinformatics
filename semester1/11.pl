#!/usr/bin/perl

use strict;
use warnings;

my $seq = '';
my $ic = 0;
my @matrix;

while ( <> ) {
    chomp $_;
    if ( $_ =~/^>.+/ ){
        if ($seq ne '') {
            AddFrequency($seq)
        }
        $seq = '';
    } else {
        $seq .= $_;
    }
}
if ($seq ne '') {
            AddFrequency($seq)
}

sub AddFrequency {
    my @seq = split("", shift);
    
    for (my $i = 0; $i < scalar(@seq); $i++) {
        if ($seq[$i] ne "." || $seq[$i] ne "-" || $seq[$i] ne " ") {
            $matrix[$i]{"$seq[$i]"}++;
        }
    }
}

for my $pos (@matrix) {
    my $sum;
    $sum += %$pos{$_} for keys %$pos;

    my %matrix_weights;
    $matrix_weights{$_} = %$pos{$_}/$sum for keys %$pos;

    my @sorted = sort { $pos->{$b} <=> $pos->{$a} || $a cmp $b} keys(%$pos);
    for my $key (@sorted) {
        $ic += $matrix_weights{$key} * log($matrix_weights{$key})/log(2);
        printf "$key: %.2f ", $matrix_weights{$key} if ($matrix_weights{$key} >= 1/20);
    }
    print "\n";
}

printf "IC = %.2f\n", $ic += scalar(@matrix) * log(20)/log(2);