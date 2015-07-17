runup_builder () {
    (
    	prefix="${1:-${RANDOM}_}"
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
        # Any line from a document
        doc_line="/^${line}${anything}/"
        # An indented block of code on a document
        doc_indent="/^${line}\(${tab}\|    \)${anything}$/"
        # The beginning or ending of a code fence
        doc_fence="/^${line}\(${fence_tilde}\|${fence_tick}\)\([${alnum}]*\)${anything}$/"
        # An invisible link used to reference code blocks
        doc_meta="/^\(${digits}\)${tab}\(\[ \]\:\)\([${alnum}:]*\)\s*(*\([^)]*\)\s*)*\s*$/"
	# Sed expression used to remove the standard prefix
	remove_number="s/^${line}//"
	# An expression that matches an empty prefixed line
	empty_line="/^${line}$/"
	# Sed expression to close an open fence
	close_fence="s/^\(${line}\)\(${fence_tilde}\|${fence_tick}\).*/\1\2/"
	# Sed expression to add shell code that expands parameters
	param_dispatch="a if [ -z \"\${1:-}\" ]; then echo \"\$${prefix}list\" | tr ':' '\\\\n'; else ${prefix}\${@:-}; fi"
	# Shell expression to start an output block
	block_output="cat <<'${prefix}OUTPUT' | \"\${1:-cat}\""
	# Shell expression to start an input block
	block_input="cat <<'${prefix}INPUT' | \"\${2:-cat}\""
	# Common markdown fence closing sed expression
	fence_common="$(cat <<-SED
	        G

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
		h
		${doc_list}\"\${${prefix}list:-}:text_\1\"\\
		${prefix}text_\1 () {\\
		/p
		i ${block_output}
		x
	SED
	)"
	# Main sed script built with templates above
        cat <<-SED
	# Looks for a document line by line.
	# If a document is not found, skip line
	# and search again.
	# If a document is found, go to _document.
	#
	:_stream
		${stream_doc} { b _document }
		h
		s/^${anything}$/#!\/usr\/bin\/env sh/p
		$ { b endstream }
		g
		n
		b _stream

	# Starts a document and its first text block
	#
	:_document
		${remove_number}
		s/^\([a-f0-9]*\)${tab}${anything}/${prefix}list="\${${prefix}list:-}:file_\1"\\
		${prefix}file_\1_path () ( "\${1:-printf}" \'\2\' ) \\
		${prefix}file_\1 () {/p
		i ${prefix}list="text_0"
		i ${prefix}text_0 () {
		${doc_text_mark}
		n
		b _identify_line

	# Ends previous document block and output
	# and look for more documents
	#
	:_end_document
		a ${prefix}OUTPUT
		a }
		${param_dispatch}
		a }
		n
		b _stream

	# Processes a text line
	#
	:_print_text_line
		${remove_number}

		p
		$ { b endbody }
		N
		s/^.*\\
		//

	# Checks the next line for its corresponding type
	# and goes to it, otherwise ends the document.
	#
	:_identify_line
		${doc_indent}   { b _code_indented_open }
		${doc_fence}    { h ; b _code_fenced }
		${doc_meta}     { b _meta_annotation }
		${doc_line}     { b _print_text_line }
		b _end_document

	# Starts a meta annotation
	#
	:_meta_annotation
		i ${prefix}OUTPUT
		i }
		h
		x
		h
		s${doc_meta}\3/
		s/[^${alnum}]/_/g
		x
		s${doc_meta}${prefix}ns_\3_\1_name () ( "\${1:-printf}" '\4' )\\
		${prefix}ns_\3_\1 () {/

	:_meta_annotation_ns_loop
		s/${prefix}ns_\([${alnum}_]*\):/${prefix}ns_\1_/
		t _meta_annotation_ns_loop

		s/^${prefix}\([${alnum}_]*\)_name/${prefix}list="\${${prefix}list:-}:\1"\\
		${prefix}\1_name/
		/^$/ { s/^.*$/default/ }
		p
		$ { b endbody }
		n
		${empty_line} { b _annotated_code }
		b _identify_line

	# Looks for a meta annotated code
	#
	:_annotated_code
		${remove_number}

		p
		$ { b endbody }
		n
		${doc_indent}   { b _mcode_indented_open }
		${doc_fence}    {
			x
			/^repl/! {
				x
				h
				n
				i ${block_output}
				b _code_fenced_in
			}
			x
			h
			b _mcode_fenced
		}
		i ${block_output}
		b _print_text_line

	# Starts a meta annotated fence
	#
	:_mcode_fenced
		s/^/# Begin Fence	/
		p
		$ { b endfenceout }
		n
		/^${line}\\$/! {
			i ${block_output}
			b _code_fenced_in
		}
		i ${block_input}
		a ${prefix}INPUT
		a ${block_output}
		${remove_number}

		p
		$ { b endcodeout }
		n

	# Continues inside a fence, detects when it
	# closes and exit when appropriate.
	#
	:_mcode_fenced_in
		/^${line}\\$/ {
			i ${prefix}OUTPUT
			i ${block_input}
			a ${prefix}INPUT
			a ${block_output}
			${remove_number}

			p
			$ { b endfenceout }
			n

			${doc_fence} {
				${fence_common}

				b _mcode_fenced_in
			}
			b _mcode_fenced_in
		}
		${remove_number}

		p
		$ { b endfenceout }
		n
	    ${doc_fence} {
	    	${fence_common}

	        b _mcode_fenced_in
	    }
	    b _mcode_fenced_in

	# Starts a meta annotated indented block
	#
	:_mcode_indented_open
		/^${line}${tab}\\$/! {
			i ${block_output}
			b _code_indented
		}
		x
		/^repl/! {
			b _code_indented
		}
		x
		i ${block_input}
		a ${prefix}INPUT
		a ${block_output}
		s/^${line}${tab}*\(${tab}\|\s\)*//p
		$ { b endcodeout }
		n

	# Continues inside an indented block or detect
	# its ending and continue
	#
	:_mcode_indented
		/^${line}${tab}\\$/ {
			i ${prefix}OUTPUT
			i ${block_input}
			a ${prefix}INPUT
			a ${block_output}
			s/^${line}${tab}*\(${tab}\|\s\)*//

			p
			$ { b endcodeout }
			n
			b _mcode_indented
		}
		s/^${line}${tab}*\(${tab}\|\s\)*//
		/^$/! p
		$ { b endcodeout }
		N
		/\\
		/ {
			s/^\\
			//
			${doc_indent} {
				i
				b _mcode_indented
			}
			${empty_line} {
				i
				b _mcode_indented
			}
		}
		s/^${anything}\\
		${anything}$/\2/
		${doc_indent} { b _mcode_indented }
		${empty_line} { b _mcode_indented }
		${doc_meta}   { b _meta_annotation }
		${doc_line}   {
			i ${prefix}OUTPUT
			b _code_indented_close
		}
		b _end_document

	# Starts an indented code block
	#
	:_code_indented_open
		i ${prefix}OUTPUT
		i }
		h
		${doc_list}"\${${prefix}list:-}:doc_indent_\1"\\
		${prefix}doc_indent_\1 () {/
		p
		x
		i ${block_output}
		b _code_indented

	# Continues inside the indented block or exit
	#
	:_code_indented
		s/^${line}${tab}*\(${tab}\|\s\)*//
		p
		$ { b endcodeout }
		n
		${doc_indent}   { b _code_indented }
		${empty_line}   { b _code_indented }
		${doc_line}     { b _code_indented_close }
		${doc_meta}     { b _meta_annotation }
		b _end_document

	# Closes an indented block
	#
	:_code_indented_close
		${doc_meta}    { b _meta_annotation }
    		i ${prefix}OUTPUT
		i }
		${doc_text_mark}
		b _identify_line

	# Starts a code fence
	#
	:_code_fenced
		i ${prefix}OUTPUT
		i }
		${doc_list}"\${${prefix}list:-}:doc_fence_\1"\\
		${prefix}doc_fence_\1_spec () ( "\${1:-printf}" '\2' )\\
		${prefix}doc_fence_\1 () {/p
		$ { b endfenceout }
		n
		i ${block_output}
		b _code_fenced_in

	# Continues inside the fence or exit to the appropriate
	# type
	#
	:_code_fenced_in
		${remove_number}

		p
		$ { b endfenceout }
		n
	    	${doc_fence} {
	    		${fence_common}
	        	b _code_fenced_in
	    	}
	    b _code_fenced_in

	# Closes a fence
	#
	:_code_fenced_close
        ${close_fence}
        	${remove_number}
        	s/^/# /
		i ${prefix}OUTPUT
		i }
		p
		$ { b endstream }
		n
		${doc_text_mark}
		b _identify_line

	# Exits the document and stream altogether
	# from different labels
	#
	:endbody
	:endcodeout
	:endfenceout
		a ${prefix}OUTPUT
		a }
	:endstream
		${param_dispatch}
		a }
		${param_dispatch}
		q

	SED
    )
}
