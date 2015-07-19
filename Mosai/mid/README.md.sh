md_path () ( echo '/n/Projects/Prototypes/Mosai/mid/README.md' | "${1:-cat}" )

md_list="${md_list:-}
	doc_text_1"

md_doc_text_1 () {

	cat <<'O_3CB6DFB8' | "${1:-cat}"
**mid** runs code inside Markdown documents.

It is available as a 10KB portable shell library and command line tool.

---

Example
-------

Consider the following Markdown document (displayed as plain text):

O_3CB6DFB8
}

md_file_sample_attr () ( echo 'HELLO.md' | "${1:-cat}"  )

md_file_sample () {
	echo doc_indent_13 | "${1:-cat}"
}

md_list="${md_list:-}
	doc_indent_13"

md_doc_indent_13 () {
	cat <<'O_3CB6DFB8' | "${1:-cat}"
Hello Friend!
=============

To display a Hello message, use the following code:

```sh
echo Hello World
```

O_3CB6DFB8
}

md_list="${md_list:-}
	doc_text_23"

md_doc_text_23 () {

	cat <<'O_3CB6DFB8' | "${1:-cat}"
The first thing to do about Markdown files is list what *mid* sees about their structure:

O_3CB6DFB8
}

md_repl_list_attr () ( echo 'Listing code blocks from a markdown document' | "${1:-cat}"  )

md_repl_list () {
	echo doc_indent_26 | "${1:-cat}"
}

md_list="${md_list:-}
	doc_indent_26"

md_doc_indent_26 () {
	cat <<'I_3CB6DFB8' | "${2:-cat}"
$ mid list HELLO.md
I_3CB6DFB8
	cat <<'O_3CB6DFB8' | "${1:-cat}"

doc_text_1
doc_fence_6
O_3CB6DFB8
}

md_list="${md_list:-}
	doc_text_31"

md_doc_text_31 () {

	cat <<'O_3CB6DFB8' | "${1:-cat}"
That shows you the document elements that *mid* has found. To interact
with them, you can use the source command:

O_3CB6DFB8
}

md_repl_source_attr () ( echo 'Using the source generated from a markdown document' | "${1:-cat}"  )

md_repl_source () {
	echo doc_indent_35 | "${1:-cat}"
}

md_list="${md_list:-}
	doc_indent_35"

md_doc_indent_35 () {
	cat <<'I_3CB6DFB8' | "${2:-cat}"
$ mid source HELLO.md | sh -s doc_text_1
I_3CB6DFB8
	cat <<'O_3CB6DFB8' | "${1:-cat}"
Hello Friend!
=============

To display a Hello message, use the following code:

O_3CB6DFB8
	cat <<'I_3CB6DFB8' | "${2:-cat}"
$ mid source HELLO.md | sh -s doc_fence_6
I_3CB6DFB8
	cat <<'O_3CB6DFB8' | "${1:-cat}"
echo Hello World
O_3CB6DFB8
}
[ -z "${1:-}" ] && ${2:-echo} "$md_list" 1>&2 || md_${@:-}
