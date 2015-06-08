runup
=====

*runup* stands for **R**ead **E**val **A**ssert **L**oop.

It is both a tool and a format for running runup code interactions inside technical markdown documents.

---

Create a markdown-compatible document with marked code blocks:

[ ]:file:runup_example.md

~~~
Hello from runup
================

A Hello World sample:

[ ]:real

	$ echo 'Hello World'
	Hello World
	$ echo 'from runup'
	from runup
~~~

Now run it to see results and output:

[ ]:real

~~~
$ ./runup.sh run "runup_example.md"
ok	- my runup Script
#	Hello World
#	from runup
$ echo 1
1
~~~

---

Code block marks such as `[ ]:real` are ignored by markdown parsers, so
*runup* documents can be used directly by GitHub Pages and several other
Markdown consumers.
