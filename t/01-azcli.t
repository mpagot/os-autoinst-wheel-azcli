#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Test::Exception;
use Test::Warnings;
use Test::MockModule;
use Test::Mock::Time;
use List::Util qw(any none);

# import mocked test API
use FindBin '$Bin';
use lib "$Bin/lib";
#use testapi;

# import modules we'd like to test
use lib "$Bin/..", "$Bin/../lib";
use OpenQA::Wheel::AzCli qw(az_version);

subtest '[az_version]' => sub {
    my $azcli = Test::MockModule->new('OpenQA::Wheel::AzCli', no_auto => 1);
    my @calls;
    $azcli->redefine(assert_script_run => sub { push @calls, $_[0]; return; });

    az_version();

    note("\n  C-->  " . join("\n  C-->  ", @calls));
    ok((any { /az --version/ } @calls), '--version');
};

done_testing();
