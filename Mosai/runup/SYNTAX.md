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

## Annotated

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
