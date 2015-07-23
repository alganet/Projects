md_path () ( echo '/n/Projects/Prototypes/Mosai/mid/README.md' | "${1:-cat}" )

md_list="${md_list:-}
	doc_text_1"

md_doc_text_1 () {

	cat <<'O_3CB6DFB8' | "${1:-cat}"
**mid** allows you to reuse code blocks from Markdown documentation!

---

It introduces the *annotation*:

O_3CB6DFB8
}

md_list="${md_list:-}
	file"

md_file_attr () ( echo 'HELLO.md' | "${1:-cat}"  )

md_file () {
	echo doc_text_8 | "${1:-cat}" 1>&2
}

md_list="${md_list:-}
	doc_text_8"

md_doc_text_8 () {

	cat <<'O_3CB6DFB8' | "${1:-cat}"

O_3CB6DFB8
}

md_list="${md_list:-}
	doc_indent_9"

md_doc_indent_9 () {
	cat <<'O_3CB6DFB8' | "${1:-cat}"
[~]:example:hello (An annotated code block!)
```sh
echo Hello
```
O_3CB6DFB8
}

md_list="${md_list:-}
	doc_text_14"

md_doc_text_14 () {

	cat <<'O_3CB6DFB8' | "${1:-cat}"
Annotations are cool because they are:

  - Small simple one-liners for technical documents.
  - Invisible to the HTML output. Only the code block will appear.
  - Backwards-compatible with the [original Markdown](http://daringfireball.net/projects/markdown) and [CommonMark](http://commonmark.org/).

---

You can interact with annotated blocks using the **mid** tool:

O_3CB6DFB8
}

md_list="${md_list:-}
	example"

md_example_attr () ( echo '' | "${1:-cat}"  )

md_example () {
	echo doc_text_25 | "${1:-cat}" 1>&2
}

md_list="${md_list:-}
	doc_text_25"

md_doc_text_25 () {

	cat <<'O_3CB6DFB8' | "${1:-cat}"

O_3CB6DFB8
}

md_list="${md_list:-}
	doc_indent_26"

md_doc_indent_26 () {
	cat <<'O_3CB6DFB8' | "${1:-cat}"
$ mid list HELLO.md

example:hello
doc:fence:2
$ mid open HELLO.md example:hello
O_3CB6DFB8
}
[ -z "${1:-}" ] && ${2:-echo} "$md_list" 1>&2 || md_${@:-}
