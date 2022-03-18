#!/usr/bin/perl

use strict;
use warnings;

my $firstLetter = "a";
my @elements    = @ARGV;
my @firstLetterWords;
my @symbols;
my %symbolFrequency;

for (@elements) {
    my $first = substr $_, 0, 1;
    if ( lc $first eq $firstLetter ) {
        push( @firstLetterWords, $_ );
    }
    my @words = split( //, $_ );
    push( @symbols, @words );
}

my $count = scalar(@symbols);

for (@symbols) {
    if ( !exists( $symbolFrequency{ $_ } ) ) {
        $symbolFrequency{ $_ } = 1;
    }
    else {
        $symbolFrequency{ $_ }++;
    }
}

print join( ' ', @firstLetterWords );

my @keys = sort { $symbolFrequency{$b} <=> $symbolFrequency{$a} || $a cmp $b }
  keys %symbolFrequency;
my @vals = @symbolFrequency{@keys};

for (@keys) {
    print "\n";
    print $_, ' ', $symbolFrequency{$_}, ' ';
    printf( "%.2f", $symbolFrequency{$_} / $count );
}

