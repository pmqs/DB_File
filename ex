
    package Demo;

    $SIG{__DIE__} = sub { warn "__DIE__ [ @_]\n" } ;

    sub new { bless {}}
    sub DESTROY { print "in DESTR\n" ; die "fuz\n" }
    package main;
    $a = Demo->new() ;


