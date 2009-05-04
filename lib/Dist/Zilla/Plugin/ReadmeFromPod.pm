package Dist::Zilla::Plugin::ReadmeFromPod;

# ABSTRACT: Automatically convert POD to a README for Dist::Zilla

use Moose;

#with 'Dist::Zilla::Role::FileGatherer';
with 'Dist::Zilla::Role::InstallTool';    # after PodWeaver

sub setup_installer {
    my ( $self, $arg ) = @_;

    require Dist::Zilla::File::InMemory;

    require IO::Scalar;
    my $content;
    my $out_fh = new IO::Scalar \$content;

    my $mmcontent = $self->zilla->main_module->content;

    require Pod::Text;
    my $parser = Pod::Text->new();
    $parser->output_fh($out_fh);
    $parser->parse_string_document($mmcontent);

    my $file = Dist::Zilla::File::InMemory->new(
        {
            content => $content,
            name    => 'README',
        }
    );

    $self->add_file($file);
    return;
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=head1 NAME

Dist::Zilla::Plugin::ReadmeFromPod - Automatically convert POD to a README for Dist::Zilla

=head1 VERSION

version 0.01

=head1 SYNOPSIS

    # dist.ini
    [ReadmeFromPod]

=head1 DESCRIPTION

generate the README from C<main_module> by L<Pod::Text>

The code is mostly a copy-paste of L<Module::Install::ReadmeFromPod>

=head1 AUTHOR

  Fayland Lam <fayland@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Fayland Lam.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.
