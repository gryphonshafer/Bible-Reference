#!/usr/bin/env perl
use strict;
use warnings;
use 5.012;
use DDP;
use lib 'lib';
use Bible::Reference;

my $r = Bible::Reference->new;
$r->bible( $ARGV[0] ) if $ARGV[0];

for ( @{ $r->_books } ) {
    print join( ' | ', map { $_ . ' ' x ( 16 - length($_) ) } @$_ ), "\n";
}









__END__

my @books = $r->books;

my @sorted      = $r->sort( 'Romans', 'James 1:5', 'Romans 5' );
my @also_sorted = sort $r->by_bible_order 'Romans', 'James 1:5', 'Romans 5';

__END__

$r = $r->in('Text with I Pet 3:16 and Rom 12:13-14,17 references in it.');

$r = $r->in('More text with Romans 12:16, 13:14-15 in it.'); # appends "in"
$r = $r->clear; # clears "in" data but not anything else

__END__

my $hash = $r->as_hash;
# { 'Romans' => { 12 => [ 13, 14, 17 ] }, '1 Peter' => { 3 => [16] } }

my $array = $r->as_array;
# [[ 'Romans', [[ 12, [ 13, 14, 17 ]]]], [ '1 Peter', [[ 3, [16] ]]]]

my $verses = $r->as_verses;
# [ 'Romans 12:13', 'Romans 12:14', 'Romans 12:17', '1 Peter 3:16' ]

my $books = $r->as_books;
# [ 'Romans 12:13-14, 17', '1 Peter 3:16' ]

my $refs = $r->refs;
# 'Romans 12:13-14, 17; 1 Peter 3:16'

my $text = $r->as_text;
# 'Text with 1 Peter 3:16 and Romans 12:13-14, 17 references in it.'

__END__

my $sets = {
    book => [
        [ '', 1, 3, '1 ', '3 ', 'I ', 'III ' ],
        [ 'John', 'Jn', 'Jn.' ],
    ],
    chapter => [
        [ '', ' c', ' c.', ' ch', ' Ch.', ' chapter' ],
        [ '', ' ' ],
        [ qw( 7 12 )],
    ],
    verse => [
        [ ':', 'v', 'v.', 'vs.', 'Vs', 'verse' ],
        [ qw( 7 12 )],
    ],
    range => [
        [ '-', ',', ', ', ';' ],
        [ qw( 14 21 )],
    ],
};

sub patterns {
    my $parts = [ map { @{ $sets->{$_} } } @_ ];
    my ( $work, $patterns );
    $work = sub {
        my $level = shift // 0;
        if ( $parts->[$level] ) {
            for my $x ( @{ $parts->[$level] } ) {
                if ( ref $x ) {
                    for my $y (@$x) {
                        $work->( $level + 1, @_, $y );
                    }
                }
                else {
                    $work->( $level + 1, @_, $x );
                }
            }
        }
        else {
            ( my $pattern = join( '', @_ ) ) =~ s/\s{2,}/ /g;
            $patterns->{$pattern} = 1;
        }
    };

    $work->();
    return sort keys %$patterns;
}

my @bcv  = patterns( qw( book chapter verse ) );
my @bcvr = patterns( qw( book chapter verse range ) );

my $patterns = [
    # patterns( qw( book ) ),
    # patterns( qw( book chapter ) ),
    # @bcv,
    # @bcvr,
    ( map { "content $_ content" } @bcvr ),
    # ( map { "content $_; $_ content" } @bcvr ),
];

my $r = Bible::OBML::Reference->new;

for (@$patterns) {
    print $_, "\n";
    my $rv = $r->parse($_);
    # p $rv;
    <STDIN>;
}
