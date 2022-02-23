#!/usr/bin/perl

use strict;
use warnings;

my @numbers = @ARGV;
my $swapped;
my @positives = grep { $_ >= 0 } @numbers;
my $length = scalar(@positives);

my $temp;

print join(" ", grep { $_ < 0 } @numbers), "\n";

for (my $i = 0; $i < $length-1; $i++) {
    $swapped = 0;
    
    for (my $j = 0; $j < $length-$i-1; $j++) {
        if ($positives[$j] > $positives[$j+1]) {
            ($positives[$j+1], $positives[$j]) = ($positives[$j], $positives[$j+1]);
            $swapped = 1;
        }
    }

    if (!$swapped) {
        last
    }
}

print join(" ", @positives), "\n";
