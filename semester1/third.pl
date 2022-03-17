#!/usr/bin/perl

use strict;
use warnings;

my @elements = @ARGV;

my $first;
$first = { value => '0', 'prev' => $first, 'next' => $first };

my $pointer = $first;

my $pos = 1;
my $count = 1;
for (@elements) {
    if ($pos > $count) {
        $pos = 1;
    } elsif ($pos < 0) {
        $pos = $count;
    }
    if ( $_ eq '-' ) {
        $pointer = $pointer->{'prev'};
        $pos--;
    } elsif ( $_ eq '+' ) {
        $pointer = $pointer->{'next'};
        $pos++;
    } else {
    my $elem = { value => $_, 'prev' => $pointer, 'next' => undef };
    
    if ($pos < $count) {
        $elem->{'next'} = $pointer->{'next'};
        $pointer->{'next'}->{'prev'} = $elem;
    } else {
        $first->{'prev'} = $elem;
        $elem->{'next'} = $first;
    }
    $pointer->{'next'} = $elem;
    $pointer = $elem;
    $count++;
    $pos++;
    }
}

my $current = $first;

for ( ; ; ) {
    print $current->{value}, " ";
    $current = $current->{'next'};

    if ($first == $current) {
        last;
    }
}
