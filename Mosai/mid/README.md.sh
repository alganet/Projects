md_path () ( echo '/n/Projects/Prototypes/Mosai/mid/README.md' | "${1:-cat}" )

md_list="${md_list:-}
	doc_text_1"

md_doc_text_1 () {

	cat <<'O_3CB6DFB8' | "${1:-cat}"
# Handling Empty Documents

When processing source, an empty document should render a standard
empty output.

O_3CB6DFB8
}

md_list="${md_list:-}
	test_6"

md_test_6_attr () ( echo '' | "${1:-cat}"  )

md_test_6 () {
	echo doc_indent_8 | "${1:-cat}" 1>&2
}

md_list="${md_list:-}
	doc_indent_8"

md_doc_indent_8 () {
	cat <<'O_3CB6DFB8' | "${1:-cat}"
$ rm EMPTY.md       # Removing any previous test files
$ touch EMPTY.md    # Create an empty file
$ mid.sh source EMPTY.md > EMPTY.md.sh
$ cat EMPTY.md.sh   # No output
O_3CB6DFB8
}

md_list="${md_list:-}
	test_13"

md_test_13_attr () ( echo '' | "${1:-cat}"  )

md_test_13 () {
	echo doc_indent_15 | "${1:-cat}" 1>&2
}

md_list="${md_list:-}
	doc_indent_15"

md_doc_indent_15 () {
	cat <<'O_3CB6DFB8' | "${1:-cat}"
$ rm EMPTY.md       # Removing any previous test files
$ touch EMPTY.md    # Create an empty file
$ mid.sh source EMPTY.md > EMPTY.md.sh
$ cat EMPTY.md.sh   # No output
O_3CB6DFB8
}

md_list="${md_list:-}
	test_20"

md_test_20_attr () ( echo '' | "${1:-cat}"  )

md_test_20 () {
	echo doc_indent_22 | "${1:-cat}" 1>&2
}

md_list="${md_list:-}
	doc_indent_22"

md_doc_indent_22 () {
	cat <<'O_3CB6DFB8' | "${1:-cat}"
$ rm EMPTY.md       # Removing any previous test files
$ touch EMPTY.md    # Create an empty file
$ mid.sh source EMPTY.md > EMPTY.md.sh
$ cat EMPTY.md.sh   # No output

O_3CB6DFB8
}
md_list () ( echo "$md_list" )
[ -z "${1:-}" ] && ${2:-echo} "$md_list" 1>&2 || md_${@:-}
