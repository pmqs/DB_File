use GDBM_File;

tie %h, 'GDBM_File', "TestFile", GDBM_WRCREAT, 0640 ;

$h{FRED} = 'Green' ;
$h{JOE}  = 'Yellow' ;
$h{JIM}  = 'Black' ;

untie %h ;

tie %x, 'GDBM_File', "TestFile", GDBM_READER | GDBM_WRITER, 0640 ;

while (($key, $value) = each %x)
  { print "$key => $value\n" }

untie %x ;
