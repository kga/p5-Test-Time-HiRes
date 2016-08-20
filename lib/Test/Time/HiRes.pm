package Test::Time::HiRes;
use 5.008001;
use strict;
use warnings;

use Test::More;
use Time::HiRes;

our $VERSION = "0.01";

our $time = Time::HiRes::time;

my $in_effect = 1;

sub in_effect {
    $in_effect;
}

sub import {
    my ($class, %opts) = @_;
    $time = $opts{time} if defined $opts{time};

    no warnings 'redefine';
    *Time::HiRes::time = sub() {
        if (in_effect) {
            $time;
        } else {
            Time::HiRes::time;
        }
    };

    *Time::HiRes::sleep = sub(;@) {
        if (in_effect) {
            my $sleep = shift || 1;
            $time += $sleep;
            note "sleep $sleep";
        } else {
            Time::HiRes::sleep(shift);
        }
    }
};

sub unimport {
    $in_effect = 0;
}

1;
__END__

=encoding utf-8

=head1 NAME

Test::Time::HiRes - It's new $module

=head1 SYNOPSIS

    use Test::Time::HiRes;

=head1 DESCRIPTION

Test::Time::HiRes is ...

=head1 LICENSE

Copyright (C) Wataru TOYA.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Wataru TOYA E<lt>watrty@gmail.comE<gt>

=cut

