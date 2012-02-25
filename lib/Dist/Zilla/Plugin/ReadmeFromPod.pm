package Dist::Zilla::Plugin::ReadmeFromPod;
{
    $Dist::Zilla::Plugin::ReadmeFromPod::VERSION = '0.06';
}

# ABSTRACT: Automatically convert POD to a README for Dist::Zilla

use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::FileGatherer';

has filename => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_filename',
);

sub _build_filename {
    my $self = shift;
    $self->zilla->main_module->name;
}

sub gather_files {
    my ( $self, $arg ) = @_;

    require Dist::Zilla::File::FromCode;

    my $file = Dist::Zilla::File::FromCode->new(
        {
            code => sub {
                my $mmcontent = $self->zilla->files->grep(
                    sub {
                        $_->name eq $self->filename;
                    }
                )->head->content;

                require Pod::Text;
                my $parser = Pod::Text->new();
                $parser->output_string( \my $input_content );
                $parser->parse_string_document($mmcontent);

                my $content;
                if ( defined $parser->{encoding} ) {
                    $content = encode( $parser->{encoding}, $input_content );
                }
                else {
                    $content = $input_content;
                }

                return $content;
            },
            name => 'README',
        }
    );
    $self->add_file($file);

    return;
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::ReadmeFromPod - Automatically convert POD to a README for Dist::Zilla

=head1 VERSION

version 0.06

=head1 SYNOPSIS

    # dist.ini
    [ReadmeFromPod]

    # or
    [ReadmeFromPod]
    filename = lib/XXX.pod

    # to fix "[DZ] attempt to add README multiple times; added by: @Filter/Readme
    [@Filter]
    remove = Readme

    [ReadmeFromPod]

=head1 DESCRIPTION

generate the README from C<main_module> (or specified) by L<Pod::Text>

The code is mostly a copy-paste of L<Module::Install::ReadmeFromPod>

=head1 AUTHOR

Fayland Lam <fayland@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Fayland Lam.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
