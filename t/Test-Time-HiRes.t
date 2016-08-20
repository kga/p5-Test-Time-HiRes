use strict;
use warnings;
use Test::More;

use Test::Time::HiRes time => 1.0;

use Time::HiRes qw(time sleep);

subtest 'set time via import' => sub {
    is time(), 1.0;

    CORE::sleep(1);
    is time(), 1.0;

    sleep 0.7;
    is time(), 1.7;
};

subtest 'set via global variable' => sub {
    local $Test::Time::HiRes::time = 2.3;
    is time(), 2.3;

    CORE::sleep(1);
    is time(), 2.3;

    sleep 1.8;
    is time(), 4.1;
};

done_testing;
