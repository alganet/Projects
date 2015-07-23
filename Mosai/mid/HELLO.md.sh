md_path () ( echo '/n/Projects/Prototypes/Mosai/mid/HELLO.md' | "${1:-cat}" )

md_list="${md_list:-}
	example_hello"

md_example_hello_attr () ( echo 'An annotated code block!' | "${1:-cat}"  )

md_example_hello () {
	echo doc_fence_2 | "${1:-cat}"
}

md_list="${md_list:-}
	doc_fence_2"

md_doc_fence_2_attr () ( echo '```sh' | "${1:-cat}" )

md_doc_fence_2 () {
	cat <<'O_3CB6DFB8' | "${1:-cat}"
echo Hello
O_3CB6DFB8
}


[ -z "${1:-}" ] && ${2:-echo} "$md_list" 1>&2 || md_${@:-}
