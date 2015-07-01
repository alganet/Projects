runup
=====

A format and tool for running code blocks inside markdown files automatically.

--

Create a markdown-compatible document with marked code blocks:

[ ]:file:runup_example.md

	Hello from runup
	================

	A Hello World sample:

	[ ]:real:example

	```
	$ echo 'Hello World'
	Hello World
	$ echo 'from runup'
	from runup
	```


Now run it to see results and output (ymmv, see ./runup.sh --help):

[ ]:real:example:main

	$ ./runup.sh --help
	some help content...
