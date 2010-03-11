
use strict;
use warnings;



use ExtUtils::MakeMaker 6.11;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Dist::Zilla::Plugin::ReadmeFromPod',
                       'DISTNAME' => 'Dist-Zilla-Plugin-ReadmeFromPod',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.11'
                                               },
                       'AUTHOR' => 'Fayland Lam <fayland@gmail.com>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'Automatically convert POD to a README for Dist::Zilla',
                       'EXE_FILES' => [],
                       'VERSION' => '0.06',
                       'PREREQ_PM' => {
                                        'File::Temp' => '0',
                                        'IO::Handle' => '0',
                                        'Pod::Text' => '3.13',
                                        'Dist::Zilla' => '1.007'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



