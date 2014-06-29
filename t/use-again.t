#! /usr/bin/perl

use strict;
use warnings;
use Test::More tests => 1;

BEGIN { Test::More::use_ok('Try::Tiny', qw(:DEFAULT try_again $TRIES)); }
