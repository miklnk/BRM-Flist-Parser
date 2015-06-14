#!/usr/bin/perl
use strict;
use warnings;
use flist;


package flistParser;

sub new {
  my $class = shift;
  my $self = {
    _flist_as_str => shift,
    flist => undef,
  };
  bless $self, $class;
  return $self;
}

sub parse_flist {
  my ($self) = @_;
  my @lines = split /\n/, $self->{_flist_as_str};
  foreach my $line(@lines) {
  my($depth, $field, $type, $element_id, $value) = split / +/, $line;
  if ($type eq "STR" && $line =~ /"$/){
    $value = &quoteString($line);
    #print "Value: $value\n";
  }
  if ($type eq "POID"){
    $value = &poidObject($line);
    #print "Value: $value\n";
  }
  $self->{flist}{$field} = flist->new($depth, $field, $type, $element_id, $value);

  }
}
sub quoteString($) {
  my $string = shift;
  my $start_index = index($string, '"');
  my $substring = substr($string, $start_index, rindex($string, '"') - $start_index+1);
  return $substring;
}

sub poidObject($) {
  my $string = shift;
  my $start_index = index($string, ']');
  my $substring = substr($string, $start_index+1, length($string)- $start_index);
  return $substring;
}
1;
