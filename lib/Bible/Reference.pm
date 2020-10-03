package Bible::Reference;
# ABSTRACT: Simple Bible reference parser, tester, and canonicalizer

use 5.014;

use exact;
use exact::class;

# VERSION

has acronyms             => 0;
has sorting              => 1;
has require_verse_match  => 0;
has require_book_ucfirst => 0;
has minimum_book_length  => 3;

has _bibles => {
    Catholic => [
        [ 'Genesis',               'Ge',   'Gn',      'Gen'                                              ],
        [ 'Exodus',                'Ex',   'Exo'                                                         ],
        [ 'Leviticus',             'Lv',   'Lev'                                                         ],
        [ 'Numbers',               'Nu',   'Nm',      'Num'                                              ],
        [ 'Deuteronomy',           'Dt',   'Deu'                                                         ],
        [ 'Joshua',                'Jsh',  'Jos',     'Josh'                                             ],
        [ 'Judges',                'Jdg',  'Judg'                                                        ],
        [ 'Ruth',                  'Ru',   'Rut'                                                         ],
        [ '1 Samuel',              '1Sa',  '1Sm',     '1Sam'                                             ],
        [ '2 Samuel',              '2Sa',  '2Sm',     '2Sam'                                             ],
        [ '1 Kings',               '1Ki',  '1Kg',     '1Kin'                                             ],
        [ '2 Kings',               '2Ki',  '2Kg',     '2Kin'                                             ],
        [ '1 Chronicles',          '1Ch',  '1Cr',     '1Chr'                                             ],
        [ '2 Chronicles',          '2Ch',  '2Cr',     '2Chr'                                             ],
        [ 'Ezra',                  'Ezr'                                                                 ],
        [ 'Nehemiah',              'Ne',   'Neh'                                                         ],
        [ 'Tobit',                 'Tb',   'Tob'                                                         ],
        [ 'Judith',                'Judi'                                                                ],
        [ 'Esther',                'Est',  'Esth'                                                        ],
        [ '1 Maccabees',           '1Ma',  '1Mac'                                                        ],
        [ '2 Maccabees',           '2Ma',  '2Mac'                                                        ],
        [ 'Job',                   'Jb',   'Jo',      'Job'                                              ],
        [ 'Psalm',                 'Ps',   'Psa',     'Psalms'                                           ],
        [ 'Proverbs',              'Pr',   'Prv',     'Pro',                 'Prov'                      ],
        [ 'Ecclesiastes',          'Ec',   'Ecc',     'Eccl'                                             ],
        [ 'Song of Songs',         'SS',   'Son',     'Song',                'Song of Solomon'           ],
        [ 'Wisdom',                'Wi',   'Ws',      'Wis'                                              ],
        [ 'Sirach',                'Si',   'Sr',      'Sir'                                              ],
        [ 'Isaiah',                'Is',   'Isa'                                                         ],
        [ 'Jeremiah',              'Jr',   'Jer'                                                         ],
        [ 'Lamentations',          'Lm',   'La',      'Lam'                                              ],
        [ 'Baruch',                'Ba',   'Br',      'Bar'                                              ],
        [ 'Ezekiel',               'Ezk',  'Ez',      'Eze',                 'Ezek'                      ],
        [ 'Daniel',                'Da',   'Dn',      'Dan'                                              ],
        [ 'Hosea',                 'Ho',   'Hs',      'Hos'                                              ],
        [ 'Joel',                  'Jl',   'Joe',     'Joel'                                             ],
        [ 'Amos',                  'Am',   'Amo'                                                         ],
        [ 'Obadiah',               'Ob',   'Oba'                                                         ],
        [ 'Jonah',                 'Jnh',  'Jon',     'Jona'                                             ],
        [ 'Micah',                 'Mi',   'Mic'                                                         ],
        [ 'Nahum',                 'Na',   'Nah'                                                         ],
        [ 'Habakkuk',              'Hab'                                                                 ],
        [ 'Zephaniah',             'Zp',   'Zep',     'Zph',                 'Zeph'                      ],
        [ 'Haggai',                'Hg',   'Hag'                                                         ],
        [ 'Zechariah',             'Zec',  'Zch',     'Zech'                                             ],
        [ 'Malachi',               'Ml',   'Mal'                                                         ],
        [ 'Matthew',               'Mt',   'Mat',     'Matt'                                             ],
        [ 'Mark',                  'Mk',   'Mr',      'Mc',                  'Mark'                      ],
        [ 'Luke',                  'Lk',   'Lu',      'Luk'                                              ],
        [ 'John',                  'Joh'                                                                 ],
        [ 'Acts',                  'Ac',   'Act'                                                         ],
        [ 'Romans',                'Ro',   'Rm',      'Rom'                                              ],
        [ '1 Corinthians',         '1Co',  '1Cor'                                                        ],
        [ '2 Corinthians',         '2Co',  '2Cor'                                                        ],
        [ 'Galatians',             'Ga',   'Gl',      'Gal'                                              ],
        [ 'Ephesians',             'Ep',   'Eph'                                                         ],
        [ 'Philippians',           'Php',  'Phil'                                                        ],
        [ 'Colossians',            'Cl',   'Col'                                                         ],
        [ '1 Thessalonians',       '1Th',  '1The'                                                        ],
        [ '2 Thessalonians',       '2Th',  '2The'                                                        ],
        [ '1 Timothy',             '1Ti',  '1Tm',     '1Tim'                                             ],
        [ '2 Timothy',             '2Ti',  '2Tm',     '2Tim'                                             ],
        [ 'Titus',                 'Ti',   'Tt'                                                          ],
        [ 'Philemon',              'Phm',  'Phile'                                                       ],
        [ 'Hebrews',               'He',   'Heb'                                                         ],
        [ 'James',                 'Jam',  'Jms'                                                         ],
        [ '1 Peter',               '1Pt',  '1Pe',     '1Pet'                                             ],
        [ '2 Peter',               '2Pt',  '2Pe',     '2Pet'                                             ],
        [ '1 John',                '1Jn',  '1Jo',     '1Joh'                                             ],
        [ '2 John',                '2Jn',  '2Jo',     '2Joh'                                             ],
        [ '3 John',                '3Jn',  '3Jo',     '3Joh'                                             ],
        [ 'Jude',                  'Jud',  'Jude'                                                        ],
        [ 'Revelation',            'Rv',   'Rev'                                                         ],
    ],
    Orthodox => [
        [ 'Genesis',               'Ge',   'Gn',      'Gen'                                              ],
        [ 'Exodus',                'Ex',   'Exo'                                                         ],
        [ 'Leviticus',             'Lv',   'Lev'                                                         ],
        [ 'Numbers',               'Nu',   'Nm',      'Num'                                              ],
        [ 'Deuteronomy',           'Dt',   'Deu'                                                         ],
        [ 'Joshua',                'Jsh',  'Jos',     'Josh'                                             ],
        [ 'Judges',                'Jdg',  'Judg'                                                        ],
        [ 'Ruth',                  'Ru',   'Rut'                                                         ],
        [ '1 Samuel',              '1Sa',  '1Sm',     '1Sam'                                             ],
        [ '2 Samuel',              '2Sa',  '2Sm',     '2Sam'                                             ],
        [ '1 Kings',               '1Ki',  '1Kg',     '1Kin'                                             ],
        [ '2 Kings',               '2Ki',  '2Kg',     '2Kin'                                             ],
        [ '1 Chronicles',          '1Ch',  '1Cr',     '1Chr'                                             ],
        [ '2 Chronicles',          '2Ch',  '2Cr',     '2Chr'                                             ],
        [ 'Esdras',                'Esd'                                                                 ],
        [ 'Ezra',                  'Ezr'                                                                 ],
        [ 'Nehemiah',              'Ne',   'Neh'                                                         ],
        [ 'Tobit',                 'Tb',   'Tob'                                                         ],
        [ 'Judith',                'Judi'                                                                ],
        [ 'Esther',                'Est',  'Esth'                                                        ],
        [ '1 Maccabees',           '1Ma',  '1Mac'                                                        ],
        [ '2 Maccabees',           '2Ma',  '2Mac'                                                        ],
        [ '3 Maccabees',           '3Ma',  '3Mac'                                                        ],
        [ '4 Maccabees',           '4Ma',  '4Mac'                                                        ],
        [ 'Job',                   'Jb',   'Jo',      'Job'                                              ],
        [ 'Psalm',                 'Ps',   'Psa',     'Psalms'                                           ],
        [ 'Prayer of Manasseh',    'PM',   'Pra',     'Man'                                              ],
        [ 'Proverbs',              'Pr',   'Prv',     'Pro',                 'Prov'                      ],
        [ 'Ecclesiastes',          'Ec',   'Ecc',     'Eccl'                                             ],
        [ 'Song of Songs',         'SS',   'Son',     'Song',                'Song of Solomon'           ],
        [ 'Wisdom',                'Wi',   'Ws',      'Wis'                                              ],
        [ 'Sirach',                'Si',   'Sr',      'Sir'                                              ],
        [ 'Isaiah',                'Is',   'Isa'                                                         ],
        [ 'Jeremiah',              'Jr',   'Jer'                                                         ],
        [ 'Lamentations',          'Lm',   'La',      'Lam'                                              ],
        [ 'Baruch',                'Ba',   'Br',      'Bar'                                              ],
        [ 'Letter of Jeremiah',    'LJ',   'Let'                                                         ],
        [ 'Ezekiel',               'Ezk',  'Ez',      'Eze',                 'Ezek'                      ],
        [ 'Daniel',                'Da',   'Dn',      'Dan'                                              ],
        [ 'Hosea',                 'Ho',   'Hs',      'Hos'                                              ],
        [ 'Joel',                  'Jl',   'Joe',     'Joel'                                             ],
        [ 'Amos',                  'Am',   'Amo'                                                         ],
        [ 'Obadiah',               'Ob',   'Oba'                                                         ],
        [ 'Jonah',                 'Jnh',  'Jon',     'Jona'                                             ],
        [ 'Micah',                 'Mi',   'Mic'                                                         ],
        [ 'Nahum',                 'Na',   'Nah'                                                         ],
        [ 'Habakkuk',              'Hab'                                                                 ],
        [ 'Zephaniah',             'Zp',   'Zep',     'Zph',                 'Zeph'                      ],
        [ 'Haggai',                'Hg',   'Hag'                                                         ],
        [ 'Zechariah',             'Zec',  'Zch',     'Zech'                                             ],
        [ 'Malachi',               'Ml',   'Mal'                                                         ],
        [ 'Matthew',               'Mt',   'Mat',     'Matt'                                             ],
        [ 'Mark',                  'Mk',   'Mr',      'Mc',                  'Mark'                      ],
        [ 'Luke',                  'Lk',   'Lu',      'Luk'                                              ],
        [ 'John',                  'Joh'                                                                 ],
        [ 'Acts',                  'Ac',   'Act'                                                         ],
        [ 'Romans',                'Ro',   'Rm',      'Rom'                                              ],
        [ '1 Corinthians',         '1Co',  '1Cor'                                                        ],
        [ '2 Corinthians',         '2Co',  '2Cor'                                                        ],
        [ 'Galatians',             'Ga',   'Gl',      'Gal'                                              ],
        [ 'Ephesians',             'Ep',   'Eph'                                                         ],
        [ 'Philippians',           'Php',  'Phil'                                                        ],
        [ 'Colossians',            'Cl',   'Col'                                                         ],
        [ '1 Thessalonians',       '1Th',  '1The'                                                        ],
        [ '2 Thessalonians',       '2Th',  '2The'                                                        ],
        [ '1 Timothy',             '1Ti',  '1Tm',     '1Tim'                                             ],
        [ '2 Timothy',             '2Ti',  '2Tm',     '2Tim'                                             ],
        [ 'Titus',                 'Ti',   'Tt'                                                          ],
        [ 'Philemon',              'Phm',  'Phile'                                                       ],
        [ 'Hebrews',               'He',   'Heb'                                                         ],
        [ 'James',                 'Jam',  'Jms'                                                         ],
        [ '1 Peter',               '1Pt',  '1Pe',     '1Pet'                                             ],
        [ '2 Peter',               '2Pt',  '2Pe',     '2Pet'                                             ],
        [ '1 John',                '1Jn',  '1Jo',     '1Joh'                                             ],
        [ '2 John',                '2Jn',  '2Jo',     '2Joh'                                             ],
        [ '3 John',                '3Jn',  '3Jo',     '3Joh'                                             ],
        [ 'Jude',                  'Jud',  'Jude'                                                        ],
        [ 'Revelation',            'Rv',   'Rev'                                                         ],
    ],
    Protestant => [
        [ 'Genesis',               'Ge',   'Gn',      'Gen'                                              ],
        [ 'Exodus',                'Ex',   'Exo'                                                         ],
        [ 'Leviticus',             'Lv',   'Lev'                                                         ],
        [ 'Numbers',               'Nu',   'Nm',      'Num'                                              ],
        [ 'Deuteronomy',           'Dt',   'Deu'                                                         ],
        [ 'Joshua',                'Jsh',  'Jos',     'Josh'                                             ],
        [ 'Judges',                'Jdg',  'Judg'                                                        ],
        [ 'Ruth',                  'Ru',   'Rut'                                                         ],
        [ '1 Samuel',              '1Sa',  '1Sm',     '1Sam'                                             ],
        [ '2 Samuel',              '2Sa',  '2Sm',     '2Sam'                                             ],
        [ '1 Kings',               '1Ki',  '1Kg',     '1Kin'                                             ],
        [ '2 Kings',               '2Ki',  '2Kg',     '2Kin'                                             ],
        [ '1 Chronicles',          '1Ch',  '1Cr',     '1Chr'                                             ],
        [ '2 Chronicles',          '2Ch',  '2Cr',     '2Chr'                                             ],
        [ 'Ezra',                  'Ezr'                                                                 ],
        [ 'Nehemiah',              'Ne',   'Neh'                                                         ],
        [ 'Esther',                'Est',  'Esth'                                                        ],
        [ 'Job',                   'Jb',   'Jo',      'Job'                                              ],
        [ 'Psalm',                 'Ps',   'Psa',     'Psalms'                                           ],
        [ 'Proverbs',              'Pr',   'Prv',     'Pro',                 'Prov'                      ],
        [ 'Ecclesiastes',          'Ec',   'Ecc',     'Eccl'                                             ],
        [ 'Song of Songs',         'SS',   'Son',     'Song',                'Song of Solomon'           ],
        [ 'Isaiah',                'Is',   'Isa'                                                         ],
        [ 'Jeremiah',              'Jr',   'Jer'                                                         ],
        [ 'Lamentations',          'Lm',   'La',      'Lam'                                              ],
        [ 'Ezekiel',               'Ezk',  'Ez',      'Eze',                 'Ezek'                      ],
        [ 'Daniel',                'Da',   'Dn',      'Dan'                                              ],
        [ 'Hosea',                 'Ho',   'Hs',      'Hos'                                              ],
        [ 'Joel',                  'Jl',   'Joe',     'Joel'                                             ],
        [ 'Amos',                  'Am',   'Amo'                                                         ],
        [ 'Obadiah',               'Ob',   'Oba'                                                         ],
        [ 'Jonah',                 'Jnh',  'Jon',     'Jona'                                             ],
        [ 'Micah',                 'Mi',   'Mic'                                                         ],
        [ 'Nahum',                 'Na',   'Nah'                                                         ],
        [ 'Habakkuk',              'Hab'                                                                 ],
        [ 'Zephaniah',             'Zp',   'Zep',     'Zph',                 'Zeph'                      ],
        [ 'Haggai',                'Hg',   'Hag'                                                         ],
        [ 'Zechariah',             'Zec',  'Zch',     'Zech'                                             ],
        [ 'Malachi',               'Ml',   'Mal'                                                         ],
        [ 'Matthew',               'Mt',   'Mat',     'Matt'                                             ],
        [ 'Mark',                  'Mk',   'Mr',      'Mc',                  'Mark'                      ],
        [ 'Luke',                  'Lk',   'Lu',      'Luk'                                              ],
        [ 'John',                  'Joh'                                                                 ],
        [ 'Acts',                  'Ac',   'Act'                                                         ],
        [ 'Romans',                'Ro',   'Rm',      'Rom'                                              ],
        [ '1 Corinthians',         '1Co',  '1Cor'                                                        ],
        [ '2 Corinthians',         '2Co',  '2Cor'                                                        ],
        [ 'Galatians',             'Ga',   'Gl',      'Gal'                                              ],
        [ 'Ephesians',             'Ep',   'Eph'                                                         ],
        [ 'Philippians',           'Php',  'Phil'                                                        ],
        [ 'Colossians',            'Cl',   'Col'                                                         ],
        [ '1 Thessalonians',       '1Th',  '1The'                                                        ],
        [ '2 Thessalonians',       '2Th',  '2The'                                                        ],
        [ '1 Timothy',             '1Ti',  '1Tm',     '1Tim'                                             ],
        [ '2 Timothy',             '2Ti',  '2Tm',     '2Tim'                                             ],
        [ 'Titus',                 'Ti',   'Tt'                                                          ],
        [ 'Philemon',              'Phm',  'Phile'                                                       ],
        [ 'Hebrews',               'He',   'Heb'                                                         ],
        [ 'James',                 'Jam',  'Jms'                                                         ],
        [ '1 Peter',               '1Pt',  '1Pe',     '1Pet'                                             ],
        [ '2 Peter',               '2Pt',  '2Pe',     '2Pet'                                             ],
        [ '1 John',                '1Jn',  '1Jo',     '1Joh'                                             ],
        [ '2 John',                '2Jn',  '2Jo',     '2Joh'                                             ],
        [ '3 John',                '3Jn',  '3Jo',     '3Joh'                                             ],
        [ 'Jude',                  'Jud',  'Jude'                                                        ],
        [ 'Revelation',            'Rv',   'Rev'                                                         ],
    ],
    Vulgate => [
        [ 'Genesis',               'Ge',   'Gn',      'Gen',                 'Genesis'                   ],
        [ 'Exodus',                'Ex',   'Exo',     'Exodus'                                           ],
        [ 'Leviticus',             'Lv',   'Lev',     'Leviticus'                                        ],
        [ 'Numbers',               'Nu',   'Nm',      'Num',                 'Numeri'                    ],
        [ 'Deuteronomy',           'Dt',   'Deu',     'Deuteronomium'                                    ],
        [ 'Joshua',                'Jsh',  'Jos',     'Josh',                'Iosue'                     ],
        [ 'Judges',                'Jdg',  'Judg',    'Iudicum'                                          ],
        [ 'Ruth',                  'Ru',   'Rut',     'Ruth'                                             ],
        [ '1 Samuel',              '1Sa',  '1Sm',     '1Sam',                '1 Samuelis'                ],
        [ '2 Samuel',              '2Sa',  '2Sm',     '2Sam',                '2 Samuelis'                ],
        [ '1 Kings',               '1Ki',  '1Kg',     '1Kin',                '1 Regum'                   ],
        [ '2 Kings',               '2Ki',  '2Kg',     '2Kin',                '2 Regum'                   ],
        [ '1 Paralipomenon',       '1Pa',  '1Par',    '1 Paralipomenon'                                  ],
        [ '2 Paralipomenon',       '2Pa',  '2Par',    '2 Paralipomenon'                                  ],
        [ 'Esdras',                'Esd',  'Esdrae'                                                      ],
        [ 'Nehemiah',              'Ne',   'Neh',     'Nehemiae'                                         ],
        [ 'Tobias',                'Tb',   'Tob',     'Tobiae'                                           ],
        [ 'Judith',                'Judi', 'Iudith'                                                      ],
        [ 'Esther',                'Est',  'Esth',    'Esther'                                           ],
        [ '1 Maccabees',           '1Ma',  '1Mac',    '1 Machabaeorum'                                   ],
        [ '2 Maccabees',           '2Ma',  '2Mac',    '2 Machabaeorum'                                   ],
        [ 'Job',                   'Jb',   'Jo',      'Job',                 'Iob'                       ],
        [ 'Psalm',                 'Ps',   'Psa',     'Psalms',              'Psalmi'                    ],
        [ 'Proverbs',              'Pr',   'Prv',     'Pro',                 'Prov',         'Proverbia' ],
        [ 'Ecclesiastes',          'Ec',   'Ecc',     'Eccl',                'Ecclesiastes'              ],
        [ 'Canticle of Canticles', 'CC',   'Can',     'Canticum Canticorum'                              ],
        [ 'Wisdom',                'Wi',   'Ws',      'Wis',                 'Sapientia'                 ],
        [ 'Ecclesiasticus',        'Ecu',  'Eclu',    'Ecclesiasticus'                                   ],
        [ 'Isaias',                'Is',   'Isa',     'Isaias'                                           ],
        [ 'Jeremias',              'Jr',   'Jer',     'Ieremias'                                         ],
        [ 'Lamentations',          'Lm',   'La',      'Lam',                 'Lamentationes'             ],
        [ 'Baruch',                'Ba',   'Br',      'Bar',                 'Baruch'                    ],
        [ 'Ezekiel',               'Ezk',  'Ez',      'Eze',                 'Ezek',         'Ezechiel'  ],
        [ 'Daniel',                'Da',   'Dn',      'Dan',                 'Daniel'                    ],
        [ 'Osee',                  'Os',   'Ose',     'Osee'                                             ],
        [ 'Joel',                  'Jl',   'Joe',     'Joel',                'Ioel'                      ],
        [ 'Amos',                  'Am',   'Amo',     'Amos'                                             ],
        [ 'Abdias',                'Ab',   'Abd',     'Abdias'                                           ],
        [ 'Jonas',                 'Jns',  'Jon',     'Jona',                'Ionas'                     ],
        [ 'Micheas',               'Mi',   'Mic',     'Michaeas'                                         ],
        [ 'Nahu',                  'Na',   'Nah',     'Nahum'                                            ],
        [ 'Habacuc',               'Hab',  'Habacuc'                                                     ],
        [ 'Sophonias',             'So',   'Sop',     'Sph',                 'Sophonias'                 ],
        [ 'Aggeus',                'Ag',   'Agg ',    'Aggaeus'                                          ],
        [ 'Zacharias',             'Zec',  'Zch',     'Zech',                'Zacharias'                 ],
        [ 'Malachias',             'Ml',   'Mal',     'Malachias'                                        ],
        [ 'Matthew',               'Mt',   'Mat',     'Matt',                'Matthaeus'                 ],
        [ 'Mark',                  'Mk',   'Mr',      'Mc',                  'Mark',         'Marcus'    ],
        [ 'Luke',                  'Lk',   'Lu',      'Luk',                 'Lucas'                     ],
        [ 'John',                  'Joh',  'Ioannes'                                                     ],
        [ 'Acts',                  'Ac',   'Act',     'Actus Apostolorum'                                ],
        [ 'Romans',                'Ro',   'Rm',      'Rom',                 'Romanos'                   ],
        [ '1 Corinthians',         '1Co',  '1Cor',    '1 Corinthios'                                     ],
        [ '2 Corinthians',         '2Co',  '2Cor',    '2 Corinthios'                                     ],
        [ 'Galatians',             'Ga',   'Gl',      'Gal',                 'Galatas'                   ],
        [ 'Ephesians',             'Ep',   'Eph',     'Ephesios'                                         ],
        [ 'Philippians',           'Php',  'Phil',    'Philippenses'                                     ],
        [ 'Colossians',            'Cl',   'Col',     'Colossenses'                                      ],
        [ '1 Thessalonians',       '1Th',  '1The',    '1 Thessalonicenses'                               ],
        [ '2 Thessalonians',       '2Th',  '2The',    '2 Thessalonicenses'                               ],
        [ '1 Timothy',             '1Ti',  '1Tm',     '1Tim',                '1 Timotheum'               ],
        [ '2 Timothy',             '2Ti',  '2Tm',     '2Tim',                '2 Timotheum'               ],
        [ 'Titus',                 'Ti',   'Tt',      'Titum'                                            ],
        [ 'Philemon',              'Phm',  'Phile',   'Philemonem'                                       ],
        [ 'Hebrews',               'He',   'Heb',     'Hebraeos'                                         ],
        [ 'James',                 'Jam',  'Jms',     'Iacobi'                                           ],
        [ '1 Peter',               '1Pt',  '1Pe',     '1Pet',                '1 Petri'                   ],
        [ '2 Peter',               '2Pt',  '2Pe',     '2Pet',                '2 Petri'                   ],
        [ '1 John',                '1Jn',  '1Jo',     '1Joh',                '1 Ioannis'                 ],
        [ '2 John',                '2Jn',  '2Jo',     '2Joh',                '2 Ioannis'                 ],
        [ '3 John',                '3Jn',  '3Jo',     '3Joh',                '3 Ioannis'                 ],
        [ 'Jude',                  'Jud',  'Jude',    'Iudae'                                            ],
        [ 'Revelation',            'Rv',   'Rev',     'Apocalypsis'                                      ],
    ],
};

has _lengths => {
    Catholic => [
       [
            31, 25, 24, 26, 32, 22, 24, 22, 29, 32, 32, 20, 18, 24, 21, 16, 27,
            33, 38, 18, 34, 24, 20, 67, 34, 35, 46, 22, 35, 43, 55, 32, 20, 31,
            29, 43, 36, 30, 23, 23, 57, 38, 34, 34, 28, 34, 31, 22, 33, 26
       ],
       [
            22, 25, 22, 31, 23, 30, 25, 32, 35, 29, 10, 51, 22, 31, 27, 36, 16,
            27, 25, 26, 36, 31, 33, 18, 40, 37, 21, 43, 46, 38, 18, 35, 23, 35,
            35, 38, 29, 31, 43, 38
       ],
       [
            17, 16, 17, 35, 19, 30, 38, 36, 24, 20, 47, 8, 59, 57, 33, 34, 16, 30,
            37, 27, 24, 33, 44, 23, 55, 46, 34
       ],
       [
            54, 34, 51, 49, 31, 27, 89, 26, 23, 36, 35, 16, 33, 45, 41, 50, 13,
            32, 22, 29, 35, 41, 30, 25, 18, 65, 23, 31, 40, 16, 54, 42, 56, 29,
            34, 13
       ],
       [
            46, 37, 29, 49, 33, 25, 26, 20, 29, 22, 32, 32, 18, 29, 23, 22, 20,
            22, 21, 20, 23, 30, 25, 22, 19, 19, 26, 68, 29, 20, 30, 52, 29, 12
       ],
       [
            18, 24, 17, 24, 15, 27, 26, 35, 27, 43, 23, 24, 33, 15, 63, 10, 18,
            28, 51, 9, 45, 34, 16, 33
       ],
       [
            36, 23, 31, 24, 31, 40, 25, 35, 57, 18, 40, 15, 25, 20, 20, 31, 13,
            31, 30, 48, 25
       ],
       [ 22, 23, 18, 22 ],
       [
            28, 36, 21, 22, 12, 21, 17, 22, 27, 27, 15, 25, 23, 52, 35, 23, 58,
            30, 24, 42, 15, 23, 29, 22, 44, 25, 12, 25, 11, 31, 13
       ],
       [
            27, 32, 39, 12, 25, 23, 29, 18, 13, 19, 27, 31, 39, 33, 37, 23, 29,
            33, 43, 26, 22, 51, 39, 25
       ],
       [
            53, 46, 28, 34, 18, 38, 51, 66, 28, 29, 43, 33, 34, 31, 34, 34, 24,
            46, 21, 43, 29, 53
       ],
       [
            18, 25, 27, 44, 27, 33, 20, 29, 37, 36, 21, 21, 25, 29, 38, 20, 41,
            37, 37, 21, 26, 20, 37, 20, 30
       ],
       [
            54, 55, 24, 43, 26, 81, 40, 40, 44, 14, 47, 40, 14, 17, 29, 43, 27,
            17, 19, 8, 30, 19, 32, 31, 31, 32, 34, 21, 30
       ],
       [
            17, 18, 17, 22, 14, 42, 22, 18, 31, 19, 23, 16, 22, 15, 19, 14, 19,
            34, 11, 37, 20, 12, 21, 27, 28, 23, 9, 27, 36, 27, 21, 33, 25, 33, 27,
            23
       ],
       [ 11, 70, 13, 24, 17, 22, 28, 36, 15, 44 ],
       [ 11, 20, 32, 23, 19, 19, 73, 18, 38, 39, 36, 47, 31 ],
       [ 22, 14, 17, 21, 22, 18, 16, 21, 6, 13, 18, 22, 18, 15 ],
       [ 16, 28, 10, 15, 24, 21, 32, 36, 14, 23, 23, 20, 20, 19, 14, 25 ],
       [ 22, 23, 15, 17, 14, 14, 10, 17, 32, 3 ],
       [ 64, 70, 60, 61, 68, 63, 50, 32, 73, 89, 74, 53, 53, 49, 41, 24 ],
       [ 36, 32, 40, 50, 27, 31, 42, 36, 29, 38, 38, 45, 26, 46, 39 ],
       [
            22, 13, 26, 21, 27, 30, 21, 22, 35, 22, 20, 25, 28, 22, 35, 22, 16,
            21, 29, 29, 34, 30, 17, 25, 6, 14, 23, 28, 25, 31, 40, 22, 33, 37, 16,
            33, 24, 41, 30, 24, 34, 17
       ],
       [
            6, 12, 8, 8, 12, 10, 17, 9, 20, 18, 7, 8, 6, 7, 5, 11, 15, 50, 14, 9,
            13, 31, 6, 10, 22, 12, 14, 9, 11, 12, 24, 11, 22, 22, 28, 12, 40, 22,
            13, 17, 13, 11, 5, 26, 17, 11, 9, 14, 20, 23, 19, 9, 6, 7, 23, 13, 11,
            11, 17, 12, 8, 12, 11, 10, 13, 20, 7, 35, 36, 5, 24, 20, 28, 23, 10,
            12, 20, 72, 13, 19, 16, 8, 18, 12, 13, 17, 7, 18, 52, 17, 16, 15, 5,
            23, 11, 13, 12, 9, 9, 5, 8, 28, 22, 35, 45, 48, 43, 13, 31, 7, 10, 10,
            9, 8, 18, 19, 2, 29, 176, 7, 8, 9, 4, 8, 5, 6, 5, 6, 8, 8, 3, 18, 3,
            3, 21, 26, 9, 8, 24, 13, 10, 7, 12, 15, 21, 10, 20, 14, 9, 6
       ],
       [
            33, 22, 35, 27, 23, 35, 27, 36, 18, 32, 31, 28, 25, 35, 33, 33, 28,
            24, 29, 30, 31, 29, 35, 34, 28, 28, 27, 28, 27, 33, 31
       ],
       [ 18, 26, 22, 16, 20, 12, 29, 17, 18, 20, 10, 14 ],
       [ 17, 17, 11, 16, 16, 13, 13, 14 ],
       [
            16, 24, 19, 20, 23, 25, 30, 21, 18, 21, 26, 27, 19, 31, 19, 29, 21,
            25, 22
       ],
       [
            30, 18, 31, 31, 15, 37, 36, 19, 18, 31, 34, 18, 26, 27, 20, 30, 32,
            33, 30, 31, 28, 27, 27, 34, 26, 29, 30, 26, 28, 25, 31, 24, 33, 31,
            26, 31, 31, 34, 35, 30, 22, 25, 33, 23, 26, 20, 25, 25, 16, 29, 30
       ],
       [
            31, 22, 26, 6, 30, 13, 25, 22, 21, 34, 16, 6, 22, 32, 9, 14, 14, 7,
            25, 6, 17, 25, 18, 23, 12, 21, 13, 29, 24, 33, 9, 20, 24, 17, 10, 22,
            38, 22, 8, 31, 29, 25, 28, 28, 25, 13, 15, 22, 26, 11, 23, 15, 12, 17,
            13, 12, 21, 14, 21, 22, 11, 12, 19, 12, 25, 24
       ],
       [
            19, 37, 25, 31, 31, 30, 34, 22, 26, 25, 23, 17, 27, 22, 21, 21, 27,
            23, 15, 18, 14, 30, 40, 10, 38, 24, 22, 17, 32, 24, 40, 44, 26, 22,
            19, 32, 21, 28, 18, 16, 18, 22, 13, 30, 5, 28, 7, 47, 39, 46, 64, 34
       ],
       [ 22, 22, 66, 22, 22 ],
       [ 22, 35, 37, 37, 9 ],
       [
            28, 10, 27, 17, 17, 14, 27, 18, 11, 22, 25, 28, 23, 23, 8, 63, 24, 32,
            14, 49, 32, 31, 49, 27, 17, 21, 36, 26, 21, 26, 18, 32, 33, 31, 15,
            38, 28, 23, 29, 49, 26, 20, 27, 31, 25, 24, 23, 35
       ],
       [ 21, 49, 30, 37, 31, 28, 28, 27, 27, 21, 45, 13 ],
       [ 11, 23, 5, 19, 15, 11, 16, 14, 17, 15, 12, 14, 16, 9 ],
       [ 20, 32, 21 ],
       [ 15, 16, 15, 13, 27, 14, 17, 14, 15 ],
       [ 21 ],
       [ 17, 10, 10, 11 ],
       [ 16, 13, 12, 13, 15, 16, 20 ],
       [ 15, 13, 19 ],
       [ 17, 20, 19 ],
       [ 18, 15, 20 ],
       [ 15, 23 ],
       [ 21, 13, 10, 14, 11, 15, 14, 23, 17, 12, 17, 14, 9, 21 ],
       [ 14, 17, 18, 6 ],
       [
            25, 23, 17, 25, 48, 34, 29, 34, 38, 42, 30, 50, 58, 36, 39, 28, 27,
            35, 30, 34, 46, 46, 39, 51, 46, 75, 66, 20
       ],
       [ 45, 28, 35, 41, 43, 56, 37, 38, 50, 52, 33, 44, 37, 72, 47, 20 ],
       [
            80, 52, 38, 44, 39, 49, 50, 56, 62, 42, 54, 59, 35, 35, 32, 31, 37,
            43, 48, 47, 38, 71, 56, 53
       ],
       [
            51, 25, 36, 54, 4, 71, 53, 59, 41, 42, 57, 50, 38, 31, 27, 33, 26, 40,
            42, 31, 25
       ],
       [
            26, 47, 26, 37, 42, 15, 60, 40, 43, 48, 30, 25, 52, 28, 41, 40, 34,
            28, 41, 38, 40, 30, 35, 8, 27, 32, 44, 31
       ],
       [ 32, 29, 31, 25, 21, 23, 25, 39, 33, 21, 36, 21, 14, 23, 33, 27 ],
       [ 31, 16, 23, 21, 13, 20, 40, 13, 27, 33, 34, 31, 13, 40, 58, 24 ],
       [ 24, 17, 18, 18, 21, 18, 16, 24, 15, 18, 33, 21, 13 ],
       [ 24, 21, 29, 31, 26, 18 ],
       [ 23, 22, 21, 32, 33, 24 ],
       [ 30, 30, 21, 23 ],
       [ 29, 23, 25, 18 ],
       [ 10, 20, 13, 18, 28 ],
       [ 12, 17, 18 ],
       [ 20, 15, 16, 16, 25, 21 ],
       [ 18, 26, 17, 22 ],
       [ 16, 15, 15 ],
       [ 25 ],
       [ 14, 18, 19, 16, 14, 20, 28, 13, 28, 39, 40, 29, 25 ],
       [ 27, 26, 18, 17, 20 ],
       [ 25, 25, 22, 19, 14 ],
       [ 21, 22, 18 ],
       [ 10, 29, 24, 21, 21 ],
       [ 13 ],
       [ 15 ],
       [ 25 ],
       [
            20, 29, 22, 11, 14, 17, 17, 13, 21, 11, 19, 18, 18, 20, 8, 21, 18, 24,
            21, 15, 27, 21
       ],
    ],
    Orthodox => [
       [
            31, 25, 24, 26, 32, 22, 24, 22, 29, 32, 32, 20, 18, 24, 21, 16, 27,
            33, 38, 18, 34, 24, 20, 67, 34, 35, 46, 22, 35, 43, 55, 32, 20, 31,
            29, 43, 36, 30, 23, 23, 57, 38, 34, 34, 28, 34, 31, 22, 33, 26
       ],
       [
            22, 25, 22, 31, 23, 30, 25, 32, 35, 29, 10, 51, 22, 31, 27, 36, 16,
            27, 25, 26, 36, 31, 33, 18, 40, 37, 21, 43, 46, 38, 18, 35, 23, 35,
            35, 38, 29, 31, 43, 38
       ],
       [
            17, 16, 17, 35, 19, 30, 38, 36, 24, 20, 47, 8, 59, 31, 33, 34, 16, 30,
            37, 27, 24, 33, 44, 23, 55, 46, 34
       ],
       [
            54, 34, 51, 49, 31, 27, 89, 26, 23, 36, 35, 16, 33, 45, 41, 50, 13,
            32, 22, 29, 35, 41, 30, 25, 18, 65, 23, 31, 40, 16, 54, 42, 56, 29,
            34, 13
       ],
       [
            46, 37, 29, 49, 33, 25, 26, 20, 29, 22, 32, 32, 18, 29, 23, 22, 20,
            22, 21, 20, 23, 30, 25, 22, 19, 19, 26, 68, 29, 20, 30, 52, 29, 12
       ],
       [
            18, 24, 17, 24, 15, 27, 26, 35, 27, 43, 23, 24, 33, 15, 63, 10, 18,
            28, 51, 9, 45, 34, 16, 33
       ],
       [
            36, 23, 31, 24, 31, 40, 25, 35, 57, 18, 40, 15, 25, 20, 20, 31, 13,
            31, 30, 48, 25
       ],
       [ 22, 23, 18, 22 ],
       [
            28, 36, 21, 22, 12, 21, 17, 22, 27, 27, 15, 25, 23, 41, 35, 23, 58,
            30, 24, 42, 15, 23, 29, 22, 44, 25, 12, 25, 11, 31, 13
       ],
       [
            27, 32, 39, 12, 25, 23, 29, 18, 13, 19, 27, 31, 39, 33, 37, 23, 29,
            33, 43, 26, 22, 51, 39, 25
       ],
       [
            53, 46, 28, 34, 18, 38, 51, 66, 28, 29, 43, 33, 34, 31, 34, 34, 24,
            46, 21, 43, 29, 53
       ],
       [
            18, 25, 27, 44, 27, 33, 20, 29, 37, 36, 21, 21, 25, 29, 38, 20, 41,
            37, 37, 21, 26, 20, 37, 20, 30
       ],
       [
            54, 55, 24, 43, 26, 81, 40, 40, 44, 14, 47, 40, 14, 17, 29, 43, 27,
            17, 19, 8, 30, 19, 32, 31, 31, 32, 34, 21, 30
       ],
       [
            17, 18, 17, 22, 14, 42, 22, 18, 31, 19, 23, 16, 22, 15, 19, 14, 19,
            34, 11, 37, 20, 12, 21, 27, 28, 23, 9, 27, 36, 27, 21, 33, 25, 33, 27,
            23
       ],
       [ 58, 30, 24, 63, 73, 34, 15, 95, 55 ],
       [ 11, 70, 13, 24, 17, 22, 28, 36, 15, 44 ],
       [ 11, 20, 32, 23, 19, 19, 73, 18, 38, 39, 36, 47, 31 ],
       [ 22, 14, 17, 19, 22, 18, 16, 21, 6, 13, 18, 22, 17, 15 ],
       [ 16, 28, 10, 15, 24, 21, 32, 36, 14, 23, 23, 20, 20, 19, 14, 25 ],
       [ 22, 6, 15, 17, 14, 14, 10, 17, 32, 3 ],
       [ 64, 70, 60, 61, 68, 63, 50, 32, 73, 89, 74, 53, 53, 49, 41, 24 ],
       [ 36, 32, 40, 50, 27, 31, 42, 36, 29, 38, 38, 45, 26, 46, 39 ],
       [ 29, 33, 30, 21, 51, 41, 23 ],
       [ 35, 24, 21, 26, 38, 35, 23, 29, 32, 21, 8, 19, 27, 20, 32, 25, 24, 24 ],
       [
            22, 13, 26, 21, 27, 30, 21, 22, 35, 22, 20, 25, 28, 22, 35, 22, 16,
            21, 29, 29, 34, 30, 17, 25, 6, 14, 23, 28, 25, 31, 40, 22, 33, 37, 16,
            33, 24, 41, 30, 24, 34, 17
       ],
       [
            6, 12, 8, 8, 12, 10, 17, 9, 20, 18, 7, 8, 6, 7, 5, 11, 15, 50, 14, 9,
            13, 31, 6, 10, 22, 12, 14, 9, 11, 12, 24, 11, 22, 22, 28, 12, 40, 22,
            13, 17, 13, 11, 5, 26, 13, 11, 9, 14, 20, 23, 19, 9, 6, 7, 23, 13, 11,
            11, 17, 12, 8, 12, 11, 10, 13, 20, 7, 35, 36, 5, 24, 20, 28, 23, 10,
            12, 20, 72, 13, 19, 16, 8, 18, 12, 13, 17, 7, 18, 52, 17, 16, 15, 5,
            23, 11, 13, 12, 9, 9, 5, 8, 28, 22, 35, 45, 48, 43, 13, 31, 7, 10, 10,
            9, 8, 18, 19, 2, 29, 176, 7, 8, 9, 4, 8, 5, 6, 5, 6, 8, 8, 3, 18, 3,
            3, 21, 26, 9, 8, 24, 13, 10, 7, 12, 15, 21, 10, 20, 14, 9, 6
       ],
       [ 15 ],
       [
            33, 22, 35, 27, 23, 35, 27, 36, 18, 32, 31, 28, 25, 35, 33, 33, 28,
            24, 29, 30, 31, 29, 35, 34, 28, 28, 27, 28, 27, 33, 31
       ],
       [ 18, 26, 22, 16, 20, 12, 29, 17, 2, 20, 10, 14 ],
       [ 17, 17, 11, 16, 16, 13, 13, 14 ],
       [
            16, 24, 19, 20, 23, 25, 30, 21, 18, 21, 26, 27, 19, 31, 19, 29, 21,
            25, 22
       ],
       [
            30, 18, 31, 31, 15, 37, 36, 19, 18, 31, 16, 18, 26, 27, 20, 16, 17, 3,
            21, 32, 28, 8, 27, 34, 26, 29, 30, 26, 28, 25, 31, 24, 33, 31, 26, 31,
            31, 34, 35, 30, 22, 25, 33, 23, 26, 20, 25, 25, 16, 29, 30
       ],
       [
            31, 22, 26, 6, 30, 13, 25, 22, 21, 34, 16, 6, 22, 32, 9, 14, 14, 7,
            25, 6, 17, 25, 18, 23, 12, 21, 13, 29, 24, 33, 9, 20, 24, 17, 10, 22,
            38, 22, 8, 31, 29, 25, 28, 28, 25, 13, 15, 22, 26, 11, 23, 15, 12, 17,
            13, 12, 21, 14, 21, 22, 11, 12, 9, 12, 25, 24
       ],
       [
            19, 37, 25, 31, 31, 30, 34, 22, 6, 25, 23, 17, 27, 22, 21, 21, 27, 23,
            15, 18, 14, 30, 40, 10, 38, 24, 22, 17, 32, 24, 40, 44, 26, 22, 19,
            32, 21, 28, 18, 16, 18, 22, 13, 30, 5, 28, 7, 47, 39, 46, 64, 34
       ],
       [ 22, 22, 66, 22, 22 ],
       [ 22, 35, 37, 37, 9 ],
       [ 73 ],
       [
            28, 10, 27, 17, 17, 14, 27, 18, 11, 22, 25, 28, 23, 23, 8, 63, 24, 32,
            14, 49, 32, 25, 49, 27, 17, 21, 36, 26, 21, 26, 18, 32, 33, 31, 15,
            38, 28, 23, 29, 49, 26, 20, 27, 31, 25, 24, 16, 35
       ],
       [ 21, 49, 30, 37, 31, 28, 28, 27, 27, 21, 45, 13 ],
       [ 11, 23, 5, 19, 15, 11, 16, 14, 17, 15, 12, 14, 16, 9 ],
       [ 20, 32, 21 ],
       [ 15, 16, 15, 13, 27, 14, 17, 14, 15 ],
       [ 21 ],
       [ 17, 10, 10, 11 ],
       [ 16, 13, 12, 13, 15, 16, 20 ],
       [ 15, 13, 19 ],
       [ 17, 20, 19 ],
       [ 18, 15, 20 ],
       [ 15, 23 ],
       [ 21, 13, 10, 14, 11, 15, 14, 23, 17, 12, 17, 14, 9, 21 ],
       [ 14, 17, 18, 6 ],
       [
            25, 23, 17, 25, 48, 34, 29, 34, 38, 42, 30, 50, 58, 36, 39, 2, 27, 35,
            30, 34, 46, 46, 39, 51, 46, 75, 66, 20
       ],
       [ 45, 28, 35, 41, 43, 56, 37, 38, 50, 52, 33, 44, 37, 72, 47, 20 ],
       [
            80, 52, 38, 44, 39, 49, 50, 56, 56, 42, 54, 59, 35, 35, 32, 31, 37,
            43, 48, 47, 38, 71, 56, 48
       ],
       [
            4, 25, 36, 36, 4, 71, 38, 59, 41, 42, 57, 50, 38, 31, 27, 33, 26, 40,
            42, 31, 25
       ],
       [
            26, 47, 26, 37, 42, 15, 60, 40, 43, 48, 30, 25, 52, 28, 18, 40, 34,
            28, 41, 38, 40, 30, 35, 8, 27, 32, 44, 31
       ],
       [ 32, 29, 31, 25, 21, 23, 25, 16, 33, 21, 36, 21, 14, 23, 33, 27 ],
       [ 31, 16, 23, 21, 13, 20, 40, 13, 27, 33, 34, 31, 13, 40, 58, 24 ],
       [ 24, 17, 18, 18, 21, 18, 16, 24, 15, 18, 33, 21, 13 ],
       [ 24, 21, 29, 31, 26, 18 ],
       [ 23, 22, 21, 32, 33, 24 ],
       [ 30, 30, 21, 23 ],
       [ 29, 23, 11, 18 ],
       [ 10, 20, 13, 18, 28 ],
       [ 12, 17, 18 ],
       [ 20, 15, 16, 16, 25, 21 ],
       [ 18, 26, 17, 22 ],
       [ 16, 15, 15 ],
       [ 25 ],
       [ 14, 18, 19, 16, 14, 20, 28, 13, 28, 39, 40, 23, 25 ],
       [ 27, 26, 18, 17, 20 ],
       [ 25, 25, 22, 19, 14 ],
       [ 21, 22, 18 ],
       [ 10, 29, 24, 21, 8 ],
       [ 13 ],
       [ 15 ],
       [ 25 ],
       [
            20, 29, 22, 11, 14, 17, 17, 13, 21, 11, 19, 18, 18, 20, 8, 21, 18, 24,
            21, 15, 27, 2
       ],
    ],
    Protestant => [
       [
            31, 25, 24, 26, 32, 22, 24, 22, 29, 32, 13, 20, 18, 24, 21, 16, 27,
            33, 38, 18, 34, 24, 20, 67, 34, 35, 46, 22, 35, 43, 55, 32, 20, 31,
            29, 43, 36, 30, 23, 23, 57, 38, 34, 34, 28, 34, 31, 22, 33, 26
       ],
       [
            22, 25, 22, 31, 23, 30, 25, 32, 35, 29, 10, 51, 22, 31, 27, 36, 16,
            27, 6, 26, 36, 31, 33, 18, 40, 37, 21, 43, 46, 38, 18, 35, 23, 35, 35,
            38, 29, 31, 43, 38
       ],
       [
            17, 16, 17, 35, 19, 30, 38, 36, 24, 20, 47, 8, 59, 57, 33, 34, 16, 30,
            37, 27, 24, 33, 44, 23, 55, 46, 34
       ],
       [
            54, 34, 51, 49, 31, 27, 89, 26, 23, 36, 35, 16, 33, 45, 41, 50, 13,
            32, 22, 29, 15, 41, 30, 25, 18, 65, 23, 31, 40, 16, 54, 42, 56, 29,
            34, 13
       ],
       [
            46, 37, 29, 49, 33, 25, 26, 20, 29, 22, 32, 32, 18, 29, 23, 22, 20,
            22, 21, 20, 23, 30, 25, 22, 19, 19, 26, 68, 29, 20, 30, 52, 29, 12
       ],
       [
            18, 24, 17, 24, 15, 27, 26, 35, 27, 43, 23, 24, 33, 15, 63, 10, 18,
            28, 51, 9, 45, 34, 16, 33
       ],
       [
            36, 23, 31, 24, 31, 40, 25, 35, 57, 18, 40, 15, 25, 20, 20, 14, 13,
            31, 30, 48, 25
       ],
       [ 22, 23, 18, 22 ],
       [
            28, 36, 21, 22, 12, 21, 17, 22, 27, 27, 1, 25, 23, 52, 35, 23, 58, 30,
            24, 42, 15, 23, 29, 22, 44, 25, 12, 25, 11, 31, 13
       ],
       [
            27, 32, 39, 12, 25, 4, 29, 18, 13, 19, 27, 31, 39, 33, 37, 23, 29, 33,
            43, 26, 22, 51, 39, 25
       ],
       [
            53, 46, 28, 34, 18, 38, 51, 66, 28, 29, 43, 33, 34, 31, 34, 34, 24,
            46, 21, 43, 29, 53
       ],
       [
            18, 25, 27, 44, 27, 33, 20, 29, 37, 36, 21, 21, 25, 29, 38, 20, 41,
            37, 37, 21, 26, 20, 37, 20, 30
       ],
       [
            54, 55, 24, 43, 26, 26, 40, 40, 44, 14, 47, 40, 14, 17, 29, 20, 27,
            17, 19, 8, 30, 19, 32, 31, 31, 32, 34, 21, 30
       ],
       [
            17, 18, 17, 22, 14, 42, 22, 18, 31, 19, 23, 16, 22, 15, 19, 14, 19,
            34, 11, 37, 20, 12, 21, 27, 28, 23, 9, 27, 36, 27, 21, 33, 25, 33, 27,
            23
       ],
       [ 11, 70, 13, 24, 17, 22, 28, 36, 15, 38 ],
       [ 11, 20, 32, 23, 19, 19, 73, 18, 38, 39, 36, 47, 31 ],
       [ 22, 23, 15, 17, 14, 14, 10, 17, 32, 3 ],
       [
            22, 13, 26, 21, 27, 30, 21, 22, 35, 22, 20, 25, 28, 22, 35, 22, 16,
            21, 29, 29, 34, 30, 17, 25, 6, 14, 23, 28, 25, 31, 40, 22, 33, 37, 11,
            33, 24, 41, 30, 24, 34, 17
       ],
       [
            6, 12, 8, 8, 12, 10, 17, 9, 20, 18, 7, 8, 6, 7, 5, 11, 15, 50, 14, 9,
            13, 31, 6, 10, 22, 12, 14, 9, 11, 12, 24, 11, 22, 22, 28, 12, 40, 22,
            13, 17, 13, 11, 5, 26, 17, 11, 9, 14, 20, 23, 19, 9, 6, 7, 23, 13, 11,
            11, 17, 12, 8, 12, 11, 10, 13, 20, 7, 35, 36, 5, 24, 20, 28, 23, 10,
            12, 20, 72, 13, 19, 16, 8, 18, 12, 13, 17, 7, 18, 52, 17, 16, 15, 5,
            23, 11, 13, 12, 9, 9, 5, 8, 28, 22, 35, 45, 48, 43, 13, 31, 7, 10, 10,
            9, 8, 18, 19, 2, 29, 176, 7, 8, 9, 4, 8, 5, 6, 5, 6, 8, 8, 3, 18, 3,
            3, 21, 26, 9, 8, 24, 13, 10, 7, 12, 15, 21, 10, 20, 14, 9, 6
       ],
       [
            33, 22, 35, 27, 23, 35, 27, 36, 18, 32, 31, 28, 25, 35, 33, 33, 28,
            24, 29, 30, 31, 29, 35, 34, 8, 28, 27, 28, 27, 33, 31
       ],
       [ 18, 26, 22, 16, 20, 12, 29, 17, 18, 20, 10, 14 ],
       [ 17, 17, 11, 16, 16, 13, 13, 14 ],
       [
            31, 22, 26, 6, 30, 10, 25, 22, 21, 34, 16, 6, 22, 32, 9, 14, 14, 7,
            25, 6, 17, 25, 3, 23, 12, 21, 13, 29, 24, 33, 9, 20, 24, 17, 10, 22,
            38, 22, 8, 31, 29, 25, 28, 28, 25, 13, 15, 22, 26, 11, 23, 15, 11, 17,
            13, 12, 21, 14, 21, 22, 11, 12, 9, 12, 25, 24
       ],
       [
            19, 37, 25, 31, 31, 30, 34, 22, 26, 25, 23, 17, 27, 22, 21, 21, 3, 23,
            15, 18, 14, 30, 40, 10, 38, 24, 22, 17, 32, 24, 40, 44, 26, 22, 19,
            32, 21, 28, 18, 16, 18, 22, 13, 30, 5, 28, 7, 47, 39, 46, 64, 34
       ],
       [ 22, 22, 66, 22, 22 ],
       [
            28, 10, 27, 17, 17, 14, 27, 18, 11, 22, 25, 28, 23, 23, 8, 63, 24, 32,
            14, 49, 32, 31, 49, 27, 17, 21, 36, 26, 21, 26, 18, 32, 33, 31, 15,
            38, 28, 23, 29, 9, 26, 20, 27, 31, 25, 24, 16, 35
       ],
       [ 21, 49, 30, 37, 31, 28, 28, 27, 27, 21, 45, 13 ],
       [ 11, 23, 5, 19, 15, 11, 16, 14, 17, 15, 12, 14, 16, 9 ],
       [ 20, 19, 21 ],
       [ 15, 16, 15, 13, 27, 14, 17, 14, 15 ],
       [ 21 ],
       [ 17, 10, 10, 11 ],
       [ 16, 13, 12, 13, 15, 16, 20 ],
       [ 15, 13, 19 ],
       [ 17, 20, 19 ],
       [ 18, 15, 20 ],
       [ 15, 23 ],
       [ 21, 9, 10, 14, 11, 15, 14, 23, 17, 5, 17, 14, 9, 5 ],
       [ 14, 12, 18, 6 ],
       [
            25, 23, 17, 25, 48, 34, 29, 34, 38, 42, 30, 50, 58, 36, 39, 28, 27,
            35, 30, 34, 46, 46, 39, 51, 46, 75, 66, 20
       ],
       [ 45, 28, 35, 41, 43, 56, 37, 38, 50, 52, 23, 44, 37, 72, 47, 20 ],
       [
            80, 52, 38, 44, 39, 49, 50, 56, 62, 42, 54, 59, 35, 35, 32, 31, 37,
            43, 48, 47, 38, 71, 56, 53
       ],
       [
            51, 25, 36, 54, 39, 71, 38, 59, 39, 42, 57, 50, 38, 31, 27, 33, 26,
            40, 42, 31, 25
       ],
       [
            26, 47, 26, 37, 42, 15, 60, 40, 43, 48, 30, 25, 52, 28, 18, 40, 34,
            28, 41, 38, 40, 30, 35, 8, 27, 32, 44, 31
       ],
       [ 32, 29, 31, 25, 21, 23, 25, 21, 33, 21, 36, 21, 14, 23, 33, 27 ],
       [ 31, 16, 23, 21, 13, 20, 38, 3, 27, 33, 7, 31, 13, 34, 58, 24 ],
       [ 24, 17, 18, 18, 21, 18, 16, 24, 15, 18, 33, 21, 14 ],
       [ 24, 21, 23, 31, 26, 18 ],
       [ 9, 22, 21, 32, 33, 24 ],
       [ 30, 30, 21, 23 ],
       [ 29, 23, 25, 18 ],
       [ 10, 20, 13, 18, 28 ],
       [ 12, 17, 18 ],
       [ 20, 15, 16, 16, 25, 21 ],
       [ 18, 26, 17, 22 ],
       [ 16, 15, 15 ],
       [ 25 ],
       [ 14, 8, 19, 16, 14, 6, 28, 13, 28, 39, 40, 29, 25 ],
       [ 27, 26, 18, 17, 20 ],
       [ 25, 25, 19, 19, 14 ],
       [ 21, 22, 18 ],
       [ 10, 29, 24, 21, 8 ],
       [ 13 ],
       [ 14 ],
       [ 25 ],
       [
            20, 29, 22, 11, 14, 17, 17, 13, 21, 11, 19, 17, 18, 20, 8, 21, 18, 24,
            21, 15, 27, 21
       ],
    ],
    Vulgate => [
       [
            31, 25, 24, 26, 31, 22, 24, 22, 29, 32, 32, 20, 18, 24, 21, 16, 27,
            33, 38, 18, 34, 24, 20, 67, 34, 35, 46, 22, 35, 43, 55, 32, 20, 31,
            29, 43, 36, 30, 23, 23, 57, 38, 34, 34, 28, 34, 31, 22, 32, 25
       ],
       [
            22, 25, 22, 31, 23, 30, 25, 32, 35, 29, 10, 51, 22, 31, 27, 36, 16,
            27, 25, 26, 36, 31, 33, 18, 40, 37, 21, 43, 46, 38, 18, 35, 23, 35,
            35, 38, 29, 31, 43, 36
       ],
       [
            17, 16, 17, 35, 19, 30, 38, 36, 24, 20, 47, 8, 59, 57, 33, 34, 16, 30,
            37, 27, 24, 33, 44, 23, 55, 45, 34
       ],
       [
            54, 34, 51, 49, 31, 27, 89, 26, 23, 36, 34, 15, 34, 45, 41, 50, 13,
            32, 22, 30, 35, 41, 30, 25, 18, 65, 23, 31, 39, 17, 54, 42, 56, 29,
            34, 13
       ],
       [
            46, 37, 29, 49, 33, 25, 26, 20, 29, 22, 32, 32, 18, 29, 23, 22, 20,
            22, 21, 20, 23, 30, 25, 22, 19, 19, 26, 68, 29, 20, 30, 52, 29, 12
       ],
       [
            18, 24, 17, 25, 16, 27, 26, 35, 27, 43, 23, 24, 33, 15, 63, 10, 18,
            28, 51, 9, 43, 34, 16, 33
       ],
       [
            36, 23, 31, 24, 32, 40, 25, 35, 57, 18, 40, 15, 25, 20, 20, 31, 13,
            31, 30, 48, 24
       ],
       [ 22, 23, 18, 22 ],
       [
            28, 36, 21, 22, 12, 21, 17, 22, 27, 27, 15, 25, 23, 52, 35, 23, 58,
            30, 24, 43, 15, 23, 28, 23, 44, 25, 12, 25, 11, 31, 13
       ],
       [
            27, 32, 39, 12, 25, 23, 29, 18, 13, 19, 27, 31, 39, 33, 37, 23, 29,
            33, 43, 26, 22, 51, 39, 25
       ],
       [
            53, 46, 28, 34, 18, 38, 51, 66, 28, 29, 43, 33, 34, 31, 34, 34, 24,
            46, 21, 43, 29, 54
       ],
       [
            18, 25, 27, 44, 27, 33, 20, 29, 37, 36, 21, 21, 25, 29, 38, 20, 41,
            37, 37, 21, 26, 20, 37, 20, 30
       ],
       [
            54, 55, 24, 43, 26, 81, 40, 40, 44, 14, 46, 40, 14, 17, 29, 43, 27,
            17, 19, 7, 30, 19, 32, 31, 31, 32, 34, 21, 30
       ],
       [
            17, 18, 17, 22, 14, 42, 22, 18, 31, 19, 23, 16, 22, 15, 19, 14, 19,
            34, 11, 37, 20, 12, 21, 27, 28, 23, 9, 27, 36, 27, 21, 33, 25, 33, 27,
            23
       ],
       [ 11, 70, 13, 24, 17, 22, 28, 36, 15, 44 ],
       [ 11, 20, 31, 23, 19, 19, 73, 18, 38, 39, 36, 46, 31 ],
       [ 25, 23, 25, 23, 28, 22, 20, 24, 12, 13, 21, 22, 23, 17 ],
       [ 12, 18, 15, 17, 29, 21, 25, 34, 19, 20, 21, 20, 31, 18, 15, 31 ],
       [ 22, 23, 15, 17, 14, 14, 10, 17, 32, 13, 12, 6, 18, 19, 19, 24 ],
       [ 67, 70, 60, 61, 68, 63, 50, 32, 73, 89, 74, 54, 54, 49, 41, 24 ],
       [ 36, 33, 40, 50, 27, 31, 42, 36, 29, 38, 38, 46, 26, 46, 40 ],
       [
            22, 13, 26, 21, 27, 30, 21, 22, 35, 22, 20, 25, 28, 22, 35, 23, 16,
            21, 29, 29, 34, 30, 17, 25, 6, 14, 23, 28, 25, 31, 40, 22, 33, 37, 16,
            33, 24, 41, 35, 28, 25, 16
       ],
       [
            6, 13, 9, 10, 13, 11, 18, 10, 39, 8, 9, 6, 7, 5, 10, 15, 51, 15, 10,
            14, 32, 6, 10, 22, 12, 14, 9, 11, 13, 25, 11, 22, 23, 28, 13, 40, 23,
            14, 18, 14, 12, 5, 26, 18, 12, 10, 15, 21, 23, 21, 11, 7, 9, 24, 13,
            12, 12, 18, 14, 9, 13, 12, 11, 14, 20, 8, 36, 37, 6, 24, 20, 28, 23,
            11, 13, 21, 72, 13, 20, 17, 8, 19, 13, 14, 17, 7, 19, 53, 17, 16, 16,
            5, 23, 11, 13, 12, 9, 9, 5, 8, 29, 22, 35, 45, 48, 43, 14, 31, 7, 10,
            10, 9, 26, 9, 10, 2, 29, 176, 7, 8, 9, 4, 8, 5, 6, 5, 6, 8, 8, 3, 18,
            3, 3, 21, 26, 9, 8, 24, 14, 10, 8, 12, 15, 21, 10, 11, 9, 14, 9, 6
       ],
       [
            33, 22, 35, 27, 23, 35, 27, 36, 18, 32, 31, 28, 25, 35, 33, 33, 28,
            24, 29, 30, 31, 29, 35, 34, 28, 28, 27, 28, 27, 33, 31
       ],
       [ 18, 26, 22, 17, 19, 11, 30, 17, 18, 20, 10, 14 ],
       [ 16, 17, 11, 16, 17, 12, 13, 14 ],
       [
            16, 25, 19, 20, 24, 27, 30, 21, 19, 21, 27, 27, 19, 31, 19, 29, 20,
            25, 20
       ],
       [
            40, 23, 34, 36, 18, 37, 40, 22, 25, 34, 36, 19, 32, 27, 22, 31, 31,
            33, 28, 33, 31, 33, 38, 47, 36, 28, 33, 30, 35, 27, 42, 28, 33, 31,
            26, 28, 34, 39, 41, 32, 28, 26, 37, 27, 31, 23, 31, 28, 19, 31, 38
       ],
       [
            31, 22, 26, 6, 30, 13, 25, 22, 21, 34, 16, 6, 22, 32, 9, 14, 14, 7,
            25, 6, 17, 25, 18, 23, 12, 21, 13, 29, 24, 33, 9, 20, 24, 17, 10, 22,
            38, 22, 8, 31, 29, 25, 28, 28, 25, 13, 15, 22, 26, 11, 23, 15, 12, 17,
            13, 12, 21, 14, 21, 22, 11, 12, 19, 12, 25, 24
       ],
       [
            19, 37, 25, 31, 31, 30, 34, 22, 26, 25, 23, 17, 27, 22, 21, 21, 27,
            23, 15, 18, 14, 30, 40, 10, 38, 24, 22, 17, 32, 24, 40, 44, 26, 22,
            19, 32, 20, 28, 18, 16, 18, 22, 13, 30, 5, 28, 7, 47, 39, 46, 64, 34
       ],
       [ 22, 22, 66, 22, 22 ],
       [ 22, 35, 38, 37, 9, 72 ],
       [
            28, 9, 27, 17, 17, 14, 27, 18, 11, 22, 25, 28, 23, 23, 8, 63, 24, 32,
            14, 49, 32, 31, 49, 27, 17, 21, 36, 26, 21, 26, 18, 32, 33, 31, 15,
            38, 28, 23, 29, 49, 26, 20, 27, 31, 25, 24, 23, 35
       ],
       [ 21, 49, 100, 34, 31, 28, 28, 27, 27, 21, 45, 13, 65, 42 ],
       [ 11, 24, 5, 19, 15, 11, 16, 14, 17, 15, 12, 14, 15, 10 ],
       [ 20, 32, 21 ],
       [ 15, 16, 15, 13, 27, 15, 17, 14, 15 ],
       [ 21 ],
       [ 16, 11, 10, 11 ],
       [ 16, 13, 12, 13, 14, 16, 20 ],
       [ 15, 13, 19 ],
       [ 17, 20, 19 ],
       [ 18, 15, 20 ],
       [ 14, 24 ],
       [ 21, 13, 10, 14, 11, 15, 14, 23, 17, 12, 17, 14, 9, 21 ],
       [ 14, 17, 18, 6 ],
       [
            25, 23, 17, 25, 48, 34, 29, 34, 38, 42, 30, 50, 58, 36, 39, 28, 26,
            35, 30, 34, 46, 46, 39, 51, 46, 75, 66, 20
       ],
       [ 45, 28, 35, 40, 43, 56, 37, 39, 49, 52, 33, 44, 37, 72, 47, 20 ],
       [
            80, 52, 38, 44, 39, 49, 50, 56, 62, 42, 54, 59, 35, 35, 32, 31, 37,
            43, 48, 47, 38, 71, 56, 53
       ],
       [
            51, 25, 36, 54, 47, 72, 53, 59, 41, 42, 56, 50, 38, 31, 27, 33, 26,
            40, 42, 31, 25
       ],
       [
            26, 47, 26, 37, 42, 15, 59, 40, 43, 48, 30, 25, 52, 27, 41, 40, 34,
            28, 40, 38, 40, 30, 35, 27, 27, 32, 44, 31
       ],
       [ 32, 29, 31, 25, 21, 23, 25, 39, 33, 21, 36, 21, 14, 23, 33, 27 ],
       [ 31, 16, 23, 21, 13, 20, 40, 13, 27, 33, 34, 31, 13, 40, 58, 24 ],
       [ 23, 17, 18, 18, 21, 18, 16, 24, 15, 18, 33, 21, 13 ],
       [ 24, 21, 29, 31, 26, 18 ],
       [ 23, 22, 21, 32, 33, 24 ],
       [ 30, 30, 21, 23 ],
       [ 29, 23, 25, 18 ],
       [ 10, 20, 13, 18, 28 ],
       [ 12, 17, 18 ],
       [ 20, 15, 16, 16, 25, 21 ],
       [ 18, 26, 17, 22 ],
       [ 16, 15, 15 ],
       [ 25 ],
       [ 14, 18, 19, 16, 14, 20, 28, 13, 28, 39, 40, 29, 25 ],
       [ 27, 26, 18, 17, 20 ],
       [ 25, 25, 22, 19, 14 ],
       [ 21, 22, 18 ],
       [ 10, 29, 24, 21, 21 ],
       [ 13 ],
       [ 14 ],
       [ 25 ],
       [
            20, 29, 22, 11, 14, 17, 17, 13, 21, 11, 19, 18, 18, 20, 8, 21, 18, 24,
            21, 15, 27, 21
       ],
    ],
};

has _bible      => 'Protestant';
has _bible_data => {};
has _data       => [];
has _cache      => {};

sub bible ( $self, $name = undef ) {
    return $self->_bible unless ($name);

    my $input = lc( substr( $name || '', 0, 1 ) );
    my ($bible) = grep { lc( substr( $_, 0, 1 ) ) eq $input } keys %{ $self->_bibles };
    croak "Could not determine a valid Bible type from input" unless ($bible);
    $self->_bible($bible);

    my $books = $self->_bibles->{ $self->_bible };

    my $bible_data;
    for my $book_data (@$books) {
        my ( $book, @acronyms ) = @$book_data;

        $bible_data->{book_to_acronym}{$book} = $acronyms[0];
        push( @{ $bible_data->{books} }, $book );
    }
    my $book_count;
    $bible_data->{book_order} = { map { $_ => ++$book_count } @{ $bible_data->{books} } };

    my $canonical = [ map { $_->[0] } @$books ];
    my $options   = { map { shift @$_ => $_ } @$books };
    my $re_map    = { map {
        my $book     = $_;
        my $book_str = $_;
        my @prefix   = (
            ( $book_str =~ s/(\d)\s// ) ? (
                (
                    (
                        ( $1 == 1 ) ? ( qw( I   First  ) ) :
                        ( $1 == 2 ) ? ( qw( II  Second ) ) :
                        ( $1 == 3 ) ? ( qw( III Third  ) ) :
                        ( $1 == 4 ) ? ( qw( IV  Fourth ) ) : ()
                    ),
                    $1 . '*',
                ),
                $1,
            ) : ()
        );

        my @letters = split( '', $book_str );
        my $unique;
        while (@letters) {
            $unique .= shift @letters;
            last if (
                length $unique >= $self->minimum_book_length
                and (
                    not @prefix and
                        scalar( grep { index( $_, $unique ) == 0 } @$canonical ) == 1 or
                    @prefix and
                        scalar( grep { index( $_, $prefix[-1] . ' ' . $unique ) == 0 } @$canonical ) == 1
                )
            );
        }

        my @matches = $unique;
        push( @matches, $unique .= shift @letters ) while (@letters);

        @matches = map {
            my $match = $_;
            map { $_ . ' ' . $match } @prefix;
        } @matches if (@prefix);

        map {
            my $re = reverse $_;

            $re =~ s/\*/'[A-z]+'/ge;
            $re =~ s/\s+/'[\s_]*'/ge;

            $re => $book;
        } @matches, @{ $options->{$book} };
    } @$canonical };

    my @re_parts       = sort { length $a <=> length $b } keys %$re_map;
    my $re_refs_string = '\b(' . join( '|', map { '(?:[\d:,;\s\-]|dna|ro|&)*' . $_ } @re_parts ) . ')\b';

    $bible_data->{re_refs}  = qr/$re_refs_string/;
    $bible_data->{re_books} = [ map { [ qr/\b$_\b/, $re_map->{$_} ] } @re_parts ];
    $bible_data->{lengths}  = {
        map {
            $bible_data->{books}[$_] => $self->_lengths->{$bible}[$_]
        } 0 .. @{ $bible_data->{books} } - 1
    };

    $self->_bible_data($bible_data);
    return $bible;
}

sub new ( $self, %params ) {
    $self = $self->SUPER::new(%params);
    $self->bible( $params{bible} || $self->_bible );
    return $self;
}

sub _list ( $self, $start, $stop ) {
    $start++ if ( $start == 0 );
    $stop++  if ( $stop  == 0 );

    my ( $x,  $y ) = sort { $a <=> $b } $start, $stop;
    my @list = $x .. $y;
    @list = reverse(@list) if ( $x < $start );

    return @list;
};

sub _expand ( $self, $book, $start, $stop ) {
    my $start_ch = ( $start =~ s/(\d+):// ) ? $1 : 0;
    my $stop_ch  = ( $stop  =~ s/(\d+):// ) ? $1 : 0;

    if ( not $start_ch and not $stop_ch ) {
        return join( ',', $self->_list( $start, $stop ) );
    }
    elsif ( $start_ch and not $stop_ch ) {
        if ( $stop < $start ) {
            $stop_ch = $stop;
            $stop    = $self->_bible_data->{lengths}{$book}[ $stop_ch - 1 ];
        }

        return join( ',', grep { defined }
            $start_ch . ':' . join( ',', $self->_list( $start, $stop ) ),
            ( ($stop_ch) ? join( ',', $self->_list( $start_ch + 1, $stop_ch ) ) : undef ),
        );
    }
    elsif ( not $start_ch and $stop_ch ) {
        $start_ch = $start;
        $start    = 1;

        return join( ':',
            join( ',', $self->_list( $start_ch, $stop_ch ) ),
            join( ',', $self->_list( $start, $stop ) ),
        );
    }
    elsif ( $start_ch and $stop_ch ) {
        return join( ',', grep { defined }
            $start_ch . ':' . join( ',', $self->_list(
                $start,
                $self->_bible_data->{lengths}{$book}[ $start_ch - 1 ],
            ) ),
            (
                ( $stop_ch - $start_ch > 1 )
                    ? join( ',', $self->_list( $start_ch + 1, $stop_ch - 1 ) )
                    : undef
            ),
            $stop_ch . ':' . join( ',', $self->_list( 1, $stop ) ),
        );
    }
};

sub in ( $self, @input ) {
    return $self unless (@input);

    my $re_refs = $self->_bible_data->{re_refs};
    for my $string (@input) {
        $string = scalar( reverse $string );
        my @processed;
        while ( $string =~ /$re_refs/ ) {
            my ( $pre, $ref, $post ) = split( /$re_refs/, $string, 2 );
            $string = $post;

            my $space = ( $ref =~ s/^((?:\W|dna|ro|&)+)// ) ? $1 : '';
            $ref =~ s/\s+/ /g;
            $pre = $pre . $space;
            push( @processed, $pre );

            my $book;
            for ( @{ $self->_bible_data->{re_books} } ) {
                if ( $ref =~ /$_->[0]/ ) {
                    $book = $_->[1];
                    last;
                }
            }

            my $ref_out = [$book];
            my $numbers = [];

            # TODO: require_verse_match and require_book_ucfirst support
                # has require_verse_match  => 0; (replace * with + to require more than just book)
                # has require_book_ucfirst => 0;

            # TODO: support "Rev. 4:12" situations

            $ref =~ s/(?:dna|ro|&)/,/g;
            $ref = scalar reverse $ref;

            if ( $ref =~ /([\d:,;\s\-]+)$/ ) {
                my $range = $1 || '';
                $range =~ s/[\s,]+/,/g;
                $range =~ s/^,//g;
                $range =~ s/(\d+(?::\d+)?)\-(\d+(?::\d+)?)/ $self->_expand( $book, $1, $2 ) /ge;

                my $verse_context = 0;
                my $last_d        = 0;

                while ( $range =~ s/^(\d+)([:,;]?)\D*//g ) {
                    my ( $d, $s ) = ( $1, $2 || '' );

                    $verse_context = 0 if ( $d <= $last_d );

                    unless ($verse_context) {
                        push( @$numbers, [$d] );
                    }
                    else {
                        push( @{ $numbers->[-1] }, [] ) unless ( @{ $numbers->[-1] } > 1 );
                        push( @{ $numbers->[-1][-1] }, $d );
                    }

                    $last_d = ($verse_context) ? $d : 0;

                    $verse_context = 1 if ( $s eq ':' );
                    $verse_context = 0 if ( $s eq ';' );
                }
            }

            push( @$ref_out, $numbers ) if (@$numbers);
            push( @processed, $ref_out );
        }

        push( @processed, $string );
        push(
            @{ $self->_data },
            [ grep { length } map { ( ref $_ ) ? $_ : scalar reverse $_ } reverse @processed ],
        );
    }

    return $self;
}

sub clear ($self) {
    $self->_data([]);
    return $self;
}

sub books ($self) {
    return (wantarray) ? @{ $self->_bible_data->{books} } : $self->_bible_data->{books};
}

# TODO: delete this...

# sub _as_hashref {
#     my %refs;
#     for my $ref (@_) {
#         my $book = $ref->[0];

#         for my $chapter_block ( @{ $ref->[1] } ) {
#             my $chapter = $chapter_block->[0];

#             $refs{$book}{$chapter} //= [];
#             if ( $chapter_block->[1] ) {
#                 my %verses = map { $_ => 1 } @{ $refs{$book}{$chapter} }, @{ $chapter_block->[1] };
#                 $refs{$book}{$chapter} = [ sort { $a <=> $b } keys %verses ];
#             }
#         }
#     }

#     return \%refs;
# }

# has _manual_in_refs => [];

# sub _in_refs ($self) {
#     unless ( @{ $self->_manual_in_refs } ) {
#         return grep { ref } map { @$_ } @{ $self->_data };
#     }
#     else {
#         my $refs = $self->_manual_in_refs;
#         $self->_manual_in_refs([]);
#         return @$refs;
#     }
# }

    # my @refs = $self->_in_refs;
    # @refs = $self->_sort(@refs) if ( $self->sorting );

    # if ( $self->acronyms ) {
    #     my $book_to_acronym = $self->_bible_data->{book_to_acronym};
    #     @refs = map { $_->[0] = $book_to_acronym->{ $_->[0] }; $_ } @refs;
    # }

sub as_array ($self) {
    if (
        not $self->_cache->{data} or
        not (
            $self->_cache->{sorting}  and $self->_cache->{sorting}  == $self->sorting and
            $self->_cache->{acronyms} and $self->_cache->{acronyms} == $self->acronyms
        )
    ) {
        my $data = [ map { grep { ref } @$_ } @{ $self->_data } ];

        if ( $self->sorting ) {
            my $data_by_book = {};
            push( @{ $data_by_book->{ $_->[0] } }, @{ $_->[1] } ) for (@$data);

            $data = [
                map {
                    my $dedup;
                    for my $chapter ( @{ $data_by_book->{ $_->[1] } } ) {
                        $dedup->{ $chapter->[0] } //= {};
                        $dedup->{ $chapter->[0] }{$_} = 1 for ( @{ $chapter->[1] } );
                    }
                    [
                        $_->[1],
                        [
                            map {
                                my $chapter = [$_];
                                my @verses = keys %{ $dedup->{$_} };
                                push( @$chapter, [ sort { $a <=> $b } @verses ] ) if @verses;
                                $chapter;
                            }
                            sort { $a <=> $b }
                            keys %$dedup
                        ],
                    ];
                }
                sort { $a->[0] <=> $b->[0] }
                map { [ $self->_bible_data->{book_order}{$_}, $_ ] }
                keys %$data_by_book
            ];
        }

        if ( $self->acronyms ) {
            for (@$data) {
                $_->[0] = $self->_bible_data->{book_to_acronym}{ $_->[0] };
            }
        }

        $self->_cache->{data} = $data;
    }

    return (wantarray) ? @{ $self->_cache->{data} } : $self->_cache->{data};
}

# TODO: delete this...

# sub as_hash ($self) {
#     my $refs = _as_hashref( $self->_in_refs );

#     if ( $self->acronyms ) {
#         my $book_to_acronym = $self->_bible_data->{book_to_acronym};
#         $refs->{ $book_to_acronym->{$_} } = delete $refs->{$_} for ( keys %$refs );
#     }

#     return (wantarray) ? %$refs : $refs;
# }

sub as_hash ($self) {
    my $data = {};
    for my $book_block ( $self->as_array ) {
        my ( $book_name, $chapters ) = @$book_block;
        push( @{ $data->{$book_name}{ $_->[0] } }, @{ $_->[1] } ) for (@$chapters);
    }

    return (wantarray) ? %$data : $data;
}

# TODO: delete this...

# sub _sort ( $self, @input ) {
#     my $book_order = $self->_bible_data->{book_order};
#     my $refs       = _as_hashref(@input);

#     return
#         map {
#             my $book = $_->[1];
#             [
#                 $book,
#                 [
#                     map {
#                         ( @{ $refs->{$book}{$_} } ) ? [ $_, $refs->{$book}{$_} ] : [$_]
#                     } sort { $a <=> $b } keys %{ $refs->{$book} }
#                 ],
#             ];
#         }
#         sort { $a->[0] <=> $b->[0] }
#         map { [ $book_order->{$_}, $_ ] }
#         keys %$refs;
# }

sub as_verses ($self) {
    my $data = [
        map {
            my $book = $_->[0];
            map {
                my $chapter = $_->[0];
                map { "$book $chapter:$_" } @{ $_->[1] };
            } @{ $_->[1] };
        } $self->as_array
    ];

    return (wantarray) ? @$data : $data;
}

# TODO: delete this...

# sub _compress_range ( $items = [] ) {
#     my ( $last, @items, @range );

#     my $flush_range = sub {
#         if (@range) {
#             pop @items;
#             push( @items, join( '-', $range[0], $range[-1] ) );
#             @range = ();
#         }
#     };

#     for my $item (@$items) {
#         if ( not $last or $last + 1 != $item ) {
#             $flush_range->();
#             push( @items, $item );
#         }
#         else {
#             push( @range, $last, $item );
#         }

#         $last = $item;
#     }
#     $flush_range->();

#     return (wantarray) ? @items : join( ', ', @items );
# }

# sub _as_getter ( $self, $method = undef ) {
#     my ( @refs, @chapters, $last_book );

#     my $flush_chapters = sub {
#         if (@chapters) {
#             my ($book) = @_;
#             push( @refs, "$book " . _compress_range( \@chapters ) );
#             @chapters = ();
#         }
#     };

#     for my $ref ( $self->as_array ) {
#         my $book = $ref->[0];

#         for my $part ( @{ $ref->[1] } ) {
#             my $chapter = $part->[0];

#             if ( $part->[1] ) {
#                 if ( $method eq 'as_verses' ) {
#                     push( @refs, "$book $chapter:$_" ) for ( @{ $part->[1] } );
#                 }
#                 elsif ( $method eq 'as_runs' ) {
#                     push( @refs, "$book $chapter:$_") for ( _compress_range( $part->[1] ) );
#                 }
#                 elsif ( $method eq 'as_chapters' ) {
#                     push( @refs, "$book $chapter:" . _compress_range( $part->[1] ) );
#                 }
#                 elsif ( $method eq 'as_books' )  {
#                     $flush_chapters->($book);

#                     if ( not $last_book or $last_book ne $book ) {
#                         push( @refs, "$book $chapter:" . _compress_range( $part->[1] ) );
#                     }
#                     else {
#                         $refs[-1] .= ", $chapter:" . _compress_range( $part->[1] );
#                     }
#                 }
#             }
#             else {
#                 if ( $method eq 'as_books' ) {
#                     push( @chapters, $chapter );
#                 }
#                 else {
#                     push( @refs, "$book $chapter" );
#                 }
#             }

#             $last_book = $book if ( $method eq 'as_books' );
#         }

#         $flush_chapters->($book) if ( $method eq 'as_books' );
#     }

#     return \@refs;
# }






# TODO: THIS IS WHERE I LAST WORKED
# next step is to rebuild below public methods...








sub as_runs ($self) {
    my $refs = $self->_as_getter('as_runs');
    return (wantarray) ? @$refs : $refs;
}

sub as_chapters ($self) {
    my $refs = $self->_as_getter('as_chapters');
    return (wantarray) ? @$refs : $refs;
}

sub as_books ($self) {
    my $refs = $self->_as_getter('as_books');
    return (wantarray) ? @$refs : $refs;
}

sub refs ($self) {
    return join( '; ', $self->as_books );
}

sub as_text ($self) {
    my @buffer;
    my $flush_buffer = sub {
        if (@buffer) {
            $self->_manual_in_refs( [@buffer] );
            @buffer = ();
            return $self->refs;
        }
        else {
            return undef;
        }
    };

    my @text = map {
        my @nodes;
        for my $node (@$_) {
            unless ( ref $node ) {
                push( @nodes, $flush_buffer->(), $node );
            }
            else {
                push( @buffer, $node );
            }
        }
        push( @nodes, $flush_buffer->() );

        join( '', grep { defined } @nodes );
    } @{ $self->_data };

    return
        ( @text > 1 and wantarray )     ? @text :
        ( @text > 1 and not wantarray ) ? \@text : join( ' ', @text );
}

sub set_bible_data ( $self, $bible = undef, $data = undef ) {
    croak 'First argument to set_bible_data() must be a Bible name string'
        unless ( $bible and not ref $bible and length $bible > 0 );
    croak 'Second argument to set_bible_data() must be an arrayref of arrayrefs'
        unless ( $data and ref $data eq 'ARRAY' );

    for (@$data) {
        croak 'Second argument to set_bible_data() does not appear valid' unless (
            ref $_ eq 'ARRAY' and
            not ref $_->[0] and length $_->[0] > 0 and
            not ref $_->[1] and length $_->[1] > 0
        );
    }

    $self->_bibles->{$bible} = $data;
    $self->bible($bible);
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

    my @books  = $r->books;
    my @sorted = $r->sort( 'Romans', 'James 1:5', 'Romans 5' );

    $r->bible('Vulgate');        # switch to the Vulgate Bible
    $r->acronyms(1);             # output acronyms instead of full book names
    $r->sorting(0);              # deactivate sorting of references
    $r->require_verse_match(1);  # require verses in references for matching
    $r->require_book_ucfirst(1); # require book names to be ucfirst for matching

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

    $r->sorting(1);                   # default
    $r->in('Jam 1:1; Rom 1:1')->refs; # returns "Romans 1:1; James 1:1"

    $r->sorting(0);
    $r->in('Jam 1:1; Rom 1:1')->refs; # returns "James 1:1; Romans 1:1"

Note that within a single given reference, chapters and verses will always be
returned sorted and canonicalized.

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

=head2 as_chapters

This method is the same as C<as_books> except that it returns a list or arrayref
(depending on context) of canonicalized references by book and chapter.

=head2 as_runs

This method is the same as C<as_chapters> except that it returns a list or
arrayref (depending on context) of canonicalized references by verse run. A
"verse run" is a set of verses in an unbroken list together.

    my $books = $r->as_runs;
    # [ 'Romans 12:13-14', 'Romans 12:17', '1 Peter 3:16' ]

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

=head2 set_bible_data

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
internally call C<bible()> to set the new Bible as active.

=head1 HANDLING MATCHING ERRORS

By default, the module does its best to find things that look like valid
references inside text. However, this can result in the occational matching
error. For example, consider the following text input:

    This is an example of the 1 time it might break.
    It also breaks if you mention number 7 from a list of things.
    Legal opinions of judges 3 times said this would break.

With this, we'd falsely match: Thessalonians 1, Numbers 7, and Judges 3.

There are a couple things you can do to reduce this problem. You can optionally
set C<require_verse_match> to a true value. This will cause the matching
algorithm to only work on reference patterns that contain what look to be
verses.

You can optionally set C<require_book_ucfirst> to a true value. This will cause
the matching algorithm to only work on reference patterns that contain what
looks like a book that starts with a capital letter (instead of the default of
any case).

=head1 SEE ALSO

You can look for additional information at:

=for :list
* L<GitHub|https://github.com/gryphonshafer/Bible-Reference>
* L<MetaCPAN|https://metacpan.org/pod/Bible::Reference>
* L<Travis CI|https://travis-ci.org/gryphonshafer/Bible-Reference>
* L<Coveralls|https://coveralls.io/r/gryphonshafer/Bible-Reference>
* L<CPANTS|http://cpants.cpanauthors.org/dist/Bible-Reference>
* L<CPAN Testers|http://www.cpantesters.org/distro/B/Bible-Reference.html>

=for Pod::Coverage BUILD

=cut
