
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Dist::Zilla::Plugin::ReadmeFromPod',
                       'DISTNAME' => 'Dist-Zilla-Plugin-ReadmeFromPod',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Fayland Lam <fayland@gmail.com>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'Automatically convert POD to a README for Dist::Zilla',
                       'EXE_FILES' => [],
                       'VERSION' => '0.10',
                       'PREREQ_PM' => {
                                        'Dist::Zilla' => '1.007',
                                        'Pod::Text' => '3.13',
                                        'IO::Handle' => '0',
                                        'File::Temp' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM}; 
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod}; 
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



