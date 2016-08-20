use strict;
use warnings;
use Test::More;

use Test::Time::HiRes;
use Test::Time::HiRes::At;

use Time::HiRes qw(time sleep);

subtest 'do_at with epoch' => sub {
    local $Test::Time::HiRes::time = 1.0;
    is time, 1.0, 'time is 1.0 now';

    do_at {
        is time, 100.0, 'time is 100.0 in this scope';
        sleep 10.3;
        is time, 110.3, 'time is 110.3 after sleep';
    } 100.0;

    is time, 1.0, 'time is 1.0 after do_at';
};

subtest 'sub_at' => sub {
    local $Test::Time::HiRes::time = 1.0;
    is time, 1.0, 'time is 1.0 now';

    subtest 'subtest wit sub_at' => sub_at {
        is time, 100.0, 'time is 100.0 in this subtest';
        sleep 10.7;
        is time, 110.7, 'time is 110.7 after sleep in this subtest';
    } 100.0;

    is time, 1.0, 'time is 1 after subtest';
};

done_testing;
