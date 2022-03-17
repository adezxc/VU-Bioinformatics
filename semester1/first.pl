#!/usr/bin/perl

use strict;
use warnings;

my @words = @ARGV;
my $word_count = scalar(@words);
my $longest_word = 0;
my (%occurence_table, @unique_word_order);

# Sentence wordcount
print $word_count,"\n";

# Reversed sentence
for (my $i = $word_count-1; $i >= 0; $i--) {
    print $words[$i], " ";
}
print "\n";

for (my $i = 0; $i < $word_count; $i++) {
    # Every second word
    print $words[$i], " " if $i % 2 == 0;

    # Creating a hash and array of unique words.
    # Array is used for the purpose of saving the occurence order of the words,
    # while the hash serves as a structure to increment the word occurence by value.
    unless (exists $occurence_table{$words[$i]}) { 
        $occurence_table{ $words[$i] } = 1;
        push (@unique_word_order, $words[$i])
    } else {
        $occurence_table{ $words[$i] }++;
    }

    # Find longest word
    $longest_word = $words[$i] if length( $words[$i] ) > length($longest_word);
}
print "\n";

#Print out the unique words and their occurences
for (my $i = 0; $i < scalar(%occurence_table); $i++)
{
   print $unique_word_order[$i], " ", 
   $occurence_table{ $unique_word_order[$i] },"\n";
}

#Print out all the longest words in the input sentence
for (@words) {
    print $_," " if length($_) == length($longest_word)
}
print "\n";
