
package DBM0 ;

require 5.003 ;

use vars qw( @ISA $UseDB ) ;

use Carp ;
require Exporter ;
use DB_File ;
@ISA = qw( DB_File) ;

$UseDB = "DB_File" ;

sub TIEHASH
{
print "TIEHASH\n" ;
    my $pkg = shift ;

    bless $UseDB->TIEHASH( @_), $pkg ;
}

sub STORE
{
    print "DBM0::STORE\n" ;
    my $self = shift ;
    $self->SUPER::STORE ;
}

sub FETCH
{
    print "DBM0::FETCH\n" ;
    my $self = shift ;

    $self->SUPER::FETCH ;
}

sub DELETE
{
    my $self = shift ;
    $self->SUPER::DELETE ;
}

sub FIRSTKEY
{
    my $self = shift ;
    $self->SUPER::FIRSTKEY ;
}

sub NEXTKEY
{
    my $self = shift ;
    $self->SUPER::NEXTKEY ;
}


#sub import
#{
#    my $pkg = shift ;
#    my $dbm = shift ;
#    my $UseDB = "DB_File" ;
#
#    $UseDB = $dbm if $dbm ;
#
#print "evaling [use $UseDB]\n" ;
#    eval " use $UseDB ;" ;
#    if ($@) {
#	croak "problems with import $@\n" ;
#    }
#    unshift(@ISA, $UseDB) ;
#    
#}
#
1 ;

