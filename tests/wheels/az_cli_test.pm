use Mojo::Base 'basetest';
use OpenQA::Wheel::AzCli 'az_version';

sub run {
    az_version();
};

1
