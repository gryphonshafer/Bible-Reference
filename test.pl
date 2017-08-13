#!/usr/bin/env perl
use strict;
use warnings;
use 5.012;
use DDP;
use lib 'lib';
use Bible::Reference;

my $r = Bible::Reference->new;

my $in = [
    # 'Text that includes Romans 2 and other words',
    'Text with I Pet 3:16 and Rom 12:13-14,17 references in it.',
    # 'Some text from Rom 4:15,16-19,21 and also 1 Corin 5:16, 6:17-19 and such',
    # 'Rom 2:2-14, 15; Mk 5, John 3:16',
    # 'Lk 3:15-17, 18; 4:5-10',
    'Acts 20:29, 32, 35, 1 Tim 4:1, 2 Tim 4:3, 2 Pete 3:3',
    # 'Ac 20:29; 1Tm 4:1; 2Tm 4:3; 2Pt 3:3',
    # 'Romans 1:15',
    # '',
    # 'Nothing to see 42',
    # '1 Corinthians 5:15-17, 19',
    # 'Romans 4:35, 5:46, 48',
    # 'Mk 5, Rom 2:2-14, 15; John 3:16',
    # 'Mk 5, John 3:16, Rom 2:2-14, 15',
];

$r->in(@$in);
my $out = $r->in;

exit;

while ( @$in or @$out ) {
    say '"', shift @$in, '"';
    my $x = shift @$out;
    p $x;
    print "\n";
}

=pod

    my $refs = $r->refs;
    # 'Romans 12:13-14, 17; 1 Peter 3:16'

    my $books = $r->as_books;
    # [ 'Romans 12:13-14, 17', '1 Peter 3:16' ]

    my $verses = $r->as_verses;
    # [ 'Romans 12:13', 'Romans 12:14', 'Romans 12:17', '1 Peter 3:16' ]

    my $hash = $r->as_hash;
    # { 'Romans' => { 12 => [ 13, 14, 17 ] }, '1 Peter' => { 3 => [16] } }

    my $array = $r->as_array;
    # [[ 'Romans', [[ 12, [ 13, 14, 17 ]]]], [ '1 Peter', [[ 3, [16] ]]]]

    my $text = $r->as_text;
    # 'Text with 1 Peter 3:16 and Romans 12:13-14, 17 references in it.'

    $r = $r->in('More text with Romans 12:16, 13:14-15 in it.'); # appends "in"
    $r = $r->clear; # clears "in" data but not anything else

    my @books = $r->books;

    my @sorted      = $r->sort( 'Romans', 'James 1:5', 'Romans 5' );
    my @also_sorted = sort $r->by_bible_order 'Romans', 'James 1:5', 'Romans 5';

    $r->bible('Vulgate');
    $r->acronyms(1);
    $r->sorting(0);

=cut

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
