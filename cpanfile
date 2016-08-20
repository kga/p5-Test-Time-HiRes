requires 'perl', '5.008001';
requires 'Time::HiRes';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'DateTime';
};
