use strict;

use ExtUtils::MakeMaker;

require 5.006;

WriteMakefile(
  NAME         => 'Try::Tiny',
  VERSION_FROM => 'lib/Try/Tiny.pm',
  INSTALLDIRS  => 'site',
  PL_FILES     => { },
  PREREQ_PM    => {
    'Test::More' => 0,
  },
  META_MERGE => {
    dynamic_config => 0,
    resources => {
      homepage => 'https://github.com/doy/try-tiny.git',
      repository => 'git://github.com/doy/try-tiny.git',
    },
  },
);
