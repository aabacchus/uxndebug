# uxndebug

This is a suite of tools for use in debugging uxn programs.

### uxndebug
This is a modified version of uxnasm which operates exactly the same way, but
also generates a debug info file when run with the `-g` flag. The format of this file is documented
in the `uxndebug(5)` manpage.

### uxnsolve
This program finds and highlights the faulty opcode by parsing a debug info file.

## Usage

First, to compile uxndebug, run
```
make
```

Then compile your program:
```
./uxndebug -g test.tal test.rom
```
This will generate a file `test.tal.debug` in addition to the rom.

Suppose you now run `test.rom` with your emulator of choice, and some error occurs.
Hopefully your emulator gives you an error message and a byte offset of the address
at which the error was encountered. For example, `uxnemu` might say:
```
Loaded test.rom
<wst> empty
<rst> empty
Halted: Working-stack underflow#0002, at 0x01b3
Boot: Failed to start rom.
Boot: Failed to boot.
```
In this case, the faulty opcode had a value of `#0002` and was at address `0x01b3`.
So to find out which word in your source file this corresponds to, run
```
./uxnsolve test.tal.debug 01b3
```
The first argument is the path to the debug file. Don't move it or rename it, it depends
on being the same as the name of the source file but with `.debug` appended.

The second argument is the byte address. Don't subtract the 0x0100 padding of the zero-page,
uxnsolve does that for you.

That command will print the line number, along with the line and the specific opcode in a bold
red font.
The output might look like this:
```
line 289:  DUP #04 SFT ,print-nibble-hex JSR
```
(in this example the red font has been removed).


Remember to regenerate the debug info after changing your source code, otherwise it won't make
sense. uxnsolve will print a big WARNING if it notices that your source file is newer than the
debug info.

## Ideas

Some ideas for applications using this debug info.

* An emulator which can step through source code instructions word by word on a
button press, highlighting the current position in another window.
