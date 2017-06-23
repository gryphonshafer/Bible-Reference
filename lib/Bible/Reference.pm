package Bible::Reference;
# ABSTRACT: Simple Bible reference parser, tester, and canonicalizer

use 5.012;
use strict;
use warnings;

use Moose;
use Moose::Util::TypeConstraints;
use MooseX::Privacy;

# VERSION

has 'acronyms', is => 'rw', isa => 'Bool', default => 0;
has 'sorting',  is => 'rw', isa => 'Bool', default => 1;

my @bible_types = qw( Protestant Catholic Orthodox Vulgate );

subtype 'BibleType',
    as 'Str',
    where {
        my $type = $_;
        grep { $type eq $_ } @bible_types;
    },
    message {'Could not determine a valid Bible type from input'};

coerce 'BibleType',
    from 'Str',
    via {
        my $input = lc( substr( $_ || '', 0, 1 ) );
        my ($type) = grep { lc( substr( $_, 0, 1 ) ) eq $input } @bible_types;
        return $type;
    };

has 'bible',
    is      => 'rw',
    isa     => 'BibleType',
    default => 'Protestant',
    coerce  => 1,
    trigger => sub { shift->_build_books };

has '_in',
    is      => 'rw',
    isa     => 'ArrayRef[Str]',
    traits  => ['Private'],
    default => sub { [] };

has '_books_protestant',
    is      => 'ro',
    isa     => 'ArrayRef[ArrayRef[Str]]',
    traits  => ['Private'],
    default => sub { [
        [ 'Genesis', 'Ge', 'Gen' ],
        [ 'Exodus', 'Ex', 'Exo' ],
        [ 'Leviticus', 'Le', 'Lev' ],
        [ 'Numbers', 'Nu', 'Num' ],
        [ 'Deuteronomy', 'De', 'Deut' ],
        [ 'Joshua', 'Jsh', 'Josh' ],
        [ 'Judges', 'Jdg', 'Judg' ],
        [ 'Ruth', 'Ru', 'Ruth' ],
        [ '1 Samuel', '1Sa', '1 Sam' ],
        [ '2 Samuel', '2Sa', '2 Sam' ],
        [ '1 Kings', '1Ki' ],
        [ '2 Kings', '2Ki' ],
        [ '1 Chronicles', '1Ch', '1 Chr' ],
        [ '2 Chronicles', '2Ch', '2 Chr' ],
        [ 'Ezra', 'Er', 'Ezra' ],
        [ 'Nehemiah', 'Ne', 'Neh' ],
        [ 'Esther', 'Es', 'Esth' ],
        [ 'Job', 'Jb', 'Job' ],
        [ 'Psalms', 'Ps' ],
        [ 'Proverbs', 'Prv', 'Prov' ],
        [ 'Ecclesiastes', 'Ec', 'Eccl' ],
        [ 'Song of Solomon', 'Sng', 'Song' ],
        [ 'Isaiah', 'Is', 'Isa' ],
        [ 'Jeremiah', 'Je', 'Jer' ],
        [ 'Lamentations', 'Lm', 'Lam' ],
        [ 'Ezekiel', 'Ek', 'Ezek' ],
        [ 'Daniel', 'Da', 'Dan' ],
        [ 'Hosea', 'Ho', 'Hos' ],
        [ 'Joel', 'Jl', 'Joel' ],
        [ 'Amos', 'Am', 'Amos' ],
        [ 'Obadiah', 'Ob', 'Oba' ],
        [ 'Jonah', 'Jnh', 'Jonah' ],
        [ 'Micah', 'Mi', 'Mic' ],
        [ 'Nahum', 'Na', 'Nah' ],
        [ 'Habakkuk', 'Hb', 'Hab' ],
        [ 'Zephaniah', 'Zph', 'Zeph' ],
        [ 'Haggai', 'Hg', 'Hag' ],
        [ 'Zechariah', 'Zch', 'Zech' ],
        [ 'Malachi', 'Ml', 'Mal' ],
        [ 'Matthew', 'Mt', 'Matt' ],
        [ 'Mark', 'Mk', 'Mark' ],
        [ 'Luke', 'Lk', 'Luke' ],
        [ 'John', 'Jhn', 'John' ],
        [ 'Acts', 'Ac', 'Acts' ],
        [ 'Romans', 'Ro', 'Rom' ],
        [ '1 Corinthians', '1Co', '1 Cor' ],
        [ '2 Corinthians', '2Co', '2 Cor' ],
        [ 'Galatians', 'Ga', 'Gal' ],
        [ 'Ephesians', 'Eph' ],
        [ 'Philippians', 'Php', 'Philip' ],
        [ 'Colossians', 'Co', 'Col' ],
        [ '1 Thessalonians', '1Th' ],
        [ '2 Thessalonians', '2Th' ],
        [ '1 Timothy', '1Tm', '1 Tim' ],
        [ '2 Timothy', '2Tm', '2 Tim' ],
        [ 'Titus', 'Ti', 'Titus' ],
        [ 'Philemon', 'Phm', 'Phile' ],
        [ 'Hebrews', 'He', 'Heb' ],
        [ 'James', 'Ja', 'Jam' ],
        [ '1 Peter', '1Pt', '1 Pet' ],
        [ '2 Peter', '2Pt', '2 Pet' ],
        [ '1 John', '1Jn' ],
        [ '2 John', '2Jn' ],
        [ '3 John', '3Jn' ],
        [ 'Jude', 'Jud', 'Jude' ],
        [ 'Revelation', 'Rv', 'Rev' ],
    ] };

has '_books',
    is      => 'rw',
    isa     => 'ArrayRef[ArrayRef[Str]]';
#    traits  => ['Private'];

sub BUILD {
    shift->_build_books;
}

private_method _build_books => sub {
    my ($self) = @_;

    $self->_books([]);
    my $bible = $self->bible;

    for my $book ( @{ $self->_books_protestant } ) {
        my @book = @$book;

        if ( $bible ne 'Protestant' ) {
            if ( $book[0] eq 'Joshua' ) {
                if ( $bible eq 'Catholic' or $bible eq 'Vulgate' ) {
                    push( @book, 'Josue', 'Jou' );
                }
                elsif ( $bible eq 'Orthodox' ) {
                    push( @book, 'Iesous', 'Ie' );
                }
            }
            elsif ( $book[0] =~ /([12]) Samuel/ ) {
                if ( $bible eq 'Catholic' or $bible eq 'Vulgate' ) {
                    push( @book, $1 . ' Kings', $1 . 'Ki' );
                }
                elsif ( $bible eq 'Orthodox' ) {
                    push( @book, $1 . ' Kingdoms', $1 . 'Ki' );
                }
            }
            elsif ( $book[0] =~ /([12]) Kings/ ) {
                if ( $bible eq 'Catholic' or $bible eq 'Vulgate' ) {
                    push( @book, ( $1 + 2 ) . ' Kings', ( $1 + 2 ) . 'Ki' );
                }
                elsif ( $bible eq 'Orthodox' ) {
                    push( @book, ( $1 + 2 ) . ' Kingdoms', ( $1 + 2 ). 'Ki' );
                }
            }
            elsif ( $book[0] =~ /([12]) Chronicles/ ) {
                push( @book, $1 . ' Paralipomenon', $1 . ' Par' );
            }
            elsif ( $book[0] eq 'Ezra' ) {
                push( @book, '1 Esdras', '1 Es' );
            }
            elsif ( $book[0] eq 'Nehemiah' ) {
                push( @book, '2 Esdras', '2 Es' );
            }
            elsif ( $book[0] eq 'Esther' ) {
                if ( $bible eq 'Vulgate' ) {
                    push( @{ $self->_books },
                        [ '3 Esdras', '3 Es' ],
                        [ '4 Esdras', '4 Es' ],
                    );
                }
                if ( $bible eq 'Catholic' or $bible eq 'Vulgate' ) {
                    push( @{ $self->_books },
                        [ 'Tobit', 'To', 'Tobias' ],
                        [ 'Judith', 'Ju' ],
                    );
                }
            }
            elsif ( $book[0] eq 'Job' ) {
                push( @{ $self->_books },
                    [ '1 Maccabees', '1 Mac', '1 Machabees' ],
                    [ '2 Maccabees', '2 Mac', '2 Machabees' ],
                );
                if ( $bible eq 'Orthodox' ) {
                    push( @{ $self->_books },
                        [ '3 Maccabees', '3 Mac', '3 Machabees' ],
                        [ '4 Maccabees', '4 Mac', '4 Machabees' ],
                    );
                }
            }
            elsif ( $book[0] eq 'Proverbs' and ( $bible eq 'Vulgate' or $bible eq 'Orthodox' ) ) {
                push( @{ $self->_books }, [ 'Prayer of Manasseh', 'Pra' ] );
            }
            elsif ( $book[0] eq 'Song of Solomon' ) {
                if ( $bible eq 'Vulgate' or $bible eq 'Catholic' ) {
                    unshift( @book, 'Song of Songs', 'Sng', 'Canticle of Canticles' );
                }
                elsif ( $bible eq 'Orthodox' ) {
                    unshift( @book, 'Song of Songs', 'Sng', 'Aisma Aismaton' );
                }
            }















        }

        push( @{ $self->_books }, \@book );
    }
};














sub in {
    my $self = shift;
    return $self->_in unless (@_);
    push( @{ $self->_in }, @_ );
    return $self;
}

sub clear {
    my $self = shift;
    $self->_in([]);
    return $self;
}












1;
__END__

=pod

=begin :badges

=for markdown
[![Build Status](https://travis-ci.org/gryphonshafer/Bible-Reference.svg)](https://travis-ci.org/gryphonshafer/Bible-Reference)
[![Coverage Status](https://coveralls.io/repos/gryphonshafer/Bible-Reference/badge.png)](https://coveralls.io/r/gryphonshafer/Bible-Reference)

=end :badges

=head1 SYNOPSIS

    use Bible::Reference;

    my $r = Bible::Reference->new;
    $r = Bible::Reference->new(
        bible    => 'Protestant', # or "Orthodox" or "Catholic" or "Vulgate"
        acronyms => 0,            # or 1
        sorting  => 1,            # or 0 to preserve input order
    );

    $r = $r->in('Text with I Pet 3:16 and Rom 12:13-14,17 references in it.');

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

=head1 DESCRIPTION

This module is intended to address Bible reference canonicalization. Given some
input, the module will search for Bible references, canonicalize them, and
return them in various forms desired. It can return the canonicalized within
the context of the input string or strings as well.

The module supports the Protestant Bible by default and by configuration
setting also the Orthodox Bible, the current Catholic Bible, and the Vulgate.

There are also some potentially useful helper methods.

=head1 METHODS

=head2 new

A typical instantiation method that accepts some settings, all of which can
later be fetched and changed with accessors.

    my $r = Bible::Reference->new(
        bible    => 'Protestant', # or "Orthodox" or "Catholic" or "Vulgate"
        acronyms => 0,            # or 1
        sorting  => 1,            # or 0 to preserve input order
    );

See the below accessor methods for details on these settings.

=head2 bible

This accessor method gets and sets the current Bible to use. By default, the
Bible is the Protestant Bible (since this is most common). Other Bibles
supported are the Orthodox, current Catholic, and Vulgate Bibles.

You can set the value to any substring of the name.

    $r->bible('c'); # sets Bible to "Catholic"

=head2 acronyms

This accessor method gets and sets the boolean setting of whether to return
full book names (which is the default) or acronyms.

    $r->acronyms(0);         # default
    $r->in('Rom 1:1')->refs; # returns "Romans 1:1"

    $r->acronyms(1);
    $r->in('Rom 1:1')->refs; # returns "Ro 1:1"

=head2 sorting

This accessor method gets and sets the boolean setting of whether or not to
return references sorted (which is the default) or in their input order.

    $r->sorted(1);                    # default
    $r->in('Jam 1:1; Rom 1:1')->refs; # returns "Romans 1:1; James 1:1"

    $r->sorted(0);
    $r->in('Jam 1:1; Rom 1:1')->refs; # returns "James 1:1; Romans 1:1"

=head2 in

This method accepts string input that will get parsed and canonicalized by the
module. The method returns a reference to the object.

    $r = $r->in('Text with I Pet 3:16 and Rom 12:13-14,17 references in it.');

The method is also additive, in that if you call it multiple times or with a
list of input strings, the object stores them all (until you call C<clear>).

    $r->in('Text with I Pet 3:16 and Rom 12:13-14,17 references in it.');
    $r->in('More text with Roms 12:16, 13:14-15 in it.');
    $r->in(
        'Even more text with Jam 1:5 in it.',
        'And one last bit of text with 1 Cor 12:8-12 in it.',
    );

=head2 clear

This method clears all input provided via C<in> and returns a reference to the
object.

    $r = $r->clear; # clears "in" data but not anything else

=head2 refs

This method returns all references found within the input. It does so as a
single string using canonical reference format.

    my $refs = $r->refs;
    # 'Romans 12:13-14, 17; 1 Peter 3:16'

The "canonical reference format" is as follows: Book names are proper-noun cased
followed by a single space. If the book name has a number prefix, it is in
numeric form followed by a single space. Chapter numbers are next, followed by a
":" and verses. For uninterrupted ranges of verses, the "-" character is used.
Interrupted verses (i.e. "14, 17") are displayed with a comma and space between
them.

Multiple book references are separated by a ";" and space. Multiple chapters
within the same book are separated by a space and comma: "Romans 12:14, 17:18; 1
Peter 3:16" Therefore, whole chapters that follow chapters with verses will
repeat of the book name (for disambiguation). Whole chapters that only follow
whole chapters will not repeat the book name.

=head2 as_books

This method is the same as C<refs> except that it returns a list or arrayref
(depending on context) of canonicalized references by book.

    my $books = $r->as_books;
    # [ 'Romans 12:13-14, 17', '1 Peter 3:16' ]

    my @books = $r->as_books;
    # 'Romans 12:13-14, 17', '1 Peter 3:16'

=head2 as_verses

This method is the same as C<as_books> except that it returns a list or arrayref
of independent verses,

    my $verses = $r->as_verses;
    # [ 'Romans 12:13', 'Romans 12:14', 'Romans 12:17', '1 Peter 3:16' ]

    my @verses = $r->as_verses;
    # 'Romans 12:13', 'Romans 12:14', 'Romans 12:17', '1 Peter 3:16'

=head2 as_hash

This method returns the references output like C<refs> would except that the
output is a hash or hashref (depending on context) of a tree of data.

    my $hash = $r->as_hash;
    # { 'Romans' => { 12 => [ 13, 14, 17 ] }, '1 Peter' => { 3 => [16] } }

    my %hash = $r->as_hash;
    # 'Romans' => { 12 => [ 13, 14, 17 ] }, '1 Peter' => { 3 => [16] }

=head2 as_array

This method is the same as C<as_hash> except that the output is an array or
arrayref (depending on context) of a tree of data.

    my $array = $r->as_array;
    # [[ 'Romans', [[ 12, [ 13, 14, 17 ]]]], [ '1 Peter', [[ 3, [16] ]]]]

    my @array = $r->as_array;
    # [ 'Romans', [[ 12, [ 13, 14, 17 ]]]], [ '1 Peter', [[ 3, [16] ]]]

=head2 as_text

This method returns a text string or, if there were multiple calls to C<in>, an
array or arrayref of text strings (depending on context), of the input string or
strings with the references found therein canonicalized.

    my $text = $r->as_text;
    # 'Text with 1 Peter 3:16 and Romans 12:13-14, 17 references in it.'

    $r->clear;
    $r->in('Text with I Pet 3:16 and Rom 12:13-14,17 references in it.');
    $r->in('More text with Roms 12:16, 13:14-15 in it.');
    $r->in(
        'Even more text with Jam 1:5 in it.',
        'And one last bit of text with 1 Cor 12:8-12 in it.',
    );

    my @text = $r->as_text;
    # 'Text with 1 Peter 3:16 and Romans 12:13-14, 17 references in it.',
    # 'More text with Romans 12:16, 13:14-15 in it.',
    # 'Even more text with James 1:5 in it.',
    # 'And one last bit of text with 1 Corinthians 12:8-12 in it.',

=head2 books

This method returns a list or arrayref (depending on the context) of books of
the Bible, in order.

    my @books = $r->books;
    my $books = $r->books;

=head2 sort

Accepts a list of canonicalized Bible references and returns a sorted list of
them based on Bible order. Returns an array or arrayref depending on context.

    my @sorted = $r->sort( 'Romans', 'James 1:5', 'Romans 5' );
    my $sorted = $r->sort( 'Romans', 'James 1:5', 'Romans 5' );

=head2 by_bible_order

Returns a sort algorithm usable in a native Perl C<sort> call.

    my @also_sorted = sort $r->by_bible_order 'Romans', 'James 1:5', 'Romans 5';

=head1 SEE ALSO

You can look for additional information at:

=for :list
* L<GitHub|https://github.com/gryphonshafer/Bible-Reference>
* L<CPAN|http://search.cpan.org/dist/Bible-Reference>
* L<MetaCPAN|https://metacpan.org/pod/Bible::Reference>
* L<AnnoCPAN|http://annocpan.org/dist/Bible-Reference>
* L<Travis CI|https://travis-ci.org/gryphonshafer/Bible-Reference>
* L<Coveralls|https://coveralls.io/r/gryphonshafer/Bible-Reference>
* L<CPANTS|http://cpants.cpanauthors.org/dist/Bible-Reference>
* L<CPAN Testers|http://www.cpantesters.org/distro/B/Bible-Reference.html>

=cut
