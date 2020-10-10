#!/usr/bin/env perl
use exact;
use lib 'lib';
use Bible::Reference;
use DDP;
use YAML::XS 'Dump';

my $r = Bible::Reference->new;

$r->in(
    undef,
    0,
    '',
    'Text with no Reference 3:16 data included',
    'Text Samuel 3:15 said in 1 Samuel 4:16 that 2 Samuel 3-5 was as clear as 1 Peter in full',
    'Text Pet text II Pet text II Pet 3:15 text 2pt 3-4 text 2 Peter 3:15-17, 18, 20-22, 2 Peter 5:1 text',
    'The book of rev. The verse of rEv. 3:15. The book of Rev.',
    'Books of Revel, Gal, and Roma exist',
    'Verses Mark 12:4 and Mark 12:3-5 and Mark 12:4-7, 13:1-2 and Genesis 4:1 and Genesis 1:2 exist',
    'Mark 3:15-17, Ps 117, 3 John, Mark 3:6, 20-23, Mark 4-5',
    'A = Matthew 1:18-25, 2-12, 14-22, 28-26 = A',
    'B = Romans, James = B',
    'C = Acts 1-20 = C',
    'D = Galatians, Ephesians, Philippians, Colossians = D',
    'E = Luke 1-3:23, 9-11, 13-19, 21-24 = E',
    'F = 1 Corinthians, 2 Corinthians = F',
    'G = John = G',
    'H = Hebrews, 1 Peter, 2 Peter = H',
);

use Data::Dumper;
my $x = $r->as_text;
say Dumper $x;
say $r->as_text;

# p $r->_data;

# p $r->as_array;
# p $r->as_hash;
# p $r->as_verses;
# p $r->as_runs;
# p $r->as_chapters;
# p $r->as_books;

# p $r->refs;

# say $r->as_text;

__END__

## TODO

- refactor subs
- POD coverage
