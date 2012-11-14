use strict;

use ExtUtils::MakeMaker;

require 5.005_04;

WriteMakefile(
	NAME         => 'Try::Tiny',
	VERSION_FROM => 'lib/Try/Tiny.pm',
	INSTALLDIRS  => 'site',
	PL_FILES     => { },
	PREREQ_PM    => {
		'Test::More' => 0,
	},
	META_MERGE => {
		resources => {
			homepage => 'https://github.com/doy/try-tiny.git',
			repository => 'git://github.com/doy/try-tiny.git',
		},
	},
);
