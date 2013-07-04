#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 6;
use Try::Tiny;

sub _eval {
  local $@;
  local $Test::Builder::Level = $Test::Builder::Level + 2;
  return ( scalar(eval { $_[0]->(); 1 }), $@ );
}

sub throws_ok (&$$) {
  my ( $code, $regex, $desc ) = @_;
  local $Test::Builder::Level = $Test::Builder::Level + 1;

  my ( $ok, $error ) = _eval($code);

  if ( $ok ) {
    fail($desc);
  } else {
    like($error || '', $regex, $desc );
  }
}

throws_ok {
  try { 1 }; catch { 2 };
} qr/\QUseless bare catch()/, 'Bare catch() detected';

throws_ok {
  try { 1 }; finally { 2 };
} qr/\QUseless bare finally()/, 'Bare finally() detected';

throws_ok {
  try { 1 }; catch { 2 } finally { 2 };
} qr/\QUseless bare catch()/, 'Bare catch()/finally() detected';

throws_ok {
  try { 1 }; finally { 2 } catch { 2 };
} qr/\QUseless bare finally()/, 'Bare finally()/catch() detected';


throws_ok {
  try { 1 } catch { 2 } catch { 3 } finally { 4 } finally { 5 }
} qr/\QA try() may not be followed by multiple catch() blocks/, 'Multi-catch detected';


throws_ok {
  try { 1 } catch { 2 }
  do { 2 }
} qr/\Qtry() encountered an unexpected argument (2) - perhaps a missing semi-colon before or at/,
  'Unterminated try detected';
