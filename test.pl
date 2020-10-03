#!/usr/bin/env perl
use exact;
use lib 'lib';
use Bible::Reference;
use DDP;

my $r = Bible::Reference->new;

$r->in(
    'Romans 12:13-14, 17; 1 Peter 3:16'
    # 'E = Luke 1-3:23, 4:16-5, 6:13-7:2',

    # 'The verses Mark 12:4 and Mark 12:3-5 and Mark 12:4-7, 13:1-2 and Genesis 4:1 and Genesis 1:2 are good.',
    # 'The verses Mark 12:4 and Mark 12:4 and Mark 12:4 are good.',
    # 'In the books Revel, Gal, and Roma are found verses.',
    # 'And John 3:16-19,',
    # '25-31; 4-7 is a reference.',
    # 'The verse James 2:1 is good.',

    # 'A = Matthew 1:18-25, 2-12, 14-22, 28-26 = A',
    # 'B = Romans, James = B',
    # 'C = Acts 1-20 = C',
    # 'D = Galatians, Ephesians, Philippians, Colossians = D',
    # 'E = Luke 1-3:23, 9-11, 13-19, 21-24 = E',
    # 'F = 1 Corinthians, 2 Corinthians = F',
    # 'G = John = G',
    # 'H = Hebrews, 1 Peter, 2 Peter = H',

    # 'X = Matthew 1:18-25, 2-12',
    # 'Y = Matthew 1:1-5, 8-12',

    # 'Acts 1:3-4, 8, and 13', # verses
    # 'Acts 1:3-4, 8, 13',     # ambiguous (but go with chapter?)
    # 'Acts 1-3, 8, 13',       # chapters
    # 'Acts 1-3, 8, and 13',   # chapters

    # 'Acts 9:14, 9:14, 1:3-4, 8, 13; 2:18-20',
    # 'This is a reference of Acts 1:3-4, 8, 13; 2:18-20 for stuff.'

    # 'This is content and Acts 1:3-4, & 8, and 13, or 14 and or with other things', # verses
);

# say join( "\n", $r->as_books );
# say '-' x 40;
# say join( "\n", $r->as_text );

# p $r->_data;
my $x = $r->as_verses;
p $x;

# my $y = [[ 'Romans', [[ 12, [ 13, 14, 17 ]]]], [ '1 Peter', [[ 3, [16] ]]]];
# my $y = { 'Romans' => { 12 => [ 13, 14, 17 ] }, '1 Peter' => { 3 => [16] } };
# p $y;
