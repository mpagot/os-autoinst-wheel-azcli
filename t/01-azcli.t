#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Test::Exception;
use Test::Warnings;
use Test::MockModule;
use Test::Mock::Time;
use List::Util qw(any none);

use OpenQA::Wheel::AzCli;

subtest '[az_version]' => sub {
    my $azcli = Test::MockModule->new('sles4sap::azure_cli', no_auto => 1);
    my @calls;
    $azcli->redefine(assert_script_run => sub { push @calls, $_[0]; return; });

    az_version();

    note("\n  -->  " . join("\n  -->  ", @calls));
    ok((any { /az --version/ } @calls), '--version');
};

done_testing();
