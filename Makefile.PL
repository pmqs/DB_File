use ExtUtils::MakeMaker 5.16 ;
use Config ;


@Options = qw( INCLUDE LIB PREFIX HASH ) ;
%ValidOption = map {$_, 1} @Options ;
%Parsed = %ValidOption ;
ParseCONFIG() ;

# OS2 is a special case, so check for it now.
my $OS2 = "-DOS2" if $Config{'osname'} eq 'os2' ;

WriteMakefile(
	NAME 		=> 'DB_File',
	LIBS 		=> ["-L${LIB_DIR} -ldb"],
        MAN3PODS        => ' ',         # Pods will be built by installman.
	INC		=> "-I$INC_DIR",
	VERSION_FROM	=> 'DB_File.pm',
	XSPROTOARG	=> '-noprototypes',
	DEFINE		=> "$OS2 $VER_INFO",
	'macro'		=> { INSTALLDIRS => 'perl' },
        'dist'          => {COMPRESS=>'gzip', SUFFIX=>'gz'},    
	);



sub ParseCONFIG
{
    my @badkey = () ;

    print "Parsing CONFIG\n" ;

    open(F, "CONFIG") or die "Cannot open file CONFIG: $!\n" ;
    while (<F>) {
	s/^\s*|\s*$//g ;
	next if /^\s*$/ or /^\s*#/ ;
	s/\s*#\s*$// ;

	($k, $v) = split(/\s+=\s+/, $_, 2) ;
	$k = uc $k ;
	if ($ValidOption{$k}) {
	    delete $Parsed{$k} ;
	    $Info{$k} = $v ;
	}
	else {
	    push(@badkey, $k) ;
	}
    }
    close F ;

    print "Unknown keys in CONFIG ignored [@badkey]\n"
	if @badkey ;

    # check parsed values
    my @missing = () ;
    die "keys missing from CONFIG [@missing]\n" 
        if @missing = keys %Parsed ;

    $INC_DIR = $Info{'INCLUDE'} ;
    $LIB_DIR = $Info{'LIB'} ;
    $PREFIX  = $Info{'PREFIX'} ;
    $HASH    = $Info{'HASH'} ;

    $VER_INFO = "-DmDB_Prefix_t=${PREFIX} -DmDB_Hash_t=${HASH}" ;

    print <<EOM if 0 ;
INCLUDE	[$INC_DIR]
LIB	[$LIB_DIR]
HASH	[$HASH]
PREFIX	[$PREFIX]
EOM
}

# end of file Makefile.PL
