package Test::Bible::Reference;
use strict;
use warnings;
use parent 'Test::Class';
use Test::Most;
use Test::Moose;

use constant TEST_PACKAGE_NAME => 'Bible::Reference';

sub instantiation : Test( startup => 4 ) {
    use_ok TEST_PACKAGE_NAME;
    require_ok TEST_PACKAGE_NAME;
    my $obj;
    lives_ok( sub { $obj = TEST_PACKAGE_NAME->new }, 'new' );
    isa_ok( $obj, TEST_PACKAGE_NAME );
    shift->{obj} = $obj;
}

sub attributes_and_classes : Test(4) {
    my $obj = shift->{obj};
    has_attribute_ok( $obj, $_, qq{attribute "$_" exists} ) for ( qw( acronyms sorting bible ) );
    can_ok( $obj, $_ ) for ( qw( _in in ) );
    throws_ok( sub { $obj->_in }, qr/Attribute _in is private/, '_in() is private' );
}

sub bible_type : Test(6) {
    my $obj = shift->{obj};

    is( $obj->bible, 'Protestant', 'default bible() set ok');
    is( $obj->bible('c'), 'Catholic', 'can set "Catholic" with bible("c")' );
    is( $obj->bible, 'Catholic', 'bible type set to "Catholic"');
    is( $obj->bible('ogh'), 'Orthodox', 'can set "Orthodox" with bible("ogh")' );
    is( $obj->bible, 'Orthodox', 'bible type set to "Orthodox"');

    throws_ok(
        sub { $obj->bible('barf') },
        qr/Attribute \(bible\) does not pass the type constraint/,
        'fails to set bible("barf")',
    );
}

sub in_and_clear : Tests {
    my $obj = shift->{obj};

    is_deeply( $obj->in, [], 'in() is empty' );

    lives_ok(
        sub { $obj->in('Text with I Pet 3:16 and Rom 12:13-14,17 references in it.') },
        'in("text") lives',
    );

    is_deeply( $obj->in, [
        'Text with I Pet 3:16 and Rom 12:13-14,17 references in it.',
    ], 'in() is set correctly' );

    lives_ok(
        sub { $obj->in('Moobje text with Roms 12:16, 13:14-15 in it.') },
        'in("text 2") lives',
    );

    is_deeply( $obj->in, [
        'Text with I Pet 3:16 and Rom 12:13-14,17 references in it.',
        'Moobje text with Roms 12:16, 13:14-15 in it.',
    ], 'in() is set correctly' );

    lives_ok(
        sub {
            $obj->in(
                'Even more text with Jam 1:5 in it.',
                'And one last bit of text with 1 Cor 12:8-12 in it.',
            );
        },
        'in( "text 3", "text 4" ) lives',
    );

    is_deeply( $obj->in, [
        'Text with I Pet 3:16 and Rom 12:13-14,17 references in it.',
        'Moobje text with Roms 12:16, 13:14-15 in it.',
        'Even more text with Jam 1:5 in it.',
        'And one last bit of text with 1 Cor 12:8-12 in it.',
    ], 'in() is set correctly' );

    lives_ok(
        sub { $obj->clear },
        'clear lives',
    );

    is_deeply( $obj->in, [], 'in() is empty' );
}











1;
