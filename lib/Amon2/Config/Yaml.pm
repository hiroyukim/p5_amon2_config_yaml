package Amon2::Config::Simple;
use strict;
use warnings;
use File::Spec;
use YAML::Syck;
use Carp ();

sub load {
    my ($class, $c) = (shift, shift);
    my %conf = @_ == 1 ? %{$_[0]} : @_;

    my $env = $conf{environment} || $c->mode_name || 'development';
    my $fname = File::Spec->catfile($c->base_dir, 'config', "${env}.yaml");
    local $YAML::Syck::ImplicitUnicode = 1;
    my $config = YAML::Syck::LoadFile($fname);
    Carp::croak("$fname: $@") if $@;
    Carp::croak("$fname: $!") unless defined $config;
    unless ( ref($config) eq 'HASH' ) {
        Carp::croak("$fname does not return HashRef.");
    }
    return $config;
}

1;
__END__

=encoding utf-8

=head1 NAME

Amon2::Config::Yaml - Default configuration file loader

=head1 SYNOPSIS

    package MyApp2;
    # do "config/@{{ $c->mode_name ]}.yaml"
    use Amon2::Config::Yaml;
    sub load_config { Amon2::Config::Yaml->load(shift) }

=head1 DESCRIPTION

This is a default configuration file loader for L<Amon2>.

This module loads the configuration by yaml.

Amon2 using configuration file in C<< "config/@{[ $c->mode_name ]}.yaml" >>.

=head1 HOW DO YOU USE YOUR OWN ENVIRONMENT VARIABLE FOR DETECTING CONFIGURATION FILE?

If you want to use "config/$ENV{RUN_MODE}.yaml" for the configuration file, you can write code as following:

    package MyApp;
    use Amon2::Config::Yaml;
    sub load_config { Amon2::Config::Yaml->load(shift, +{ environment => $ENV{RUN_MODE} } ) }

