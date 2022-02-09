#!/usr/bin/perl

use strict;
use warnings;

my @words = @ARGV;
my $length = scalar(@words);
my $longest = 0;

print $length,"\n";

for (my $i = $length-1; $i >= 0; $i--) {
    print $words[$i], " ";
}
print "\n";

my @table;
for (my $i = 0; $i < $length; $i++) {
    print $words[$i], " " if $i % 2 != 0;

    unless (exists $table[$i]) { push(@table, $words[$i]) }

    longest = length($words[$i]) if length($words[$i]) > $longest;
}

print "\n";

for (my $i = 0; $i < scalar(@table); $i++) {
    print $table[$i], " ";
}
