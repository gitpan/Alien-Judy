package Alien::Judy;

use strict;

use vars qw( @EXPORT_OK %EXPORT_TAGS $VERSION @ISA );

use Config ();
use Cwd ();
use File::Spec ();

use Exporter ();
@ISA = 'Exporter';

@EXPORT_OK = qw( inc_dirs lib_dirs );
%EXPORT_TAGS = (
    all => \ @EXPORT_OK,
);

sub unique {
    my %seen;
    return
        grep { ! $seen{$_}++ }
        @_;
}

sub inc_dirs {
    return
        unique(
            Cwd::getcwd(),
            map { File::Spec->catdir( $_, 'Alien', 'Judy' ) }
            grep { defined() && length() }
            @Config::Config{qw(sitearchexp sitearch)},
            @INC
        );
}

*lib_dirs = \&inc_dirs;

$VERSION = '0.17';

1;
