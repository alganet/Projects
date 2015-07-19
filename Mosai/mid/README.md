**mid** runs code inside Markdown documents.

It is available as a 10KB portable shell library and command line tool.

---

Example
-------

Consider the following Markdown document (displayed as plain text):

[~]:file:sample (HELLO.md)
	Hello Friend!
	=============

	To display a Hello message, use the following code:

	```sh
		echo Hello World
	```


The first thing to do about Markdown files is list what *mid* sees about their structure:

[~]:repl:list (Listing code blocks from a markdown document)
	$ mid list HELLO.md

	        doc_text_1
	        doc_fence_6

That shows you the document elements that *mid* has found. To interact
with them, you can use the source command:

[~]:repl:source (Using the source generated from a markdown document)
	$ mid source HELLO.md | sh -s doc_text_1
	Hello Friend!
	=============

	To display a Hello message, use the following code:

	$ mid source HELLO.md | sh -s doc_fence_6
	        echo Hello World
