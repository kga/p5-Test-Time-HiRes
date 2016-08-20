use strict;
use warnings;
use Test::More;
use Test::Time::HiRes time => 1.0;

use Time::HiRes qw(time sleep);

is time(), 1.0;

CORE::sleep(1);
is time(), 1.0;

sleep 0.7;
is time(), 1.7;

done_testing;
