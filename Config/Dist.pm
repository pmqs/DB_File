
package Dist ;

use strict ;
use Config ;
use IO::Pipe ;
use IO::File ;
use ExtUtils::MakeMaker ;

use vars qw( @EXPORT @ISA $fieldn) ;



sub new
{
    my ($pkg) = shift ;
    bless { %Config }, $pkg ;
}

sub writeFile
{
    my ($self) = shift ;
    my ($filename, $string) = @_ ;
    my $fh = new IO::File ">$filename"
    	or die "Cannot open file '$filename': $!\n" ;

    print $fh $string ;
    $fh->close ;

}

sub fieldn
{
    my ($self) = shift ;
    my $pos ;
    my $field ;
    my ($CPP) = "$self->{'cppstdin'}  $self->{'cppminus'} " . 
		"$self->{'cppflags'} 2>/dev/null" ;

    return $fieldn if defined $fieldn ;

    #print "Computing filename position in cpp output for #include directives...\n"; 
    # determine filename position in cpp output
    my $pipe = new IO::Pipe ;
    $pipe->reader("echo '#include <stdio.h>' | $CPP") ;

    LOOP:
    while (<$pipe>) {
	next unless /^\s*#.*stdio\.h/ ;
	$pos = 0 ;
	foreach $field (split) {
	    $field =~ tr/"//d ;
	    last LOOP if -r $field ;
	    ++ $pos ;
	}
	
    }
    $pipe->close ;

    #print "Your cpp writes the filename in field $pos of the line.\n";
    return $pos ;
}


sub findhdr
{
    my ($self) = shift ;
    my ($wanted) = shift ;
    my ($usrinc) = $self->{'usrinc'} ;
    my $name ;
    my $CPP = $self->{'cppstdin'} . " " . $self->{'cppminus'} . " " . 
		$self->{'cppflags'} . "  2>/dev/null" ;

    # First the easy way
    return "$usrinc/$wanted" 
	if -f "$usrinc/$wanted" ;


    my $pipe = new IO::Pipe ;
    my ($fieldn) = $self->fieldn() ;
    $pipe->reader("echo '#include <$wanted>' | $CPP") ;

    while (<$pipe>) {
	next unless /^\s*#.*$wanted/ ;
	#print "findhdr: [$_]" ;
	$name = (split)[$fieldn] ;

	if ($name =~ /$wanted/ ) {
	    $pipe->close ; 
	    $name =~ s/"//g ;
	    return $name ;
	}
    }

    $pipe->close ;

    return undef ;
}


sub compile
{
    my ($self) = shift ;
    my ($file) = shift ;

    print "$self->{'cc'} $self->{'ccflags'} -c $file 2>&1\n" ;
    `$self->{'cc'} $self->{'ccflags'} -c $file 2>&1` ;
}
 
sub compile_and_run
{
    my ($self) = shift ;
    my $string  = shift;
    my $file  = "try" ;
    my $msgs ;
    my $status ;

    $self->writeFile("$file.c", $string) ;
    $msgs = `$self->{'cc'} $self->{'ccflags'} $file.c $self->{'ldflags'} 2>&1` ;
    $status = $? >> 8 ;
    #print "msg = [$msgs] \$?=[$?]\n" ;
    if ($? >>8 == 0)
    {
        $msgs = `a.out` ;
        $status = $? >> 8 ;
    }
    unlink('a.out') if (-f 'a.out');
    unlink (<$file.*>) ;
    return ($status , $msgs) ;
}
 
 

sub BerkeleyDB_hash_type
{
    my ($self) = shift ;
    my $HAS_CONST ;
    my $db_hashtype ;

    $HAS_CONST = "#define HASCONST" if $self->{'d_const'} ;

    # Check the return type needed for hash
    print "\nChecking return type needed for hash for Berkeley DB ...\n" ;

    $self->writeFile ('try.c', <<EOCP) ;
 
$HAS_CONST
#ifndef HASCONST
#define const
#endif
#include <sys/types.h>
#include <db.h>
u_int32_t hash_cb (ptr, size)
const void *ptr;
size_t size;
{
}
HASHINFO info;
main()
{
        info.hash = hash_cb;
}
EOCP
     
    $_ = $self->compile("try.c") ;
    if ($? >> 8 == 0) {
        if (/warning/)
          { $db_hashtype='int' }
        else
          { $db_hashtype='u_int32_t' }
    }
    else {
        print "I can't seem to compile the test program.\n" ;
        $db_hashtype='int' ;
    }
     
    unlink <try.*> ;
     
    print "Your version of Berkeley DB uses $db_hashtype for hash.\n" ;

    return "-DDB_Prefix_t=$db_hashtype" ;

}

sub BerkeleyDB_prefix_type
{
    my ($self) = shift ;
    my $HAS_CONST ;
    my $db_prefixtype ;

    $HAS_CONST = "#define HASCONST" if $self->{'d_const'} ;
    print "\nChecking return type needed for prefix for Berkeley DB ...\n" ;

    $self->writeFile('try.c', <<EOCP) ;
$HAS_CONST
#ifndef HASCONST
#define const
#endif
#include <sys/types.h>
#include <db.h>
size_t prefix_cb (key1, key2)
const DBT *key1;
const DBT *key2;
{
}
BTREEINFO info;
main()
{
        info.prefix = prefix_cb;
}
EOCP
     
    $_ = $self->compile("try.c") ;
    if ($? >> 8 == 0) {
        if (/warning/)
          { $db_prefixtype='int' }
        else
          { $db_prefixtype='size_t' }
    }
    else {
        print "I can't seem to compile the test program.\n" ;
        $db_prefixtype='int' ;
    }
     
    unlink <try.*> ;
    print "Your version of Berkeley DB uses $db_prefixtype for prefix.\n" ;

    return "-DDB_Hash_t=$db_prefixtype" ;
}


sub chkLib
{
    my ($self) = shift ;

    my $x = new ExtUtils::MakeMaker ;
    $x->ext("@_") ;
}


sub ModuleInstalled
{
    my ($self) = shift ;
    my ($module) = shift ;
    my ($module_path) ;
    my (@conflict) ;

    ($module_path = $module) =~ s#::#/#g ;

    foreach (@INC) {
        next if(/site_perl/);
        push (@conflict, $_) if -e "$_/$module_path.pm" ;
    }

    
    
}

1;
