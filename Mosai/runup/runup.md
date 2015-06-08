runup
=====

A format and tool for running code blocks inside markdown files automatically.

 - list all commands and subcommands
 - execute a command and/or subcommands
 - prove that all code blocks are marked and work
 -

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


Now run it to see results and output:

[ ]:real:example:main

	$ ./runup.sh run "runup_example.md"
	ok	- my runup Script
	#	Hello World
	#	from runup
	$ echo 3
	3
