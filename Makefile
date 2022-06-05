.POSIX:

XCFLAGS = $(CFLAGS) -Wall -Wextra -pedantic -Og -g

all: uxndebug

uxndebug: uxndebug.c
	$(CC) $(XCFLAGS) -o $@ uxndebug.c

clean:
	rm -f uxndebug
