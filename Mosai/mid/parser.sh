#!/usr/bin/env sh

mid_prefix="md_"
mid_env="/usr/bin/env sh"

mid_parse () {
	transpile_sed="sed -n"
	mid_sed="$(mid_parser_build ${mid_prefix})"
	if [ -f "${mid_parser}" ]
	then
		transpile_sed="sed -n -f"
		mid_sed="${mid_parser}"
	fi

	if [ -f "${1:-}" ]
	then
		mid_prepare "${PWD}/${1}" | ${transpile_sed} "${mid_sed}"
	fi
}

# Prepares the parser to run
mid_prepare () {
	mid_filename="${1}"
	echo
	echo "0${mid_tab}${mid_tab}${mid_filename}"
	sed '=' "$mid_filename" | sed "N;s/\n/${mid_tab}/"
}

# Does something in the parsers environment
mid_parser_do () {
	action="${1:-}"
	filename="${2:-}"
	shift 2
	doargs="${@:-}"
	${mid_env} <<-SHELL
		set -- '' :
		$(mid_command_source "${filename}")
		$(mid_action_${action} "${doargs}")
	SHELL
	:
}

# Builds a sed script that generates code from markdown files
mid_parser_build () {
(
    	prefix="${1:-${mid_prefix}}"
    	hprefix="$(echo ${prefix} | md5sum | sed  's/[^a-f0-9]//g;' | tr 'a-z' 'A-Z' | cut -b0-8)"
    	# A literal tab
        tab=$(printf '\t')
        digits="[0-9][0-9]*"
        alnum="a-zA-Z0-9"
        anything="\(.*\)"
        fence_tick="\`\`\`"
        fence_tilde="~~~"
        # The standard prefix for a document line
        line="${digits}${tab}"
        # The beginning of a document, prefixed
        stream_doc="/^0${tab}${anything}$/"
        #Expression to hold fence delimiters
        both_fences="${fence_tilde}\|${fence_tick}"
        # Any line from a document
        doc_line="/^${line}${anything}/"
        # An indented block of code on a document
        doc_indent="/^${line}\(${tab}\|    \)${anything}$/"
        # The beginning or ending of a code fence
        doc_fence="/^${line}\(${both_fences}\)\([${alnum}]*\)${anything}$/"
        # An invisible link used to reference code blocks
        doc_meta="/^\(${digits}\)${tab}\(\[~\]\:\)\([${alnum}:]*\)\s*(*\([^)]*\)\s*)*\s*$/"
	# Sed expression used to remove the standard prefix
	remove_number="s/^${line}//"
	# An expression that matches an empty prefixed line
	empty_line="/^${line}$/"
	# Sed expression to close an open fence
	close_fence="s/^\(${line}\)\(${both_fences}\).*/\1\2/"
	# Sed expression to add shell code that expands parameters
	param_dispatch="$(cat <<-SED
		# Dispatch parameters
		a [ -z \"\${1:-}\" ] && \${2:-echo} \"\$${prefix}list\" 1>&2 || ${prefix}\${@:-}
		SED
	)"
	# Shell expression to start an output block
	block_output="\	cat <<'O_${hprefix}' | \"\${1:-cat}\""
	# Shell expression to start an input block
	block_input="\	cat <<'I_${hprefix}' | \"\${2:-cat}\""
	# Common markdown fence closing sed expression
	prompt_spec="[${alnum}@]*\(\\\$\|>\|%\) *"
	fence_common="$(cat <<-SED
	        G
		# Closes fences

	        /^${line}${fence_tilde}\\
			${line}${fence_tilde}/ { b _code_fenced_close }

	        /^${line}${fence_tick}\\
			${line}${fence_tick}/  { b _code_fenced_close }

	        ${close_fence}
		SED
	)"
	doc_list="s/^\(${digits}\)${tab}${anything}/${prefix}list="
	# Expression to mark the starting line of a text with a function
	doc_text_mark="$(cat <<-SED
		# Standard line based output
		h
		${doc_list}\"\${${prefix}list:-}\\
		\	doc_text_\1\"\\
		\\
		${prefix}doc_text_\1 () {\\
		/p
		i ${block_output}
		x
		SED
	)"
	# Main sed script built with templates above
        cat <<-SED
	:_stream
		/^$/ { n; b _stream }
		${stream_doc} { b _document }
		b endstream

	:_document
		${remove_number}
		s/^\([a-f0-9]*\)${tab}${anything}/${prefix}path () ( echo \'\2\' | "\${1:-cat}" )\\
		/p
		$ { b endoutput }
		n
		${doc_indent}   { b _code_indented_open }
		${doc_fence}    { h ; b _code_fenced }
		${doc_meta}     { b _meta_annotation_in }
		${doc_text_mark}
		$ { b endoutput }
		b _identify_line

	:_print_text_line
		${remove_number}

		p
		$ { b endoutput }
		N
		s/^.*\\
		//

	:_identify_line
		${doc_indent}   { b _code_indented_open }
		${doc_fence}    { h ; b _code_fenced }
		${doc_meta}     { b _meta_annotation }
		${doc_line}     { b _print_text_line }
		b endstream

	:_meta_annotation
		i O_${hprefix}
		i }
		i
	:_meta_annotation_in
		h
		x
		h
		s${doc_meta}\3/
		s/[^${alnum}]/_/g
		x
		s${doc_meta}${prefix}\3_attr () ( echo '\4' | "\${1:-cat}"  )\\
		\\
		${prefix}\3 () {/

		:_meta_annotation_loop
			s/${prefix}\([${alnum}_]*\):/${prefix}\1_/
			t _meta_annotation_loop

		s/^${prefix}\([${alnum}_]*\)_attr/${prefix}list="\${${prefix}list:-}\\
		\	\1"\\
		\\
		${prefix}\1_attr/
		/^$/ { s/^.*$/default/ }
		p
		$ { b endmeta }
		b _annotated_block

	:_annotated_block
		$ { b endmeta }
		${remove_number}

		$ { b endmeta }
		n
		${doc_indent}   { b _annotated_code_open }
		${doc_fence}    {
			h
			b _annotated_fence_open
		}
		h
		s/^\(${digits}\)${tab}${anything}$/	echo doc_text_\1 | "\${1:-cat}" 1>\&2/p
		g
		i }
		i
		${doc_text_mark}
		b _print_text_line

	:_annotated_fence_open
		s/^\(${digits}\)${tab}\(${both_fences}\)\([${alnum}]*\)${anything}$/	echo doc_fence_\1 | "\${1:-cat}"\\
		}\\
		\\
		${prefix}list="\${${prefix}list:-}\\
		\	doc_fence_\1"\\
		\\
		${prefix}doc_fence_\1_attr () ( echo '\2\3' | "\${1:-cat}" )\\
		\\
		${prefix}doc_fence_\1 () {/
		p
		$ { b endoutput }
		n
		/^${line}${prompt_spec}/! {
			i ${block_output}
			b _code_fenced_in
		}
		i ${block_input}
		a I_${hprefix}
		a ${block_output}
		${remove_number}

		p
		$ { b endoutput }
		n
		b _code_fenced_in

	:_annotated_code_open
		h
		s/^\(${digits}\)${tab}${anything}/	echo doc_indent_\1 | "\${1:-cat}"\\
		}\\
		\\
		${prefix}list="\${${prefix}list:-}\\
		\	doc_indent_\1"\\
		\\
		${prefix}doc_indent_\1 () {/
		p
		x
		/^${line}${tab}${prompt_spec}/! {
			i ${block_output}
			b _code_indented
		}
		i ${block_input}
		a I_${hprefix}
		a ${block_output}
		s/^${line}${tab}*\(${tab}\|\s\)*//p
		$ { b endoutput }
		n
		b _code_indented

	:_code_indented_open
		i O_${hprefix}
		i }
		i
		h
		${doc_list}"\${${prefix}list:-}\\
		\	doc_indent_\1"\\
		\\
		${prefix}doc_indent_\1 () {/
		p
		x
		i ${block_output}
		b _code_indented

	:_code_indented
		/^${line}${tab}${prompt_spec}/ {
			i O_${hprefix}
			i ${block_input}
			a I_${hprefix}
			a ${block_output}
			s/^${line}${tab}*\(${tab}\|\s\)*//

			p
			$ { b endoutput }
			n
			b _code_indented
		}
		s/^${line}${tab}*\(${tab}\|\s\)*//
		/^$/! p
		$ { b endoutput }
		N
		/\\
		/ {
			s/^\\
			//
			${doc_indent} {
				i
				b _code_indented
			}
			${empty_line} {
				i
				b _code_indented
			}
		}
		s/^${anything}\\
		${anything}$/\2/
		${doc_indent} { b _code_indented }
		${empty_line} { b _code_indented }
		${doc_meta}   { b _meta_annotation }
		${doc_line}   {
			i O_${hprefix}
			b _code_indented_close
		}
		b endstream


	:_code_indented_close
		${doc_meta}    { b _meta_annotation }
		i }
		i
		${doc_text_mark}
		b _identify_line

	:_code_fenced
		i O_${hprefix}
		i }
		i
		${doc_list}"\${${prefix}list:-}\\
		\	doc_fence_\1"\\
		\\
		${prefix}doc_fence_\1_attr () ( echo '\2' | "\${1:-cat}" )\\
		\\
		${prefix}doc_fence_\1 () {/p
		$ { b endoutput }
		n
		i ${block_output}
		b _code_fenced_in

	:_code_fenced_in
		/^${line}${prompt_spec}/ {
			i O_${hprefix}
			i ${block_input}
			a I_${hprefix}
			a ${block_output}
			${remove_number}

			p
			$ { b endoutput }
			n

			${doc_fence} {
				${fence_common}

				b _code_fenced_in
			}
			b _code_fenced_in
		}
		${remove_number}

		p
		$ { b endoutput }
		n
	    ${doc_fence} {
	    	${fence_common}

	        b _code_fenced_in
	    }
	    b _code_fenced_in

	:_code_fenced_close
        	${close_fence}
        	${remove_number}
        	s/^${anything}$//
		i O_${hprefix}
		i }
		i
		p
		$ { b endstream }
		n
		${doc_text_mark}
		b _identify_line

	:endoutput
		a O_${hprefix}
		b endnormal
	:endmeta
		a :
	:endnormal
		a }
	:endstream
		${param_dispatch}
		q

	SED
    )
}

