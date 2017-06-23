#!/usr/bin/env perl
use strict;
use warnings;
use 5.020;

my $books = {
    'Protestant' => [
        [ 'Genesis',         'Ge',  'Gen'    ],
        [ 'Exodus',          'Ex',  'Exo'    ],
        [ 'Leviticus',       'Le',  'Lev'    ],
        [ 'Numbers',         'Nu',  'Num'    ],
        [ 'Deuteronomy',     'De',  'Deut'   ],
        [ 'Joshua',          'Jsh', 'Josh'   ],
        [ 'Judges',          'Jdg', 'Judg'   ],
        [ 'Ruth',            'Ru',  'Ruth'   ],
        [ '1 Samuel',        '1Sa', '1 Sam'  ],
        [ '2 Samuel',        '2Sa', '2 Sam'  ],
        [ '1 Kings',         '1Ki'           ],
        [ '2 Kings',         '2Ki'           ],
        [ '1 Chronicles',    '1Ch', '1 Chr'  ],
        [ '2 Chronicles',    '2Ch', '2 Chr'  ],
        [ 'Ezra',            'Er',  'Ezr'    ],
        [ 'Nehemiah',        'Ne',  'Neh'    ],
        [ 'Esther',          'Es',  'Esth'   ],
        [ 'Job',             'Jb',  'Job'    ],
        [ 'Psalms',          'Ps'            ],
        [ 'Proverbs',        'Prv', 'Prov'   ],
        [ 'Ecclesiastes',    'Ec',  'Eccl'   ],
        [ 'Song of Solomon', 'Sng', 'Song'   ],
        [ 'Isaiah',          'Is',  'Isa'    ],
        [ 'Jeremiah',        'Je',  'Jer'    ],
        [ 'Lamentations',    'Lm',  'Lam'    ],
        [ 'Ezekiel',         'Ek',  'Ezek'   ],
        [ 'Daniel',          'Da',  'Dan'    ],
        [ 'Hosea',           'Ho',  'Hos'    ],
        [ 'Joel',            'Jl',  'Joel'   ],
        [ 'Amos',            'Am',  'Amos'   ],
        [ 'Obadiah',         'Ob',  'Oba'    ],
        [ 'Jonah',           'Jnh', 'Jonah'  ],
        [ 'Micah',           'Mi',  'Mic'    ],
        [ 'Nahum',           'Na',  'Nah'    ],
        [ 'Habakkuk',        'Hb',  'Hab'    ],
        [ 'Zephaniah',       'Zph', 'Zeph'   ],
        [ 'Haggai',          'Hg',  'Hag'    ],
        [ 'Zechariah',       'Zch', 'Zech'   ],
        [ 'Malachi',         'Ml',  'Mal'    ],
        [ 'Matthew',         'Mt',  'Matt'   ],
        [ 'Mark',            'Mk',  'Mark'   ],
        [ 'Luke',            'Lk',  'Luke'   ],
        [ 'John',            'Jhn', 'John'   ],
        [ 'Acts',            'Ac',  'Acts'   ],
        [ 'Romans',          'Ro',  'Rom'    ],
        [ '1 Corinthians',   '1Co', '1 Cor'  ],
        [ '2 Corinthians',   '2Co', '2 Cor'  ],
        [ 'Galatians',       'Ga',  'Gal'    ],
        [ 'Ephesians',       'Eph'           ],
        [ 'Philippians',     'Php', 'Philip' ],
        [ 'Colossians',      'Co',  'Col'    ],
        [ '1 Thessalonians', '1Th'           ],
        [ '2 Thessalonians', '2Th'           ],
        [ '1 Timothy',       '1Tm', '1 Tim'  ],
        [ '2 Timothy',       '2Tm', '2 Tim'  ],
        [ 'Titus',           'Ti',  'Titus'  ],
        [ 'Philemon',        'Phm', 'Phile'  ],
        [ 'Hebrews',         'He',  'Heb'    ],
        [ 'James',           'Ja',  'Jam'    ],
        [ '1 Peter',         '1Pt', '1 Pet'  ],
        [ '2 Peter',         '2Pt', '2 Pet'  ],
        [ '1 John',          '1Jn'           ],
        [ '2 John',          '2Jn'           ],
        [ '3 John',          '3Jn'           ],
        [ 'Jude',            'Jud', 'Jude'   ],
        [ 'Revelation',      'Rv',  'Rev'    ],
    ],
    'Catholic' => [
        [ 'Genesis',         'Ge',  'Gen'    ],
        [ 'Exodus',          'Ex',  'Exo'    ],
        [ 'Leviticus',       'Le',  'Lev'    ],
        [ 'Numbers',         'Nu',  'Num'    ],
        [ 'Deuteronomy',     'De',  'Deut'   ],
        [ 'Joshua',          'Jsh', 'Josh'   ],
        [ 'Judges',          'Jdg', 'Judg'   ],
        [ 'Ruth',            'Ru',  'Ruth'   ],
        [ '1 Samuel',        '1Sa', '1 Sam'  ],
        [ '2 Samuel',        '2Sa', '2 Sam'  ],
        [ '1 Kings',         '1Ki'           ],
        [ '2 Kings',         '2Ki'           ],
        [ '1 Chronicles',    '1Ch', '1 Chr'  ],
        [ '2 Chronicles',    '2Ch', '2 Chr'  ],
        [ 'Ezra',            'Er',  'Ezr'    ],
        [ 'Nehemiah',        'Ne',  'Neh'    ],
        [ 'Tobit',           ''              ],
        [ 'Judith',          ''              ],
        [ 'Esther',          'Es',  'Esth'   ],
        [ '1 Maccabees' ],
        [ '2 Maccabees' ],
        [ 'Job',             'Jb',  'Job'    ],
        [ 'Psalms',          'Ps'            ],
        [ 'Proverbs',        'Prv', 'Prov'   ],
        [ 'Ecclesiastes',    'Ec',  'Eccl'   ],
        [ 'Song of Songs', 'Sng', 'Song'   ],
        [ 'Wisdom' ],
        [ 'Sirach' ],
        [ 'Isaiah',          'Is',  'Isa'    ],
        [ 'Jeremiah',        'Je',  'Jer'    ],
        [ 'Lamentations',    'Lm',  'Lam'    ],
        ['Baruch'],
        [ 'Ezekiel',         'Ek',  'Ezek'   ],
        [ 'Daniel',          'Da',  'Dan'    ],
        [ 'Hosea',           'Ho',  'Hos'    ],
        [ 'Joel',            'Jl',  'Joel'   ],
        [ 'Amos',            'Am',  'Amos'   ],
        [ 'Obadiah',         'Ob',  'Oba'    ],
        [ 'Jonah',           'Jnh', 'Jonah'  ],
        [ 'Micah',           'Mi',  'Mic'    ],
        [ 'Nahum',           'Na',  'Nah'    ],
        [ 'Habakkuk',        'Hb',  'Hab'    ],
        [ 'Zephaniah',       'Zph', 'Zeph'   ],
        [ 'Haggai',          'Hg',  'Hag'    ],
        [ 'Zechariah',       'Zch', 'Zech'   ],
        [ 'Malachi',         'Ml',  'Mal'    ],
        [ 'Matthew',         'Mt',  'Matt'   ],
        [ 'Mark',            'Mk',  'Mark'   ],
        [ 'Luke',            'Lk',  'Luke'   ],
        [ 'John',            'Jhn', 'John'   ],
        [ 'Acts',            'Ac',  'Acts'   ],
        [ 'Romans',          'Ro',  'Rom'    ],
        [ '1 Corinthians',   '1Co', '1 Cor'  ],
        [ '2 Corinthians',   '2Co', '2 Cor'  ],
        [ 'Galatians',       'Ga',  'Gal'    ],
        [ 'Ephesians',       'Eph'           ],
        [ 'Philippians',     'Php', 'Philip' ],
        [ 'Colossians',      'Co',  'Col'    ],
        [ '1 Thessalonians', '1Th'           ],
        [ '2 Thessalonians', '2Th'           ],
        [ '1 Timothy',       '1Tm', '1 Tim'  ],
        [ '2 Timothy',       '2Tm', '2 Tim'  ],
        [ 'Titus',           'Ti',  'Titus'  ],
        [ 'Philemon',        'Phm', 'Phile'  ],
        [ 'Hebrews',         'He',  'Heb'    ],
        [ 'James',           'Ja',  'Jam'    ],
        [ '1 Peter',         '1Pt', '1 Pet'  ],
        [ '2 Peter',         '2Pt', '2 Pet'  ],
        [ '1 John',          '1Jn'           ],
        [ '2 John',          '2Jn'           ],
        [ '3 John',          '3Jn'           ],
        [ 'Jude',            'Jud', 'Jude'   ],
        [ 'Revelation',      'Rv',  'Rev'    ],
    ],
    'Vulgate' => [
        [ 'Genesis',         'Ge',  'Gen'    ],
        [ 'Exodus',          'Ex',  'Exo'    ],
        [ 'Leviticus',       'Le',  'Lev'    ],
        [ 'Numbers',         'Nu',  'Num'    ],
        [ 'Deuteronomy',     'De',  'Deut'   ],
        [ 'Josue',          'Jsh', 'Josh'   ],
        [ 'Judges',          'Jdg', 'Judg'   ],
        [ 'Ruth',            'Ru',  'Ruth'   ],
        [ '1 Kings',        '1Sa', '1 Sam'  ],
        [ '2 Kings',        '2Sa', '2 Sam'  ],
        [ '3 Kings',         '1Ki'           ],
        [ '4 Kings',         '2Ki'           ],
        [ '1 Paralipomenon',    '1Ch', '1 Chr'  ],
        [ '2 Paralipomenon',    '2Ch', '2 Chr'  ],
        [ '1 Esdras' ],
        [ '2 Esdras' ],
        [ '3 Esdras' ],
        [ '4 Esdras' ],
        [ 'Tobias',           ''              ],
        [ 'Judith',          ''              ],
        [ 'Esther',          'Es',  'Esth'   ],
        [ '1 Machabees' ],
        [ '2 Machabees' ],
        [ 'Job',             'Jb',  'Job'    ],
        [ 'Psalms',          'Ps'            ],
        [ 'Prayer of Manasseh'],
        [ 'Proverbs',        'Prv', 'Prov'   ],
        [ 'Ecclesiastes',    'Ec',  'Eccl'   ],
        [ 'Canticle of Canticles', 'Sng', 'Song'   ],
        [ 'Wisdom' ],
        [ 'Ecclesiasticus' ],
        [ 'Isaias',          'Is',  'Isa'    ],
        [ 'Jeremias',        'Je',  'Jer'    ],
        [ 'Lamentations',    'Lm',  'Lam'    ],
        ['Baruch'],
        [ 'Ezechiel',         'Ek',  'Ezek'   ],
        [ 'Daniel',          'Da',  'Dan'    ],
        [ 'Osee',           'Ho',  'Hos'    ],
        [ 'Joel',            'Jl',  'Joel'   ],
        [ 'Amos',            'Am',  'Amos'   ],
        [ 'Abdias' ],
        [ 'Jonas' ],
        [ 'Micheas' ],
        [ 'Nahu' ],
        [ 'Habacuc' ],
        [ 'Sophonias' ],
        [ 'Aggeus' ],
        [ 'Zacharias' ],
        [ 'Malachias' ],
        [ 'Matthew',         'Mt',  'Matt'   ],
        [ 'Mark',            'Mk',  'Mark'   ],
        [ 'Luke',            'Lk',  'Luke'   ],
        [ 'John',            'Jhn', 'John'   ],
        [ 'Acts',            'Ac',  'Acts'   ],
        [ 'Romans',          'Ro',  'Rom'    ],
        [ '1 Corinthians',   '1Co', '1 Cor'  ],
        [ '2 Corinthians',   '2Co', '2 Cor'  ],
        [ 'Galatians',       'Ga',  'Gal'    ],
        [ 'Ephesians',       'Eph'           ],
        [ 'Philippians',     'Php', 'Philip' ],
        [ 'Colossians',      'Co',  'Col'    ],
        [ '1 Thessalonians', '1Th'           ],
        [ '2 Thessalonians', '2Th'           ],
        [ '1 Timothy',       '1Tm', '1 Tim'  ],
        [ '2 Timothy',       '2Tm', '2 Tim'  ],
        [ 'Titus',           'Ti',  'Titus'  ],
        [ 'Philemon',        'Phm', 'Phile'  ],
        [ 'Hebrews',         'He',  'Heb'    ],
        [ 'James',           'Ja',  'Jam'    ],
        [ '1 Peter',         '1Pt', '1 Pet'  ],
        [ '2 Peter',         '2Pt', '2 Pet'  ],
        [ '1 John',          '1Jn'           ],
        [ '2 John',          '2Jn'           ],
        [ '3 John',          '3Jn'           ],
        [ 'Jude',            'Jud', 'Jude'   ],
        [ 'Revelation',      'Rv',  'Rev'    ],
    ],
};

my ( %x, %c );

my %overrides = (
    '1 Corinthians' => '1Cor',
    '2 Corinthians' => '2Cor',
    '1 Chronicles'  => '1Chr',
    '2 Chronicles'  => '2Chr',
    '1 John'        => '1Jhn',
    '2 John'        => '2Jhn',
    '3 John'        => '3Jhn',

    Daniel      => 'Da',
    Esther      => 'Esr',
    Ezra        => 'Ezr',
    Genesis     => 'Ge',
    Habakkuk    => 'Hk',
    Hebrews     => 'Heb',
    Hosea       => 'Ho',
    James       => 'Jms',
    John        => 'Jhn',
    Jude        => 'Jde',
    Judges      => 'Jdg',
    Judith      => 'Jdt',
    Mark        => 'Mk',
    Nahum       => 'Nahm',
    Nehemiah    => 'Neh',
    Numbers     => 'Nub',
    Philemon    => 'Phm',
    Philippians => 'Php',
    Psalms      => 'Psa',
    Ruth        => 'Ru',
    Titus       => 'Tts',

    Joshua      => 'Jos',
    Josue       => 'Jos',

    Jonah       => 'Jnh',
    Jonah       => 'Jnh',


    Tobit       => 'Tb',
    Tobias      => 'Tb',

    Ezekiel     => 'Ek',
    Ezechiel    => 'Ech',

    Proverbs    => 'Prv',
    'Prayer of Manasseh' => 'Pra',

    Micah       => 'Mic',
    Micheas     => 'Mic',




);

my @books = ( map { $_->[0] } @{ $books->{Vulgate} } );

for my $book (@books) {
    my $o = $book;
    my $acronym;

    if ( grep { $_ eq $o } keys %overrides ) {
        $acronym = $overrides{$o};
    }
    else {
        $o =~ s/\s+//g;
        $o =~ s/(^\d*\w)//;
        $acronym = $1;
        $o =~ s/([^aeiouy])//;
        $acronym .= $1;
    }

    $x{$book} = $acronym;
    push( @{ $c{$acronym} }, $book );
}

for ( sort keys %x ) {
    my $c = scalar(@{$c{$x{$_}}});
    printf "%-17s => %-4s %d\n", $_, $x{$_}, $c if ( $c > 2 );
}

for my $a ( sort keys %c ) {
    my $pattern = join( '.*', split( '', $a ) );
    my $re = qr/$pattern/i;

    my @matches = grep {
        $_ =~ $re
        and
        substr($_,0,1) eq substr($a,0,1)
        } @books;

    if ( @matches > 1 ) {
        print $a, "\n";
        print ' ' x 4, $_, "\n" for (@matches);
    }
}
