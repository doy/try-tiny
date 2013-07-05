#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

BEGIN {
	plan skip_all => "Sub::Name required"
		unless eval { require Sub::Name; 1 };
	plan tests => 4;
}

BEGIN { use_ok 'Try::Tiny' }

my $name;
try {
	$name = (caller(0))[3];
};
is $name, "main::try {...}", "try name";

try {
	die "Boom";
} catch {
	$name = (caller(0))[3];
};
is $name, "main::catch {...} ", "catch name"; # note extra space

try {
	die "Boom";
} catch {
	# noop
} finally {
	$name = (caller(0))[3];
};
is $name, "main::finally {...} ", "finally name"; # note extra space

