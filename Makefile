.POSIX:

XCFLAGS = $(CFLAGS) -Wall -Wextra -pedantic -Og -g
PREFIX = /usr/local

all: uxndebug

uxndebug: uxndebug.c
	$(CC) $(XCFLAGS) -o $@ uxndebug.c

install: uxndebug
	mkdir -p             $(DESTDIR)$(PREFIX)/bin
	mkdir -p             $(DESTDIR)$(PREFIX)/share/man/man5
	cp uxndebug uxnsolve $(DESTDIR)$(PREFIX)/bin/
	cp uxndebug.5        $(DESTDIR)$(PREFIX)/share/man/man5/

clean:
	rm -f uxndebug
