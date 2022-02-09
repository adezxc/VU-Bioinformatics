#!/usr/bin/perl

use strict;
use warnings;

my @words = @ARGV;
my $length = scalar(@words);
my $longest = 0;git

print $length,"\n";

for (my $i = $length-1; $i >= 0; $i--) {
    print $words[$i], " ";
}
print "\n";

my %table;
my @frequencyTable;
my @frequency;

for (my $i = 0; $i < $length; $i++) {

    print $words[$i], " " if $i % 2 == 0;

    unless (exists $table{$words[$i]}) { 
        push(@frequencyTable, $words[$i]);
        push(@frequency, 1);
        $table{$words[$i]} = 1;
    } else {
        $table{$words[$i]}++;
    }

    $longest = length($words[$i]) if length($words[$i]) > $longest;
}
print "\n";

for (my $i = 0; $i < scalar(@frequencyTable); $i++)
{
  print $frequencyTable[$i], " ", $frequency[$i], "\n";
}

print $longest, "\n";
