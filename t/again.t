#! /usr/bin/perl

use strict;
use warnings;

use constant OUTER_RETRY_MAX => 3;
use constant INNER_RETRY_MAX => 6;

use Test::More tests =>
    ( 4                                       # end tests
      + INNER_RETRY_MAX * 1 * OUTER_RETRY_MAX # inner tests
      + OUTER_RETRY_MAX * 6 );                # outer tests

use Try::Tiny qw(:DEFAULT try_again $TRIES);

my ($tries, $inner_tries);
my ($finally1, $finally2) = (0, 0);

try {
  $tries++;

  is($TRIES, $tries, "outside try{} ($tries), \$TRIES is correct ($TRIES)");
  is($finally1, 0, "outside try{} ($tries), finally {} hasn't run yet");
  is($finally2, 0, "outside try{} ($tries), second finally {} hasn't run yet");

  die "Aargh";
} catch {

  is($TRIES, $tries, "outside catch{} ($tries), \$TRIES is correct ($TRIES)");
  is($finally1, 0, "outside catch{} ($tries), finally {} hasn't run yet");
  is($finally2, 0, "outside catch{} ($tries), second finally {} hasn't run yet");

  $inner_tries = 0;
  try {
    $inner_tries++;
    die "Hgraa";
  } catch {
    is($TRIES, $inner_tries, "inside catch{} ($tries.$inner_tries), \$TRIES is correct ($TRIES)");
    try_again if $TRIES < INNER_RETRY_MAX;
  };

  try_again if $TRIES < OUTER_RETRY_MAX;

} finally {
  $finally1++;
} finally {
  $finally2++;
};

is($tries, OUTER_RETRY_MAX, "No. of outer tries correct");
is($inner_tries, INNER_RETRY_MAX, "No. of inner tries correct");
is($finally1, 1, "first finally{} ran once");
is($finally2, 1, "second finally{} ran once");
