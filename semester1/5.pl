#!usr/bin/perl

use strict;
use warnings;

if ( scalar(@ARGV) == 0 ) {
    die $0, ":no argument given";
}

my @arguments      = @ARGV;
my $file_count     = 0;
my $line_count     = 0;
my $set_line_count = 0;
my @results;
my $scalar_argument = "--scalar";
my $scalar_mode     = 0;

if ( grep( /^$scalar_argument$/, @arguments ) ) {
    $scalar_mode = 1;
    if ( scalar(@arguments) < 3 ) {
        die $0, ":scalar argument found, but less than two files given";
    }
}

for (@arguments) {
    if ( $_ eq "--scalar" ) {
        next;
    }
    else {
        open( my $input, '<', $_ ) or die $0, ":", $_, ":failed to open file:";
        while ( my $line = <$input> ) {
            if ( $file_count != 0 ) {
                $results[ $. - 1 ] *= $line;
            }
            else {
                push( @results, $line );
            }
            $line_count++;
        }
        close($input);
        $file_count++;
        if ( $file_count == 1 ) {
            $set_line_count = $line_count;
        }
        elsif ( $line_count != $set_line_count ) {
            die $0, ": ", $_, ": wrong amount of lines",;
        }
        $line_count = 0;
    }
}
if ($scalar_mode) {
    my $product = 0;
    for (@results) {
        $product += $_;
    }
    print $product, "\n";
}
else {
    for (@results) {
        print $_, "\n";
    }
}
