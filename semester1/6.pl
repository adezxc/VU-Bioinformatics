#!/usr/bin/perl

use strict;
use warnings;

my @input;
my $line          = '';
my $complementary = 1;
my %complement    = (
    'A' => 'T',
    'T' => 'A',
    'G' => 'C',
    'C' => 'G',
);
my %init = (
    'A' => 1.03,
    'T' => 1.03,
    'G' => 0.98,
    'C' => 0.98
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
}
else {
    print "Enter FASTA files that you want to analyze \n";
    print "<Ctrl>-D to terminate \n";
    @input = <STDIN>;
    
}
chomp @input;

for (@input) {
    open( my $file, '<', $_ ) or die $0, ':', $_, ':failed to open file:';
    for (<$file>) {
        chomp $_;
        if ( ( substr $_, 0, 1 ) eq '>' ) {
            if ( $line ne '' ) {
                my $sum = 0;
                my @nucleotides = split( //, $line );
                if ( scalar(@nucleotides) % 2 != 0 ) {
                    $complementary = 0;
                }
                else {
                    for (
                        my $i = 0 ;
                        $i < ( scalar(@nucleotides) / 2 ) - 1 ;
                        $i++
                      )
                    {
                        if ( $nucleotides[$i] eq
                            $complement{ $nucleotides[ -1 - $i ] } )
                        {
                            next;
                        }
                        else {
                            $complementary = 0;
                        }
                    }
                }
                for ( my $i = 0 ; $i < scalar(@nucleotides) - 1 ; $i++ ) {
                    my $nucleopair = $nucleotides[$i] . $nucleotides[ $i + 1 ];
                    if ( exists( $values{$nucleopair} ) ) {
                        $sum += $values{$nucleopair};
                    }
                    else {
                        $nucleopair =~ tr/ACGT/TGCA/;
                        if ( exists( $values{$nucleopair} ) ) {
                            $sum += $values{$nucleopair};
                        }
                        else {
                            $nucleopair = reverse($nucleopair);
                            if ( exists( $values{$nucleopair} ) ) {
                                $sum += $values{$nucleopair};
                            }
                        }
                    }
                }
                $sum +=
                  $init{ $nucleotides[0] } +
                  $init{ $nucleotides[-1] } +
                  0.43 * $complementary;
                print $sum, "\n";
            }

            print $_, "\n";
            $line = '';
        }
        else {
            $line = $line . $_;
            next;
        }
    }

    close $file;
}
