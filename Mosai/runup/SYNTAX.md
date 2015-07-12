This document showcases annotations invisible to markdown viewers. It is
recommended that you see it in plain text.

---

# Annotations

Annotations are visible in plain text, invisible to the final markdown
document. They can inform the *runup* parser about the contents of the code.

Below, a raw annotation (rendered invisible):

[ ]:sample:annotation

Below, the same annotation inside a safe code block:

    [ ]:sample:annotation

 - Each annotation can target one paragraph, one code block or one code fence.
 - Each annotation is a namespace reference to commands in the `runup`
   command line tool.

# Code Blocks

*runup* is able to parse normal code blocks without any annotation, but
referencing them in the command line may be difficult.

Markdown syntax for fences (using triple-tick or triple-tilde) and indented
code blocks is supported.

## Non-annotated

	This
	is
	an
	indented
	block

```
Fenced Block
```

~~~
Fenced Block
~~~

Source:


		This
		is
		an
		indented
		block

	```
	Fenced Block
	```

	~~~
	Fenced Block
	~~~

## Annotated

Annotated code blocks have an annotation prefix to tell *runup* how to map
them to commands.

[ ]:sample:indented

	This
	is
	an
	indented
	block

[ ]:sample:ticked

```
Fenced Block
```

[ ]:sample:tilded

Source:


	[ ]:sample:indented

		This
		is
		an
		indented
		block

	[ ]:sample:ticked

	```
	Fenced Block
	```

	[ ]:sample:tilded

~~~
Fenced Block
~~~

## REPL Blocks

REPL (Read-eval-print-loop) are interactive terminal sessions inside code
blocks. *runup* can parse their structure as well:


[ ]:repl:sample:indented

	$ echo This is an indented block
	This is an indented block

[ ]:repl:sample:ticked

```
$ echo This is a ticked block
This is a ticked block
```

[ ]:repl:sample:tilded

~~~
$ echo This is a tilded block
This is a tilded block
~~~


Source:


	[ ]:repl:sample:indented

		$ echo This is an indented block
		This is an indented block

	[ ]:repl:sample:ticked

	```
	$ echo This is a ticked block
	This is a ticked block
	```

	[ ]:repl:sample:tilded

	~~~
	$ echo This is a tilded block
	This is a tilded block
	~~~
