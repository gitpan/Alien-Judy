package Alien::Judy;

use strict;

use vars qw( @EXPORT_OK %EXPORT_TAGS $VERSION @ISA );

use Config ();
use Cwd ();
use File::Spec ();

sub unique {
    my %seen;
    return
        grep { ! $seen{$_}++ }
        @_;
}

sub inc_dirs {
    return
        grep { defined() && length() && -d }
        unique(
            Cwd::getcwd(),
            map { File::Spec->catdir( $_, 'include' ) }
            grep { defined() && length() }
            @Config::Config{qw( siteprefixexp prefixexp )}
        );
}

sub lib_dirs {
    return
        grep { defined() && length() && -d }
        unique(
            map { File::Spec->catdir( $_, 'Alien', 'Judy' ) }
            grep { defined() && length() }
            @Config::Config{qw(sitearchexp sitearch)}
        );
}

$VERSION = '0.11';

1;
