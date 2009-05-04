
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Dist-Zilla-Plugin-ReadmeFromPod',
  NAME      => 'Dist::Zilla::Plugin::ReadmeFromPod',
  AUTHOR    => 'Fayland\ Lam\ \<fayland\@gmail\.com\>',
  ABSTRACT  => 'Automatically convert POD to a README for Dist::Zilla',
  VERSION   => '0.02',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "IO::Scalar" => '0',
    "Pod::Text" => '0',
    "Dist::Zilla" => '1.007',
  },
);
