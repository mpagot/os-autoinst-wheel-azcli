package testapi;
use Exporter;
use Mojo::Base 'Exporter', -signatures;

# list names of test API functions our wheel is expected to call
our @EXPORT = qw(assert_script_run);

# define helpers for tracking invoked test API functions
my @INVOKED;
my %OVERRIDES;
sub invoked_functions () { \@INVOKED }
sub clear_invoked_functions () { @INVOKED = () }
sub function_overrides () { \%OVERRIDES }
sub _track_function_call ($function, @args) {
    push @INVOKED, [$function, @args];
    return 1 unless my $override = $OVERRIDES{$function};
    return $override->(@args);
}

# use AUTOLOAD to handle remaining test API functions
sub AUTOLOAD {
    my $function = our $AUTOLOAD;
    $function =~ s,.*::,,;

    no strict 'refs';
    *$AUTOLOAD = sub { _track_function_call($function, @_) };
    goto &$AUTOLOAD;
}

1;
