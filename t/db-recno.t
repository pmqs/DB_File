#!./perl -w

BEGIN {
    @INC = '../lib' if -d '../lib' ;
    require Config; import Config;
    if ($Config{'extensions'} !~ /\bDB_File\b/) {
	print "1..0\n";
	exit 0;
    }
}

use DB_File; 
use Fcntl;
use strict ;
use vars qw($dbh $Dfile) ;

sub ok
{
    my $no = shift ;
    my $result = shift ;

    print "not " unless $result ;
    print "ok $no\n" ;
}

print "1..47\n";

my $Dfile = "recno.tmp";
unlink $Dfile ;

umask(0);

# Check the interface to RECNOINFO

my $dbh = new DB_File::RECNOINFO ;
ok(1, $dbh->{bval} == 0 ) ;
ok(2, $dbh->{cachesize} == 0) ;
ok(3, $dbh->{psize} == 0) ;
ok(4, $dbh->{flags} == 0) ;
ok(5, $dbh->{lorder} == 0);
ok(6, $dbh->{reclen} == 0);
ok(7, $dbh->{bfname} eq "");

$dbh->{bval} = 3000 ;
ok(8, $dbh->{bval} == 3000 );

$dbh->{cachesize} = 9000 ;
ok(9, $dbh->{cachesize} == 9000 );

$dbh->{psize} = 400 ;
ok(10, $dbh->{psize} == 400 );

$dbh->{flags} = 65 ;
ok(11, $dbh->{flags} == 65 );

$dbh->{lorder} = 123 ;
ok(12, $dbh->{lorder} == 123 );

$dbh->{reclen} = 1234 ;
ok(13, $dbh->{reclen} == 1234 );

$dbh->{bfname} = 1234 ;
ok(14, $dbh->{bfname} == 1234 );


# Check that an invalid entry is caught both for store & fetch
eval '$dbh->{fred} = 1234' ;
ok(15, $@ =~ /^DB_File::RECNOINFO::STORE - Unknown element 'fred' at/ );
eval 'my $q = $dbh->{fred}' ;
ok(16, $@ =~ /^DB_File::RECNOINFO::FETCH - Unknown element 'fred' at/ );

# Now check the interface to RECNOINFO

my $X  ;
my @h ;
ok(17, $X = tie @h, 'DB_File', $Dfile, O_RDWR|O_CREAT, 0640, $DB_RECNO ) ;

ok(18, ( (stat($Dfile))[2] & 0777) == ($^O eq 'os2' ? 0666 : 0640)) ;

#my $l = @h ;
my $l = $X->length ;
ok(19, !$l );

my @data = qw( a b c d ever f g h  i j k longername m n o p) ;

$h[0] = shift @data ;
ok(20, $h[0] eq 'a' );

my $ i;
foreach (@data)
  { $h[++$i] = $_ }

unshift (@data, 'a') ;

ok(21, defined $h[1] );
ok(22, ! defined $h[16] );
ok(23, $X->length == @data );


# Overwrite an entry & check fetch it
$h[3] = 'replaced' ;
$data[3] = 'replaced' ;
ok(24, $h[3] eq 'replaced' );

#PUSH
my @push_data = qw(added to the end) ;
#my push (@h, @push_data) ;
$X->push(@push_data) ;
push (@data, @push_data) ;
ok(25, $h[++$i] eq 'added' );
ok(26, $h[++$i] eq 'to' );
ok(27, $h[++$i] eq 'the' );
ok(28, $h[++$i] eq 'end' );

# POP
my $popped = pop (@data) ;
#my $value = pop(@h) ;
my $value = $X->pop ;
ok(29, $value eq $popped) ;

# SHIFT
#$value = shift @h
$value = $X->shift ;
my $shifted = shift @data ;
ok(30, $value eq $shifted );

# UNSHIFT

# empty list
$X->unshift ;
ok(31, $X->length == @data );

my @new_data = qw(add this to the start of the array) ;
#unshift @h, @new_data ;
$X->unshift (@new_data) ;
unshift (@data, @new_data) ;
ok(32, $X->length == @data );
ok(33, $h[0] eq "add") ;
ok(34, $h[1] eq "this") ;
ok(35, $h[2] eq "to") ;
ok(36, $h[3] eq "the") ;
ok(37, $h[4] eq "start") ;
ok(38, $h[5] eq "of") ;
ok(39, $h[6] eq "the") ;
ok(40, $h[7] eq "array") ;
ok(41, $h[8] eq $data[8]) ;

# SPLICE

# Now both arrays should be identical

my $ok = 1 ;
my $j = 0 ;
foreach (@data)
{
   $ok = 0, last if $_ ne $h[$j ++] ; 
}
ok(42, $ok );

# Neagtive subscripts

# get the last element of the array
ok(43, $h[-1] eq $data[-1] );
ok(44, $h[-1] eq $h[$X->length -1] );

# get the first element using a negative subscript
eval '$h[ - ( $X->length)] = "abcd"' ;
ok(45, $@ eq "" );
ok(46, $h[0] eq "abcd" );

# now try to read before the start of the array
eval '$h[ - (1 + $X->length)] = 1234' ;
ok(47, $@ =~ '^Modification of non-creatable array value attempted' );

# IMPORTANT - $X must be undefined before the untie otherwise the
#             underlying DB close routine will not get called.
undef $X ;
untie(@h);

unlink $Dfile;

exit ;
