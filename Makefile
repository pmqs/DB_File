# This Makefile is for the DB_File extension to perl.
#
# It was generated automatically by MakeMaker version 5.00 from the contents
# of Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#	ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker Parameters:

#	LIBS => ['-L/usr/local/lib -ldb']
#	NAME => 'DB_File'
#	VERSION => '1.001'

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/local/lib/perl5/sun4-sunos/Config.pm)
CC = cc
LIBC = /usr/lib/libc.so.1.8
LDFLAGS =  -L/usr/local/lib
LDDLFLAGS = -assert nodefinitions -L/usr/local/lib
CCDLFLAGS =  
CCCDLFLAGS = -pic
RANLIB = /usr/bin/ranlib
SO = so
DLEXT = so
DLSRC = dl_dlopen.xs


# --- MakeMaker constants section:

NAME = DB_File
DISTNAME = DB_File
NAME_SYM = DB_File
VERSION = 1.001
VERSION_SYM = 1_001
VERSION_MACRO = VERSION
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"

# In which directory should we put this extension during 'make'?
# This is typically ./blib.
# (also see INST_LIBDIR and relationship to ROOTEXT)
INST_LIB = ./blib
INST_ARCHLIB = ./blib/sun4-sunos
INST_EXE = ./blib/sun4-sunos

# AFS users will want to set the installation directories for
# the final 'make install' early without setting INST_LIB,
# INST_ARCHLIB, and INST_EXE for the testing phase
INSTALLPRIVLIB = /usr/local/lib/perl5
INSTALLARCHLIB = /usr/local/lib/perl5/sun4-sunos
INSTALLBIN = /usr/local/bin

# Perl library to use when building the extension
PERL_LIB = /usr/local/lib/perl5
PERL_ARCHLIB = /usr/local/lib/perl5/sun4-sunos
LIBPERL_A = libperl.a

MAKEMAKER = $(PERL_LIB)/ExtUtils/MakeMaker.pm
MM_VERSION = 5.00

OBJ_EXT = o
LIB_EXT = a
AR = ar

# Perl header files (will eventually be under PERL_LIB)
PERL_INC = /usr/local/lib/perl5/sun4-sunos/CORE
# Perl binaries
PERL = /usr/local/bin/perl
FULLPERL = /usr/local/bin/perl

# FULLEXT = Pathname for extension directory (eg DBD/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT.
# ROOTEXT = Directory part of FULLEXT with leading slash (eg /DBD)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
FULLEXT = DB_File
BASEEXT = DB_File
ROOTEXT = 
DLBASE  = $(BASEEXT)

INC = 
DEFINE = 
OBJECT = $(BASEEXT).$(OBJ_EXT)
LDFROM = $(OBJECT)
LINKTYPE = dynamic

# Handy lists of source code files:
XS_FILES= DB_File.xs
C_FILES = DB_File.c
O_FILES = DB_File.o
H_FILES = btree.h
MANPODS = DB_File.pm \
	perlcall.pod

# Man installation stuff:
INST_MAN1DIR	= ./blib/man/man1
INSTALLMAN1DIR	= /usr/local/man/man1
MAN1EXT	= 1

INST_MAN3DIR	= ./blib/man/man3
INSTALLMAN3DIR	= /usr/local/lib/perl5/man/man3
MAN3EXT	= 3


# work around a famous dec-osf make(1) feature(?):
makemakerdflt: all

.SUFFIXES: .xs .c .$(OBJ_EXT)

.PRECIOUS: Makefile

.PHONY: all config static dynamic test linkext

# This extension may link to it's own library (see SDBM_File)
MYEXTLIB = 

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)/Config.pm $(PERL_INC)/config.h

# Where to put things:
INST_LIBDIR     = $(INST_LIB)$(ROOTEXT)
INST_ARCHLIBDIR = $(INST_ARCHLIB)$(ROOTEXT)

INST_AUTODIR      = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR  = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC  = $(INST_ARCHAUTODIR)/$(BASEEXT).$(LIB_EXT)
INST_DYNAMIC = $(INST_ARCHAUTODIR)/$(DLBASE).$(DLEXT)
INST_BOOT    = $(INST_ARCHAUTODIR)/$(BASEEXT).bs

EXPORT_LIST = 

PERL_ARCHIVE = 

INST_PM = $(INST_LIBDIR)/DB_File.pm \
	$(INST_LIBDIR)/perlcall.pod


# --- MakeMaker const_loadlibs section:

# DB_File might depend on some other libraries:
# (These comments may need revising:)
#
# Dependent libraries can be linked in one of three ways:
#
#  1.  (For static extensions) by the ld command when the perl binary
#      is linked with the extension library. See EXTRALIBS below.
#
#  2.  (For dynamic extensions) by the ld command when the shared
#      object is built/linked. See LDLOADLIBS below.
#
#  3.  (For dynamic extensions) by the DynaLoader when the shared
#      object is loaded. See BSLOADLIBS below.
#
# EXTRALIBS =	List of libraries that need to be linked with when
#		linking a perl binary which includes this extension
#		Only those libraries that actually exist are included.
#		These are written to a file and used when linking perl.
#
# LDLOADLIBS =	List of those libraries which can or must be linked into
#		the shared library when created using ld. These may be
#		static or dynamic libraries.
#		LD_RUN_PATH is a colon separated list of the directories
#		in LDLOADLIBS. It is passed as an environment variable to
#		the process that links the shared library.
#
# BSLOADLIBS =	List of those libraries that are needed but can be
#		linked in dynamically at run time on this platform.
#		SunOS/Solaris does not need this because ld records
#		the information (from LDLOADLIBS) into the object file.
#		This list is used to create a .bs (bootstrap) file.
#
EXTRALIBS  = -L/usr/local/lib
LDLOADLIBS = -L/usr/local/lib -ldb
BSLOADLIBS = 
LD_RUN_PATH= /usr/local/lib:-ldb


# --- MakeMaker const_cccmd section:
CCCMD = $(CC) -c -I/usr/local/include -O $(DEFINE_VERSION)


# --- MakeMaker tool_autosplit section:

# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(PERL) "-I$(PERL_ARCHLIB)" "-I$(PERL_LIB)" -e 'use AutoSplit;autosplit($$ARGV[0], $$ARGV[1], 0, 1, 1) ;'


# --- MakeMaker tool_xsubpp section:

XSUBPPDIR = $(PERL_LIB)/ExtUtils
XSUBPP = $(XSUBPPDIR)/xsubpp
XSUBPPDEPS = $(XSUBPPDIR)/typemap typemap
XSUBPPARGS = -typemap $(XSUBPPDIR)/typemap -typemap typemap


# --- MakeMaker tools_other section:

SHELL = /bin/sh
LD = ld
TOUCH = touch
CP = cp
MV = mv
RM_F  = rm -f
RM_RF = rm -rf
CHMOD = chmod
UMASK_NULL = umask 0

# The following is a portable way to say mkdir -p
# To see which directories are created, change the if 0 to if 1
MKPATH = $(PERL) -wle '$$"="/"; foreach $$p (@ARGV){' \
-e 'next if -d $$p; my(@p); foreach(split(/\//,$$p)){' \
-e 'push(@p,$$_); next if -d "@p/"; print "mkdir @p" if 0;' \
-e 'mkdir("@p",0777)||die $$! } } exit 0;'


# --- MakeMaker dist section:

DISTVNAME = $(DISTNAME)-$(VERSION)
TAR  = tar
TARFLAGS = cvf
COMPRESS = compress
SUFFIX = Z
SHAR = shar
PREOP = @ true
POSTOP = @ true
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = cp
DIST_DEFAULT = tardist


# --- MakeMaker macro section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = INSTALLPRIVLIB="$(INSTALLPRIVLIB)"\
	INSTALLARCHLIB="$(INSTALLARCHLIB)"\
	INSTALLBIN="$(INSTALLBIN)"\
	INSTALLMAN1DIR="$(INSTALLMAN1DIR)"\
	INSTALLMAN3DIR="$(INSTALLMAN3DIR)"\
	LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"


# --- MakeMaker c_o section:

.c.$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) -I$(PERL_INC) $(DEFINE) $(INC) $*.c


# --- MakeMaker xs_c section:

.xs.c:
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) $(XSUBPP) $(XSUBPPARGS) $*.xs >$*.tc && mv $*.tc $@


# --- MakeMaker xs_o section:

.xs.$(OBJ_EXT):
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) $(XSUBPP) $(XSUBPPARGS) $*.xs >xstmp.c && mv xstmp.c $*.c
	$(CCCMD) $(CCCDLFLAGS) -I$(PERL_INC) $(DEFINE) $(INC) $*.c


# --- MakeMaker top_targets section:

all ::	config $(INST_PM) subdirs linkext manifypods

subdirs :: $(MYEXTLIB)



config :: Makefile $(INST_LIBDIR)/.exists

config :: $(INST_ARCHAUTODIR)/.exists Version_check

config :: $(INST_AUTODIR)/.exists

config :: $(INST_MAN1DIR)/.exists

config :: $(INST_MAN3DIR)/.exists

$(INST_AUTODIR)/.exists :: $(PERL)
	@ $(MKPATH) $(INST_AUTODIR)
	@ $(TOUCH) $(INST_AUTODIR)/.exists
	@-$(CHMOD) 755 $(INST_AUTODIR)

$(INST_LIBDIR)/.exists :: $(PERL)
	@ $(MKPATH) $(INST_LIBDIR)
	@ $(TOUCH) $(INST_LIBDIR)/.exists
	@-$(CHMOD) 755 $(INST_LIBDIR)

$(INST_ARCHAUTODIR)/.exists :: $(PERL)
	@ $(MKPATH) $(INST_ARCHAUTODIR)
	@ $(TOUCH) $(INST_ARCHAUTODIR)/.exists
	@-$(CHMOD) 755 $(INST_ARCHAUTODIR)

$(INST_MAN1DIR)/.exists :: $(PERL)
	@ $(MKPATH) $(INST_MAN1DIR)
	@ $(TOUCH) $(INST_MAN1DIR)/.exists
	@-$(CHMOD) 755 $(INST_MAN1DIR)

$(INST_MAN3DIR)/.exists :: $(PERL)
	@ $(MKPATH) $(INST_MAN3DIR)
	@ $(TOUCH) $(INST_MAN3DIR)/.exists
	@-$(CHMOD) 755 $(INST_MAN3DIR)

$(O_FILES): $(H_FILES)

help:
	perldoc ExtUtils::MakeMaker

Version_check:
	@$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) \
		-e 'use ExtUtils::MakeMaker qw($$Version &Version_check);' \
		-e '&Version_check($(MM_VERSION))'


# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)



# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic section:

# $(INST_PM) has been moved to the all: target.
# It remains here for awhile to allow for old usage: "make dynamic"
dynamic :: Makefile $(INST_DYNAMIC) $(INST_BOOT) $(INST_PM)



# --- MakeMaker dynamic_bs section:

BOOTSTRAP = DB_File.bs

# As Mkbootstrap might not write a file (if none is required)
# we use touch to prevent make continually trying to remake it.
# The DynaLoader only reads a non-empty file.
$(BOOTSTRAP): Makefile DB_File_BS
	@ echo "Running Mkbootstrap for $(NAME) ($(BSLOADLIBS))"
	@ $(PERL) "-I$(PERL_ARCHLIB)" "-I$(PERL_LIB)" \
		-e 'use ExtUtils::Mkbootstrap;' \
		-e 'Mkbootstrap("$(BASEEXT)","$(BSLOADLIBS)");'
	@ $(TOUCH) $(BOOTSTRAP)
	$(CHMOD) 644 $@
	@echo $@ >> $(INST_ARCHAUTODIR)/.packlist

$(INST_BOOT): $(BOOTSTRAP)
	@ rm -rf $(INST_BOOT)
	-cp $(BOOTSTRAP) $(INST_BOOT)
	$(CHMOD) 644 $@
	@echo $@ >> $(INST_ARCHAUTODIR)/.packlist


# --- MakeMaker dynamic_lib section:

# This section creates the dynamically loadable $(INST_DYNAMIC)
# from $(OBJECT) and possibly $(MYEXTLIB).
ARMAYBE = :
OTHERLDFLAGS = 

$(INST_DYNAMIC): $(OBJECT) $(MYEXTLIB) $(BOOTSTRAP) $(INST_ARCHAUTODIR)/.exists $(EXPORT_LIST) $(PERL_ARCHIVE)
	LD_RUN_PATH="$(LD_RUN_PATH)" $(LD) -o $@ $(LDDLFLAGS) $(LDFROM) $(OTHERLDFLAGS) $(MYEXTLIB) $(LDLOADLIBS) $(EXPORT_LIST) $(PERL_ARCHIVE)
	$(CHMOD) 755 $@
	@echo $@ >> $(INST_ARCHAUTODIR)/.packlist


# --- MakeMaker static section:

# $(INST_PM) has been moved to the all: target.
# It remains here for awhile to allow for old usage: "make static"
static :: Makefile $(INST_STATIC) $(INST_PM)



# --- MakeMaker static_lib section:

$(INST_STATIC): $(OBJECT) $(MYEXTLIB) $(INST_ARCHAUTODIR)/.exists
	$(AR) cr $@ $(OBJECT) && $(RANLIB) $@
	@echo "$(EXTRALIBS)" > $(INST_ARCHAUTODIR)/extralibs.ld
	$(CHMOD) 755 $@
	@echo $@ >> $(INST_ARCHAUTODIR)/.packlist


# --- MakeMaker installpm section:
inst_pm :: $(INST_PM)


# installpm: DB_File.pm => $(INST_LIBDIR)/DB_File.pm, splitlib=$(INST_LIB)

$(INST_LIBDIR)/DB_File.pm: DB_File.pm Makefile $(INST_LIBDIR)/.exists
	@ rm -f $@
	$(UMASK_NULL) && cp DB_File.pm $@
	@ echo $@ >> $(INST_ARCHAUTODIR)/.packlist
	@$(AUTOSPLITFILE) $@ $(INST_LIB)/auto


# installpm: perlcall.pod => $(INST_LIBDIR)/perlcall.pod, splitlib=$(INST_LIB)

$(INST_LIBDIR)/perlcall.pod: perlcall.pod Makefile $(INST_LIBDIR)/.exists
	@ rm -f $@
	$(UMASK_NULL) && cp perlcall.pod $@
	@ echo $@ >> $(INST_ARCHAUTODIR)/.packlist



# --- MakeMaker manifypods section:
POD2MAN = $(PERL) -we '%m=@ARGV;for (keys %m){' \
-e 'next if -e $$m{$$_} && -M $$m{$$_} < -M "Makefile";' \
-e 'print "Installing $$m{$$_}\n";' \
-e 'system("pod2man $$_>$$m{$$_}")==0 or warn "Couldn\047t install $$m{$$_}\n";' \
-e 'chmod 0644, $$m{$$_} or warn "chmod 644 $$m{$$_}: $$!\n";}'

manifypods :
	@$(POD2MAN) \	DB_File.pm \
	$(INST_MAN3DIR)/DB_File.$(MAN3EXT) \
	perlcall.pod \
	$(INST_MAN3DIR)/perlcall.$(MAN3EXT)

# --- MakeMaker processPL section:


# --- MakeMaker installbin section:


# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean ::
	-rm -rf DB_File.c ./blib Makeaperlfile $(INST_ARCHAUTODIR)/extralibs.all perlmain.c mon.out core so_locations *~ */*~ */*/*~ *.$(OBJ_EXT) *.$(LIB_EXT) perl.exe $(BOOTSTRAP) $(BASEEXT).bso $(BASEEXT).def $(BASEEXT).exp
	-mv Makefile Makefile.old 2>/dev/null


# --- MakeMaker realclean section:

# Delete temporary files (via clean) and also delete installed files
realclean purge ::  clean
	rm -rf $(INST_AUTODIR) $(INST_ARCHAUTODIR)
	rm -f $(INST_DYNAMIC) $(INST_BOOT)
	rm -f $(INST_STATIC) $(INST_PM)
	rm -rf Makefile Makefile.old


# --- MakeMaker dist_basics section:

distclean :: realclean distcheck

distcheck :
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -e 'use ExtUtils::Manifest "&fullcheck";' \
		-e 'fullcheck();'

manifest :
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -e 'use ExtUtils::Manifest "&mkmanifest";' \
		-e 'mkmanifest();'


# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT)

tardist : $(DISTVNAME).tar.$(SUFFIX)

$(DISTVNAME).tar.$(SUFFIX) : distdir
	$(PREOP)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(POSTOP)

uutardist : $(DISTVNAME).tar.$(SUFFIX)
	uuencode $(DISTVNAME).tar.$(SUFFIX) \
		$(DISTVNAME).tar.$(SUFFIX) > \
		$(DISTVNAME).tar.$(SUFFIX).uu

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)


# --- MakeMaker dist_dir section:

distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -e 'use ExtUtils::Manifest "/mani/";' \
		-e 'manicopy(maniread(),"$(DISTVNAME)", "$(DIST_CP)");'


# --- MakeMaker dist_test section:

disttest : distdir
	cd $(DISTVNAME) && $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) Makefile.PL
	cd $(DISTVNAME) && $(MAKE)
	cd $(DISTVNAME) && $(MAKE) test


# --- MakeMaker dist_ci section:

ci :
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -e 'use ExtUtils::Manifest "&maniread";' \
		-e '@all = keys %{ maniread() };' \
		-e 'print("Executing $(CI) @all\n"); system("$(CI) @all");' \
		-e 'print("Executing $(RCS_LABEL) ...\n"); system("$(RCS_LABEL) @all");'


# --- MakeMaker install section:

doc_install ::
	@ echo Appending installation info to $(INSTALLARCHLIB)/perllocal.pod
	@ $(PERL) -I$(INST_ARCHLIB) -I$(INST_LIB) -I$(PERL_ARCHLIB) -I$(PERL_LIB)  \
		-e "use ExtUtils::MakeMaker; MY->new({})->writedoc('Module', '$(NAME)', \
		'LINKTYPE=$(LINKTYPE)', 'VERSION=$(VERSION)', \
		'EXE_FILES=$(EXE_FILES)')" >> $(INSTALLARCHLIB)/perllocal.pod

install :: pure_install doc_install

pure_install ::
	@$(PERL) "-I$(PERL_ARCHLIB)" "-I$(PERL_LIB)" -e 'require File::Path;' \
	-e '$$message = q[ You do not have permissions to install into];' \
	-e 'File::Path::mkpath(@ARGV);' \
	-e 'foreach (@ARGV){ die qq{ $$message $$_\n} unless -w $$_}' \
	    $(INSTALLPRIVLIB) $(INSTALLARCHLIB)
	$(MAKE) INST_LIB=$(INSTALLPRIVLIB) INST_ARCHLIB=$(INSTALLARCHLIB) INST_EXE=$(INSTALLBIN) INST_MAN1DIR=$(INSTALLMAN1DIR) INST_MAN3DIR=$(INSTALLMAN3DIR) all
	@$(PERL) -i.bak -lne 'print unless $$seen{ $$_ }++' $(INSTALLARCHLIB)/auto/$(FULLEXT)/.packlist

#### UNINSTALL IS STILL EXPERIMENTAL ####
uninstall ::
	$(RM_RF) `cat $(INSTALLARCHLIB)/auto/$(FULLEXT)/.packlist`


# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE:


# --- MakeMaker perldepend section:

PERL_HDRS = $(PERL_INC)/EXTERN.h $(PERL_INC)/INTERN.h \
    $(PERL_INC)/XSUB.h	$(PERL_INC)/av.h	$(PERL_INC)/cop.h \
    $(PERL_INC)/cv.h	$(PERL_INC)/dosish.h	$(PERL_INC)/embed.h \
    $(PERL_INC)/form.h	$(PERL_INC)/gv.h	$(PERL_INC)/handy.h \
    $(PERL_INC)/hv.h	$(PERL_INC)/keywords.h	$(PERL_INC)/mg.h \
    $(PERL_INC)/op.h	$(PERL_INC)/opcode.h	$(PERL_INC)/patchlevel.h \
    $(PERL_INC)/perl.h	$(PERL_INC)/perly.h	$(PERL_INC)/pp.h \
    $(PERL_INC)/proto.h	$(PERL_INC)/regcomp.h	$(PERL_INC)/regexp.h \
    $(PERL_INC)/scope.h	$(PERL_INC)/sv.h	$(PERL_INC)/unixish.h \
    $(PERL_INC)/util.h	$(PERL_INC)/config.h



$(OBJECT) : $(PERL_HDRS)

DB_File.c : $(XSUBPPDEPS)


# --- MakeMaker makefile section:

$(OBJECT) : Makefile

# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
Makefile :	Makefile.PL $(CONFIGDEP)
	@echo "Makefile out-of-date with respect to $?"
	@echo "Cleaning current config before rebuilding Makefile..."
	-@mv Makefile Makefile.old
	-$(MAKE) -f Makefile.old clean >/dev/null 2>&1 || true
	$(PERL) "-I$(PERL_ARCHLIB)" "-I$(PERL_LIB)" Makefile.PL 
	@echo ">>> Your Makefile has been rebuilt. <<<"
	@echo ">>> Please rerun the make command.  <<<"; false


# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /usr/local/bin/perl

$(MAP_TARGET) ::
	$(MAKE) LINKTYPE=static all
	$(PERL) Makefile.PL MAKEFILE=Makefile.aperl LINKTYPE=static MAKEAPERL=1 NORECURS=1
	$(MAKE) -f Makefile.aperl $(MAP_TARGET)


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)

test :: $(TEST_TYPE)

test_dynamic :: all
	PERL_DL_NONLAZY=1 $(FULLPERL) -I$(INST_ARCHLIB) -I$(INST_LIB) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -e 'use Test::Harness qw(&runtests $$verbose); $$verbose=$(TEST_VERBOSE); runtests @ARGV;' t/*.t

test_ : test_dynamic

test_static :: all $(MAP_TARGET)
	PERL_DL_NONLAZY=1 ./$(MAP_TARGET) -I$(INST_ARCHLIB) -I$(INST_LIB) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -e 'use Test::Harness qw(&runtests $$verbose); $$verbose=$(TEST_VERBOSE); runtests @ARGV;' t/*.t



# --- MakeMaker postamble section:


# --- MakeMaker selfdocument section:


# End.
