# NAME

Bible::Reference - Simple Bible reference parser, tester, and canonicalizer

# VERSION

version 1.16

[![test](https://github.com/gryphonshafer/Bible-Reference/workflows/test/badge.svg)](https://github.com/gryphonshafer/Bible-Reference/actions?query=workflow%3Atest)
[![codecov](https://codecov.io/gh/gryphonshafer/Bible-Reference/graph/badge.svg)](https://codecov.io/gh/gryphonshafer/Bible-Reference)

# SYNOPSIS

    use Bible::Reference;

    my $r = Bible::Reference->new;

    $r = Bible::Reference->new(
        bible                 => 'Protestant', # or "Orthodox" or "Catholic"
        acronyms              => 0,            # return full book names
        sorting               => 1,            # sort by reference
        require_chapter_match => 0,            # don't require chapters in references for matching
        require_verse_match   => 0,            # don't require verses in references for matching
        require_book_ucfirst  => 0,            # don't require book names to be ucfirst for matching
        minimum_book_length   => 3,
        add_detail            => 0,
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

    my @books  = $r->books;
    my @sorted = $r->sort( 'Romans', 'James 1:5', 'Romans 5' );

    $r->bible('Orthodox');        # switch to the Orthodox Bible
    $r->acronyms(1);              # output acronyms instead of full book names
    $r->sorting(0);               # deactivate sorting of references
    $r->require_chapter_match(1); # require chapters in references for matching
    $r->require_verse_match(1);   # require verses in references for matching
    $r->require_book_ucfirst(1);  # require book names to be ucfirst for matching
    $r->minimum_book_length(4);   # set minimum book length to 4
    $r->add_detail(1);            # turn on adding chapter and verse detail

# DESCRIPTION

This module is intended to address Bible reference canonicalization. Given some
input, the module will search for Bible references, canonicalize them, and
return them in various forms desired. It can return the canonicalized within
the context of the input string or strings as well.

The module supports the Protestant Bible by default and by configuration
setting also the Orthodox Bible and the current Catholic Bible.

There are also some potentially useful helper methods.

# METHODS

## new

A typical instantiation method that accepts some settings, all of which can
later be fetched and changed with accessors.

    my $r = Bible::Reference->new(
        bible    => 'Protestant', # or "Orthodox" or "Catholic"
        acronyms => 0,            # or 1
        sorting  => 1,            # or 0 to preserve input order
    );

See the below accessor methods for details on these settings.

## bible

This accessor method gets and sets the current Bible to use. By default, the
Bible is the Protestant Bible. Other Bibles supported are the Orthodox and
Catholic Bibles.

You can set the value via a case-insensitive setting.

    $r->bible('catholic'); # sets Bible to "Catholic"

## acronyms

This accessor method gets and sets the boolean setting of whether to return
full book names (which is the default) or acronyms.

    $r->acronyms(0);         # default
    $r->in('Rom 1:1')->refs; # returns "Romans 1:1"

    $r->acronyms(1);
    $r->in('Rom 1:1')->refs; # returns "Ro 1:1"

## sorting

This accessor method gets and sets the boolean setting of whether or not to
return references sorted (which is the default) or in their input order.

    $r->sorting(1);                   # default
    $r->in('Jam 1:1; Rom 1:1')->refs; # returns "Romans 1:1; James 1:1"

    $r->sorting(0);
    $r->in('Jam 1:1; Rom 1:1')->refs; # returns "James 1:1; Romans 1:1"

Note that within a single given reference, chapters and verses will always be
returned sorted and canonicalized.

## in

This method accepts string input that will get parsed and canonicalized by the
module. The method returns a reference to the object.

    $r = $r->in('Text with I Pet 3:16 and Rom 12:13-14,17 references in it.');

The method is also additive, in that if you call it multiple times or with a
list of input strings, the object stores them all (until you call `clear`).

    $r->in('Text with I Pet 3:16 and Rom 12:13-14,17 references in it.');
    $r->in('More text with Roms 12:16, 13:14-15 in it.');
    $r->in(
        'Even more text with Jam 1:5 in it.',
        'And one last bit of text with 1 Cor 12:8-12 in it.',
    );

## clear

This method clears all input provided via `in` and returns a reference to the
object.

    $r = $r->clear; # clears "in" data but not anything else

## refs

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

## as\_books

This method is the same as `refs` except that it returns a list or arrayref
(depending on context) of canonicalized references by book.

    my $books = $r->as_books;
    # [ 'Romans 12:13-14, 17', '1 Peter 3:16' ]

    my @books = $r->as_books;
    # 'Romans 12:13-14, 17', '1 Peter 3:16'

## as\_chapters

This method is the same as `as_books` except that it returns a list or arrayref
(depending on context) of canonicalized references by book and chapter.

## as\_runs

This method is the same as `as_chapters` except that it returns a list or
arrayref (depending on context) of canonicalized references by verse run. A
"verse run" is a set of verses in an unbroken list together.

    my $books = $r->as_runs;
    # [ 'Romans 12:13-14', 'Romans 12:17', '1 Peter 3:16' ]

## as\_verses

This method is the same as `as_books` except that it returns a list or arrayref
of independent verses,

    my $verses = $r->as_verses;
    # [ 'Romans 12:13', 'Romans 12:14', 'Romans 12:17', '1 Peter 3:16' ]

    my @verses = $r->as_verses;
    # 'Romans 12:13', 'Romans 12:14', 'Romans 12:17', '1 Peter 3:16'

## as\_hash

This method returns the references output like `refs` would except that the
output is a hash or hashref (depending on context) of a tree of data.

    my $hash = $r->as_hash;
    # { 'Romans' => { 12 => [ 13, 14, 17 ] }, '1 Peter' => { 3 => [16] } }

    my %hash = $r->as_hash;
    # 'Romans' => { 12 => [ 13, 14, 17 ] }, '1 Peter' => { 3 => [16] }

## as\_array

This method is the same as `as_hash` except that the output is an array or
arrayref (depending on context) of a tree of data.

    my $array = $r->as_array;
    # [[ 'Romans', [[ 12, [ 13, 14, 17 ]]]], [ '1 Peter', [[ 3, [16] ]]]]

    my @array = $r->as_array;
    # [ 'Romans', [[ 12, [ 13, 14, 17 ]]]], [ '1 Peter', [[ 3, [16] ]]]

## as\_text

This method returns a text string or, if there were multiple calls to `in`, an
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

## books

This method returns a list or arrayref (depending on the context) of books of
the Bible, in order.

    my @books = $r->books;
    my $books = $r->books;

## set\_bible\_data

If the preset Bibles are not going to cover your own needs, you can set your own
Bible data for use within the module with this method. It returns the
instantiated object, so you can chain it like so:

    my $r = Bible::Reference->new->set_bible_data(
        'Special' => [
            [ 'Genesis',     'Ge', 'Gn', 'Gen' ],
            [ 'Exodus',      'Ex', 'Exo'       ],
            [ 'Leviticus',   'Lv', 'Lev'       ],
            [ 'Numbers',     'Nu', 'Nm', 'Num' ],
            [ 'Deuteronomy', 'Dt', 'Deu'       ],
        ],
    );

The method expects two inputs: a string that will be used as the label for the
Bible and an arrayref of arrayrefs. Each sub-arrayref must contain at least 2
strings: the first being the full-name of the book, and the second the
canonical acronym. Subsequent matching acronyms can optionally be added. These
are acronyms that if found will match to the book, in addition to the canoniocal
acronym.

When you call this method with good input, it will save the new Bible and
internally call `bible()` to set the new Bible as active.

You may optionally provide an additional arrayref of arrayrefs containing the
maximum verse number for each chapter of a book. This is useful only if you
need to call `expand_ranges`. If you don't pass this data, a best-guess of the
data will be used.

## expand\_ranges

This is a helper method. It's called automatically if `add_detail` is set to a
true value. The method requires 2 strings: a book name and a chapter/verse
ranges string. It will return a string represented the "expanded" chapter/verse
range.

    $r->expand_ranges( 'Mark', '1:3-7' );
    # returns "1:3, 4, 5, 6, 7"

    $r->expand_ranges( 'Mark', '4:37-5:9' );
    # returns "4:37, 38, 39, 40, 41; 5:1, 2, 3, 4, 5, 6, 7, 8, 9"

## get\_bible\_structure

This method will return an arrayref containing an arrayref per book (in order)
that contains two elements: the name of the book and an arrayref of the maximum
verse number per chapter.

## identify\_bible

This method is to help identify which Bible to use if you aren't sure. It
requires a list of strings as input, each string representing a book from the
Bible you're trying to identify. This method will then try to match these book
names across all Bibles and will return an array of the most likely Bibles for
your inputs.

For example:

    my $bibles = $r->identify_bible( 'Gen', 'Lev', '3 Mac' );

The above will return:

    [
        {
            name  => 'Orthodox',
            count => 3,
            books => [ 'Genesis', 'Leviticus', '3 Maccabees' ],
        },
    ],

# HANDLING MATCHING ERRORS

By default, the module does its best to find things that look like valid
references inside text. However, this can result in the occational matching
error. For example, consider the following text input:

    This is an example of the 1 time it might break.
    It also breaks if you mention number 7 from a list of things.
    Legal opinions of judges 3 times said this would break.

With this, we'd falsely match: Thessalonians 1, Numbers 7, and Judges 3.

There are a few things you can do to reduce this problem. You can optionally set
`require_chapter_match` or `require_verse_match` to true values. These will
cause the matching algorithm to only work on reference patterns that contain
what look to be chapter numbers and/or verse numbers.

You can optionally set `require_book_ucfirst` to a true value. This will cause
the matching algorithm to only work on reference patterns that contain what
looks like a book that starts with a capital letter (instead of the default of
any case).

Another option to consider is adjusting the `minimum_book_length` value. It
sets the minimum length of characters to match a book name. It's default set to
3\. Given a book like "Genesis", this will mean "Gen" and "Gene" and "Genes"
matches, but "Ge" won't.

# SEE ALSO

You can look for additional information at:

- [GitHub](https://github.com/gryphonshafer/Bible-Reference)
- [MetaCPAN](https://metacpan.org/pod/Bible::Reference)
- [GitHub Actions](https://github.com/gryphonshafer/Bible-Reference/actions)
- [Codecov](https://codecov.io/gh/gryphonshafer/Bible-Reference)
- [CPANTS](http://cpants.cpanauthors.org/dist/Bible-Reference)
- [CPAN Testers](http://www.cpantesters.org/distro/B/Bible-Reference.html)

# AUTHOR

Gryphon Shafer <gryphon@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2017-2050 by Gryphon Shafer.

This is free software, licensed under:

    The Artistic License 2.0 (GPL Compatible)
