
sysconfdir=${prefix}/etc
srcdir=.
top_srcdir=..

all:	libopenbsd-compat.a

OPENBSD=	asprintf.o daemon.o errx.o inet_pton.o strlcpy.o verrx.o
COMPAT=		atomicio.o bsd-arc4random.o bsd-misc.o bsd-poll.o \
		bsd-snprintf.o bsd-getifaddrs.o bsd-setresuid.o \
		bsd-setresgid.o fake-rfc2553.o
PORT=		port-qnx.o


CC=mipsel-uclibc-gcc
LD=mipsel-uclibc-gcc
CFLAGS=-g -O2 -Wall -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wshadow -Wpointer-arith -Wcast-qual -Wsign-compare -D_GNU_SOURCE
LDFLAGS=-L/usr/local/ssl/lib 
CPPFLAGS=-I. -I.. -I$(srcdir) -I$(srcdir)/.. -I/usr/local/ssl/include 
LIBS=
AR=/usr/bin/ar
RANLIB=mipsel-uclibc-ranlib
INSTALL=/usr/bin/install -c

$(COMPAT):	../config.h
$(OPENBSD):	../config.h
$(PORT):	../config.h

.c.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $<

libopenbsd-compat.a:	$(COMPAT) $(OPENBSD) $(PORT)
	$(AR) rv $@ $(COMPAT) $(OPENBSD) $(PORT)
	$(RANLIB) $@

clean:
	rm -f $(COMPAT) $(OPENBSD) $(PORT) libopenbsd-compat.a
