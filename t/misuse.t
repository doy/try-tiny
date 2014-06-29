#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

use Try::Tiny qw(:DEFAULT try_again $TRIES);
use constant TA_CROAK => qr/try_again called outside of catch block/;

sub kaboom { try_again; }

try {
  try_again;
} catch {
  like($_, TA_CROAK, "try_again can't be called inside try{}");
};

try {
  try { die; } catch { kaboom; };
} catch {
  like($_, TA_CROAK, "try_again can't be called deeply inside catch{}");
};

try {
  $TRIES = 0;
} catch {
  like($_, qr/read-only/, "cannot assign to \$TRIES");
};
