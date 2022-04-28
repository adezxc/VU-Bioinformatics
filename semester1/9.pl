#!/usr/bin/perl

use strict;
use warnings;


my $seq = '';
my $filename = shift;
my %actions = ( cut => \&cut,
                subst => \&subst,
                complement => \&complement,
                insert => \&insert );

open(my $file, "<", $filename) or die "file not found";
my $command = shift;
while ( my $line = <$file> ) {
    if ( $line =~/^>.+/ ){
        if ($seq ne '') {
            $actions{$command}->($seq, @ARGV);
        }
        $seq = '';
    } else {
        $seq .= $line;
    }
}
$actions{$command}->( $seq, @ARGV );
close ($file);

sub cut ( $@ ) {
    my @seq = split("", shift);
    my $newSeq = '';
    for (@_) {
        if ($_ =~ /^([0-9]+)-([0-9]+)|([0-9]+)$/ ) {
            if (defined ($3)) {
                $newSeq .= $seq[$3]; 
            } else {
                if ($1 < $2) {
                    for (my $i = $1; $i <= $2; $i++) 
                        { $newSeq .= $seq[$i] }
                } else {
                    for (my $i = $1; $i >= $2; $i--) 
                        { $newSeq .= $seq[$i] }
                }
            }
        }
    }
    print $newSeq;
}

sub subst ( $$$ ) {
    my $seq = shift;
    my $find = shift;
    my $replacement = shift;
    $seq =~ s/$find/$replacement/g;
    print $seq;
}

sub complement ( $$ ) {
    my %complement    = (
    'A' => 'T',
    'T' => 'A',
    'G' => 'C',
    'C' => 'G',
    );

    my @seq = split("", shift);
    my $range = shift;
    if ($range =~ /^([0-9]+)-([0-9]+)|([0-9]+)$/ ) {
            if (defined ($3)) {
                $seq[$3] = $complement{ $seq[$3] }; 
            } else {
                if ($1 < $2) {
                    for (my $i = $1; $i <= $2; $i++) 
                        { $seq[$i] = $complement{ $seq[$i] }; }
                } else {
                    for (my $i = $1; $i >= $2; $i--) 
                        { $seq[$i] = $complement{ $seq[$i] } }
                }
            }
        }
    print @seq;
}

sub insert ( $$$ ) {
    my @seq = split("", shift);
    my $index = shift;
    my $insertion = shift;

    splice @seq, $index, 0, $insertion;
    print @seq;
}

