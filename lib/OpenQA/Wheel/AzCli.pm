package OpenQA::Wheel::AzCli;
use Mojo::Base 'Exporter', -signatures;

use testapi qw(assert_script_run);

our @EXPORT_OK = qw(az_version);

=head1 introduction

=for stopwords os autoinst isotovideo openQA

This openQA wheel provides a perl wrapper around some of the az cli commands.

It is meant to be added to your distribution's wheels.yaml.

=cut

=head1 test API

=head2 az_version

    az_version();

Print the version of the az cli available on system
=cut

sub az_version {
    assert_script_run('az --version');
}

1;
