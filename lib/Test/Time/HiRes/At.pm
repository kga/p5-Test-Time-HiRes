package Test::Time::HiRes::At;
use 5.008001;
use strict;
use warnings;

use Test::Time::HiRes;
use Scalar::Util qw(blessed);

use Exporter qw(import);
our @EXPORT = qw(do_at sub_at);

our $VERSION = "0.01";

sub do_at (&$) {
    my ($code, $time) = @_;
    my $epoch = (blessed $time && $time->can('hires_epoch')) ? $time->hires_epoch : $time + 0;
    local $Test::Time::HiRes::time = $epoch;
    $code->();
}

sub sub_at (&$) {
    my ($code, $time) = @_;
    return sub { do_at(\&$code, $time) };
}

1;
__END__

=encoding utf-8

=head1 NAME

Test::Time::HiRes::At - It's new $module

=head1 SYNOPSIS

    use Test::Time::HiRes::At;

=head1 DESCRIPTION

Test::Time::HiRes::At is ...

=head1 LICENSE

Copyright (C) Wataru TOYA.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Wataru TOYA E<lt>watrty@gmail.comE<gt>

=cut

