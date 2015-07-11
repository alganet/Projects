runup_builder () {
    (
    	prefix="${1:-${RANDOM}_}"
    	# A literal tab
        tab=$(printf '\t')
        # The standard prefix for a document line
        line="[0-9][0-9]*${tab}"
        # The beginning of a document, prefixed
        stream_doc="/^0${tab}\(.*\)$/"
        # Any line from a document
        doc_line="/^${line}\(.*\)/"
        # An indented block of code on a document
        doc_indent="/^${line}\(${tab}\|    \)\(.*\)$/"
        # The beginning or ending of a code fence
        doc_fence="/^${line}\(~~~\|\`\`\`\)$/"
        # An invisible link used to reference code blocks
        doc_elink="/^\([0-9][0-9]*\)${tab}\(\[ \]\:\)\([a-zA-Z0-9:]*\)\s*(*\([^)]*\)\s*)*\s*$/"
		# Sed expression used to remove the standard prefix
		remove_number="s/^${line}//"
		# An expression that matches an empty prefixed line
		empty_line="/^${line}$/"
		# Sed expression to close an open fence
		close_fence="s/^\(${line}\)\(~~~\|\`\`\`\).*/\1\2/"
		# Sed expression to add shell code that expands parameters
		param_dispatch="a [ -z \"\${@:-}\" ] || ${prefix}\${@:-:}"
		block_output="i cat <<'OUTPUT' | \"\${1:-cat}\""
		block_input="i cat <<'INPUT' | \"\${2:-cat}\""
		fence_common="$(cat <<-SED
			        G

			        /^${line}~~~\\
					${line}~~~$/      { b _code_fenced_close }

			        /^${line}\`\`\`\\
					${line}\`\`\`$/   { b _code_fenced_close }

			        ${close_fence}
				SED
		)"
		# Expression to mark the starting line of a text with a function
		doc_text_mark="
				h
				s/^\([0-9][0-9]*\)${tab}\(.*\)/${prefix}text_\1 () {/p
				${block_output}
				x
		"
		# Main sed script built with templates above
        cat <<-SED
			:stream
			    ${stream_doc} { b _file }
				h
				s/^/# Begin Stream/
				p
				$ { b endstream }
				g
			    n
			    b stream

			:_file
				s/^${line}//
				s/^\([a-f0-9]*\)${tab}\(.*\)/${prefix}file_\1 () {\\
				${prefix}path_\1 () ( echo \'\2\' ) /p
				i ${prefix}text_0 () {
				${doc_text_mark}
				n
			    b _body_in

			:_docfile
				a OUTPUT
				${param_dispatch}
				a }
				n
			    b stream

			:_body
				###  TEXT
				${remove_number}

				p
				$ { b endbody }
				N
				s/^.*\\
				//
			:_body_in
			    ${doc_indent}   { b _code_indented_open }
			    ${doc_fence}    { h ; b _code_fenced }
			    ${doc_elink}    { b _elink }
			    ${doc_line}     { b _body }
			    b _docfile


			:_elink
				i OUTPUT
				i }
				h
				x
				h
				s${doc_elink}\3/
				s/[^a-zA-Z0-9]/_/g

			:_elink_file
				x
				###  TEXT
				s${doc_elink}${prefix}meta_\3 () {\\
				${prefix}prop_name () ( echo \'\4\' ) /
				s/\([a-zA-Z0-9]*\):/\1_/g
				/^$/ { s/^.*$/default/ }
				p
			:_elink_common
				$ { b endbody }
				n
				${empty_line} { b _elink_mark }
			    b _body_in

			:_elink_mark
				###  TEXT
				${remove_number}

				p
				$ { b endbody }
				n
			    ${doc_indent}   { b _ecode_indented_open }
				${doc_fence}    {
					x
					/^repl/! {
						x
						h
						b _code_fenced
					}
					x
					h
					b _ecode_fenced
				}
				${block_output}
				b _body

			:_ecode_fenced
				s/^/# Begin Fence	/
				p
				$ { b endfenceout }
				n
				/^${line}\\$/! {
					${block_output}
					b _code_fenced_in
				}
				${block_input}
				a INPUT
				${block_output}
				###  EINPUT
				${remove_number}

				p
				$ { b endcodeout }
				n
			:_ecode_fenced_in
				/^${line}\\$/ {
					i OUTPUT
					${block_input}
					a INPUT
					${block_output}
					###  EINPUT
					${remove_number}

					p
					$ { b endfenceout }
					n
					b _ecode_fenced_in
				}
				###  EOUTPUT
				${remove_number}

				p
				$ { b endfenceout }
				n
			    ${doc_fence} {
			    	${fence_common}

			        b _ecode_fenced_in
			    }
			    b _ecode_fenced_in

			:_ecode_indented_open
				/^${line}${tab}\\$/! {
					${block_output}
					b _code_indented
				}
				x
				/^repl/! {
					b _code_indented
				}
				x
				${block_input}
				a INPUT
				${block_output}
				###  EINPUT
				s/^${line}${tab}*\(${tab}\|\s\)*//p
				$ { b endcodeout }
				n
			:_ecode_indented
				/^${line}${tab}\\$/ {
					i OUTPUT
					${block_input}
					a INPUT
					${block_output}
					###  EINPUT
					s/^${line}${tab}*\(${tab}\|\s\)*//

					p
					$ { b endcodeout }
					n
					b _ecode_indented
				}
				###  EOUTPUT
				s/^${line}${tab}*\(${tab}\|\s\)*//
				p
				$ { b endcodeout }
				n
			    ${doc_indent} { b _ecode_indented }
			    ${empty_line}   { b _ecode_indented }
			    ${doc_elink}    { b _elink }
			    ${doc_line}   {
			    	i OUTPUT
			    	b _code_indented_close
			    }
			    b _docfile

			:_code_indented_open
				i OUTPUT
				i }
				h
				s/^\([0-9][0-9]*\)${tab}\(.*\)/${prefix}indent_\1 () {/
				p
				x
				${block_output}
				b _code_indented

			:_code_indented
				###  Code
				s/^${line}${tab}*\(${tab}\|\s\)*//
				p
				$ {

					b endcodeout
				}
				n
			    ${doc_indent} { b _code_indented }
			    ${empty_line}   { b _code_indented }
			    ${doc_line}   { b _code_indented_close }
			    ${doc_elink}    { b _elink }

			    b _docfile

			:_code_indented_close
			    ${doc_elink}    { b _elink }
		    	i OUTPUT
				i }
				${doc_text_mark}
				b _body_in

			:_code_fenced
				i OUTPUT
				i }
				s/^\([0-9][0-9]*\)${tab}\(.*\)/${prefix}fence_\1 () {/p
				$ { b endfenceout }
				n
				/^${line}\\$/! {
					${block_output}
					b _code_fenced_in
				}
			:_code_fenced_in
				###  FENCE
				${remove_number}

				p
				$ { b endfenceout }
				n
			    ${doc_fence} {
			    	${fence_common}

			        b _code_fenced_in
			    }
			    b _code_fenced_in

			:_code_fenced_close
		        ${close_fence}
				s/^/# End Fence	/
		        i OUTPUT
		        i }
				p
				$ { b endstream }
				n
				${doc_text_mark}
				b _body_in

			:endbody
			:endcodeout
			:endfenceout
				a OUTPUT
				a }
			:endstream
				${param_dispatch}
				a }
				${param_dispatch}
				q

		SED
    )
}
