#	$OpenBSD: Makefile,v 1.7 2004/07/04 11:01:49 alexander Exp $
#	$Id: Makefile.in,v 1.34 2006/01/19 07:16:44 dtucker Exp $

prefix=
exec_prefix=${prefix}
bindir=${exec_prefix}/bin
sbindir=${exec_prefix}/sbin
libexecdir=${exec_prefix}/libexec
datadir=${prefix}/share
mandir=${prefix}/man
mansubdir=man
sysconfdir=${prefix}/etc
srcdir=.
top_srcdir=.

DESTDIR=

CC=mipsel-uclibc-gcc
CFLAGS=-g -O2 -Wall -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wshadow -Wpointer-arith -Wcast-qual -Wsign-compare -D_GNU_SOURCE
CPPFLAGS=-I. -I$(srcdir) -I/usr/local/ssl/include  $(PATHS)
LIBS=	
LDFLAGS=-L/usr/local/ssl/lib 
AWK=	gawk
YACC=	bison -y

INSTALL=/usr/bin/install -c

PATHS= -DSYSCONFDIR=\"$(sysconfdir)\"
PRIVSEP_USER=root
PRIVSEP_PATH=/var/empty
STRIP_OPT=-s

PROG=	ntpd
LIBCOMPAT=openbsd-compat/libopenbsd-compat.a
SRCS=	ntpd.c buffer.c log.c imsg.c ntp.c ntp_msg.c config.c \
	server.c client.c util.c y.tab.c
OBJS=	ntpd.o buffer.o log.o imsg.o ntp.o ntp_msg.o config.o \
	server.o client.o util.o y.tab.o
YFLAGS=
MANPAGES_IN=	ntpd.8 ntpd.conf.5
MANPAGES=	ntpd.8.out ntpd.conf.5.out
MANTYPE=	doc

all:	ntpd $(MANPAGES)

$(LIBCOMPAT):	config.h  $(top_srcdir)/openbsd-compat/*.c \
	    $(top_srcdir)/openbsd-compat/*.h
	(cd openbsd-compat && $(MAKE))

$(OBJS):	config.h

PATHSUBS	= -e 's|/etc/ntpd.conf|$(sysconfdir)/ntpd.conf|g'

ntpd.8.out:	$(top_srcdir)/ntpd.8
	$(AWK) -f $(srcdir)/mdoc2man.awk $(top_srcdir)/ntpd.8 | \
	    sed $(PATHSUBS) > ntpd.8.out || rm -f ntpd.8.out

ntpd.conf.5.out:	$(top_srcdir)/ntpd.conf.5
	$(AWK) -f $(srcdir)/mdoc2man.awk $(top_srcdir)/ntpd.conf.5 | \
	    sed $(PATHSUBS) > ntpd.conf.5.out || rm -f ntpd.8.out

catman-do:	$(MANPAGES_IN)
	nroff -mandoc ntpd.8 |cat -v | sed -e 's/.\^H//g' > ntpd.0
	nroff -mandoc ntpd.conf.5 | cat -v | sed -e 's/.\^H//g' > ntpd.conf.0

ntpd:	ntpd.o buffer.o log.o imsg.o ntp.o ntp_msg.o config.o \
	server.o client.o util.o y.tab.o $(LIBCOMPAT)
	$(CC) $(CFLAGS) $(LDFLAGS) -o ntpd $(OBJS) $(LIBCOMPAT) $(LIBS)

.c.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $<

y.tab.c:	$(top_srcdir)/parse.y
	$(YACC) $(top_srcdir)/parse.y

install: ntpd $(MANOUT)
	@if [ ! -d $(DESTDIR)$(sbindir) ]; then \
		$(INSTALL) -m 755 -d $(DESTDIR)$(sbindir); \
	fi
	@if [ ! -d $(DESTDIR)$(sysconfdir) ]; then \
		$(INSTALL) -m 755 -d $(DESTDIR)$(sysconfdir); \
	fi
	@if [ ! -d $(DESTDIR)$(mandir)/$(mansubdir)5 ]; then \
		$(INSTALL) -m 755 -d $(DESTDIR)$(mandir)/$(mansubdir)5; \
	fi
	@if [ ! -d $(DESTDIR)$(mandir)/$(mansubdir)8 ]; then \
		$(INSTALL) -m 755 -d $(DESTDIR)$(mandir)/$(mansubdir)8; \
	fi
	$(INSTALL) -m 0755 $(STRIP_OPT) ntpd $(DESTDIR)$(sbindir)/ntpd
	$(INSTALL) -m 644 ntpd.8.out $(DESTDIR)$(mandir)/$(mansubdir)8/ntpd.8
	$(INSTALL) -m 644 ntpd.conf.5.out $(DESTDIR)$(mandir)/$(mansubdir)5/ntpd.conf.5
	@if [ ! -d $(DESTDIR)$(sysconfdir) ]; then \
		$(INSTALL) -m 755 -d $(DESTDIR)$(sysconfdir); \
	fi
	@if [ ! -f $(DESTDIR)$(sysconfdir)/ntpd.conf ]; then \
		$(INSTALL) -m 644 $(srcdir)/ntpd.conf $(DESTDIR)$(sysconfdir)/ntpd.conf; \
	else \
		echo "$(DESTDIR)$(sysconfdir)/ntpd.conf already exists, install will not overwrite"; \
	fi
	@if [ ! -d $(DESTDIR)$(PRIVSEP_PATH) ]; then \
		mkdir -p $(DESTDIR)$(PRIVSEP_PATH) ;\
		chown 0 $(DESTDIR)$(PRIVSEP_PATH) ; \
		chgrp 0 $(DESTDIR)$(PRIVSEP_PATH) ; \
		chmod 0755 $(DESTDIR)$(PRIVSEP_PATH) ; \
	fi
	@if egrep "^$(PRIVSEP_USER):" /etc/group >/dev/null; then \
	  : ;\
	else \
	  echo "Please create a dedicated group for ntpd." ;\
	  echo "This is system-dependant, possibly:" ;\
	  echo "# groupadd $(PRIVSEP_USER)" ;\
	fi
	@if egrep "^$(PRIVSEP_USER):" /etc/passwd >/dev/null; then \
	  : ;\
	else \
	  echo "Please create a dedicated user for ntpd and ensure it can" ;\
	  echo "not be used to log in.  This is system-dependant, possibly:" ;\
	  echo "# useradd -g $(PRIVSEP_USER) -s /sbin/nologin -d $(PRIVSEP_PATH) -c 'OpenNTP daemon' $(PRIVSEP_USER)" ;\
	fi

diff:
	-diff -x CVS -x Makefile -ru /usr/src/usr.sbin/ntpd ./ | \
	    egrep -v "^Only in" >ntpd-vs-openbsd.diff

clean:
	rm -f $(OBJS) ntpd openbsd-compat/*.o openbsd-compat/*.a \
	    configure.lineno config.h.in~ $(MANPAGES)

distclean: clean
	rm -rf config.log config.status configure.lineno \
	    config.h Makefile openbsd-compat/Makefile ntpd.0 ntpd.conf.0

distprep: distclean catman-do
	autoheader
	autoreconf
	test y.tab.c -nt parse.y || yacc parse.y
	rm -rf Makefile openbsd-compat/Makefile autom4te.cache
