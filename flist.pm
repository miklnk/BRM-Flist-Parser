#!/usr/bin/perl
# Basic Flist class to represent a single element in an flist
use strict;
use warnings;

package flist;

sub new {
  my $class = shift;
  my $self = {
    depth       => shift,
    field       => shift,
    type        => shift,
    element_id  => shift,
    value       => shift,
  };
  bless $self, $class;
  return $self;
}

1;
