
#define BTREE_CALLBACKS	3

static int  btree_fn0 _((const DBT * key1, const DBT * key2)) ;
static int  btree_fn1 _((const DBT * key1, const DBT * key2)) ;
static int  btree_fn2 _((const DBT * key1, const DBT * key2)) ;

static CallBackInfo btree_callbacks [BTREE_CALLBACKS] =
    {
        { btree_fn0, NULL},
        { btree_fn1, NULL},
        { btree_fn2, NULL},
    } ;


static int
btree_fn0(key1, key2)
const DBT * key1 ;
const DBT * key2 ;
{
    return (btree_compare(0, key1, key2)) ;
}

static int
btree_fn1(key1, key2)
const DBT * key1 ;
const DBT * key2 ;
{
    return (btree_compare(1, key1, key2)) ;
}

static int
btree_fn2(key1, key2)
const DBT * key1 ;
const DBT * key2 ;
{
    return (btree_compare(2, key1, key2)) ;
}
