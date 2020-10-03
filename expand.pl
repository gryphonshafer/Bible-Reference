#!/usr/bin/env perl
use Test::Most;
use exact;
use DDP;

sub max_verse ( $book, $chapter ) {
    return 13;
}

sub run {
    my $range = $_[0];

    my $list = sub ( $start, $stop ) {
        $start++ if ( $start == 0 );
        $stop++  if ( $stop == 0 );

        my ( $x,  $y  ) = sort { $a <=> $b } $start, $stop;
        my @list = $x .. $y;
        @list = reverse(@list) if ( $x < $start );

        return @list;
    };

    my $original = sub ( $start, $stop ) {
        my $start_ch = ( $start =~ s/(\d+):// ) ? $1 : 0;
        my $stop_ch  = ( $stop  =~ s/(\d+):// ) ? $1 : 0;

        if ( not $start_ch and not $stop_ch ) {
            return join( ',', $list->( $start, $stop ) );
        }
        elsif ( $start_ch and not $stop_ch ) {
            if ( $stop < $start ) {
                $stop_ch = $stop;
                $stop    = max_verse( 'Test', $stop_ch );
            }

            return join( ',', grep { defined }
                $start_ch . ':' . join( ',', $list->( $start, $stop ) ),
                ( ($stop_ch) ? join( ',', $list->( $start_ch + 1, $stop_ch ) ) : undef ),
            );
        }
        elsif ( not $start_ch and $stop_ch ) {
            $start_ch = $start;
            $start    = 1;

            return join( ',', $list->( $start_ch, $stop_ch ) ) . ':' . join( ',', $list->( $start, $stop ) );
        }
        elsif ( $start_ch and $stop_ch ) {
            return join( ',', grep { defined }
                $start_ch . ':' . join( ',', $list->( $start, max_verse( 'Test', $start_ch ) ) ),
                ( ( $stop_ch - $start_ch > 1 ) ? join( ',', $list->( $start_ch + 1, $stop_ch - 1 ) ) : undef ),
                $stop_ch . ':' . join( ',', $list->( 1, $stop ) ),
            );
        }
    };

    $range =~ s/(\d+(?::\d+)?)\-(\d+(?::\d+)?)/ $original->( $1, $2 ) /ge;
    return $range;
}

is( run('3-7'), '3,4,5,6,7' );
is( run('7-5'), '7,6,5' );
is( run('1-3:3'), '1,2,3:1,2,3' );
is( run('1:10-3'), '1:10,11,12,13,2,3' );
is( run('1:10-3:4'), '1:10,11,12,13,2,3:1,2,3,4' );
is( run('7-5:3'), '7,6,5:1,2,3' );
is( run('4:12-9'), '4:12,13,5,6,7,8,9' );
is( run('4:12-9,6'), '4:12,13,5,6,7,8,9,6' );
is( run('3:23-27'), '3:23,24,25,26,27' );
is( run('3:23-27,4:12-9,6'), '3:23,24,25,26,27,4:12,13,5,6,7,8,9,6' );
is( run('3:23-27,4:12-5:9,6'), '3:23,24,25,26,27,4:12,13,5:1,2,3,4,5,6,7,8,9,6' );

done_testing;
