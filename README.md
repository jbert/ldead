Linking unused functions
========================

I was curious to know exactly which code was linked in from a static library.

The makefile creates a static library from two object files (a.o and b.o)

Each of a.o and b.o contains two functions.

The executable code includes headers for all functions but only calls one of
the 'a' functions (`add`).

After compiling and linking, executable is examined with `nm e` to see which
symbols are included.

Results
-------

- Unoptimised build

Granularity is object file - both 'a' functions are included, no 'b'
functions.

- -O2 build

Same

- gc-sections

These flags cause `gcc` to place each function (and data item) in their own
ELF sections.

Instead of all going into the `.text` section, multiple sections (named
`.text.add` etc) are created.

The linker flag `--gc-sections` causes unreferenced sections to be discarded.


```
CFLAGS=-fdata-sections -ffunction-sections
LDFLAGS=-Wl,--gc-sections
```

Conclusion
----------

By default, the linker is working at the granularity of the object file (so
you could get unused function elimination (only) by having one function per
object file.

Linking with `-gc-sections` additionally causes the linker to eliminate at the
section level. Together with `-ffunction-sections`, to put each function in
its own section, this can be used to get function-level granularity.
