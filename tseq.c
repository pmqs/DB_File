#include <sys/types.h>
#include <sys/file.h>
#include <stdio.h>
#include <db.h>
#include <errno.h>

#define FIL		"bad"
#define	BAD_SIZE	(1024 * 56)
#define	METHOD		DB_HASH

char	buf[100 * 1024];
char	wp[100 * 1024];
char	cp[8192];
main(argc, argv)
char **argv;
{
	DBT item, key, res;
	DB	*dbp;
	int	stat;

	/* Create a hash */
	if (!(dbp = dbopen( FIL, O_RDWR|O_CREAT, 0777, METHOD, NULL))) {
		/* create table */
		fprintf(stderr, "cannot open: hash table\n" );
		exit(1);
	}

	/* write a few records */
	res.data = buf ;
	item.data = buf ;

	res.size = 3 ;
	item.size = 20 ;
	if ((stat = (dbp->put)(dbp, res, item, 0)) != 0) {
		fprintf(stderr, "cannot put: hash table\n" );
		exit(1);
	}

	res.size = 4 ;
	item.size = 55 ;
	if ((stat = (dbp->put)(dbp, res, item, 0)) != 0) {
		fprintf(stderr, "cannot put: hash table\n" );
		exit(1);
	}

	res.size = 5 ;
	item.size = BAD_SIZE ;
	if ((stat = (dbp->put)(dbp, res, item, 0)) != 0) {
		fprintf(stderr, "cannot put: hash table\n" );
		exit(1);
	}

	(dbp->close)(dbp);

	if (!(dbp = dbopen( FIL, O_RDONLY, 0777, METHOD, NULL))) {
		/* create table */
		fprintf(stderr, "cannot open: hash table\n" );
		exit(1);
	}

	printf("using seq\n") ;
/*
* put info in structure, and structure in the item
*/
	for ( stat = (dbp->seq) (dbp, &res, &item, R_FIRST ); 
	      stat == 0;
	      stat = (dbp->seq) (dbp, &res, &item, R_NEXT ) ) {

	      bcopy ( res.data, wp, res.size );
	      wp[res.size] = 0;
	      bcopy ( item.data, cp, item.size );
	      cp[item.size] = 0;

	      printf ( "%d => %d\n", res.size, item.size) ;
	}
	printf("EOF/Error, stat = %d, %d\n", stat, errno) ;

	/* read the record directly */
	printf("\nusing get\n") ;
	res.data = buf ;
	res.size = 5 ;
	item.data = buf ;
	item.size = BAD_SIZE ;
	if ((stat = (dbp->get)(dbp, res, item, 0)) != 0) {
		fprintf(stderr, "cannot get: hash table\n" );
		exit(1);
	}
        printf ( "%d => %d\n", res.size, item.size) ;

	

	(dbp->close)(dbp);
	printf("done\n") ;
	exit(0);
}
