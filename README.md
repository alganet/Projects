My Versioned Incomplete Prototypes
==================================

Future code to be published on http://github.com/Mosai

[runup](Mosai/runup/runup.md)
-----

Transforms technical documents in real code. Cool for tests, practical
documentation and tutorials.

Its inner works are very unusual:

  1 - A single sed script transpiles the markdown to POSIX Shell script. It
      is a partial markdown parser capable of identifying code fences and
      special links.
  3 - Fences can be marked. Most code should be allowed (making the shell
      script call another languages). REPL interaction is also possible (and
      it was the first parser).
  2 - Shell code is the run and output is enjoyed.

This is an innocent attempt to blur the lines between code and documents. It
plays on DSLs as existing languages.

dispatch
--------

A very clean way to dispatch shell arguments to functions.

eremita
-------

An experiment with shell namespaced libraries, largely unstable.
