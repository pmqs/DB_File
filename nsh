#!/usr/bin/perl
    use DB_File;
    use Fcntl;
    $file = shift || 'history';
    #chdir  || die;
    #chdir '.netscape' || die;
    $hashed = "$file.db";
    die "no $hashed" unless -e "$hashed";
    tie %db, "DB_File", $hashed, O_RDONLY, 0, $DB_HASH;
    #$| = 1;
    $i = 1 ;
    #while  ( ($k, $v) = each %db) {
    foreach  ( keys %db) {
    #for ($k = 0; $k < 2000 ; ++ $k) {
	$k = $_ ;
	
    	#chop $k;
    	#$n = unpack("V", $v);
    	#printf "$k $n %08X %s\n", $n, scalar localtime $n, "\n";
    	printf "$i: $k\n" ;
    	++ $i ;
    } 
    
    untie %db ;
