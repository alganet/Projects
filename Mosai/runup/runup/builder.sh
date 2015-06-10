runup_builder () {
    (
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
        doc_elink="/^${line}\(\[ \]\:\)\([a-zA-Z0-9]*\)\s*(*\([^)]*\)\s*)*\s*$/"
		# Sed expression used to remove the standard prefix
		remove_number="s/^${line}//"
		# An expression that matches an empty prefixed line
		empty_line="/^${line}$/"
		# Sed expression to close an open fence
		close_fence="s/^\(${line}\)\(~~~\|\`\`\`\).*/\1\2/"
		# Expression to mark the starting line of a text with a function
		doc_text_mark="
				h
				s/^\([0-9][0-9]*\)${tab}\(.*\)/text_at_\1 () {/p
				i cat <<'OUTPUT'
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
				i # Begin File
				i # Raw Text
				${doc_text_mark}
				n
			    b _body_in

			:_docfile
				a # End Text
				a # End File
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
				i # End Text
				h
				x
				h
				s${doc_elink}\2/
				s/[^a-zA-Z0-9]/_/g
				x
				###  TEXT
				s${doc_elink}\2\3/
				s/[^a-zA-Z0-9]/_/g
				s/$/ () {/

				p
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
				${doc_fence}    { h ; b _ecode_fenced }
				b _body_in

			:_ecode_fenced
				s/^/# Begin Fence	/
				p
				$ { b endfence }
				n
				/^${line}\\$/! {
					i cat <<'OUTPUT'
					b _code_fenced_in
				}
				i # Begin Input
				i cat <<'INPUT'
				a INPUT
				a # End Input
				a # Begin Output
				a cat <<'OUTPUT'
				###  EINPUT
				${remove_number}

				p
				$ { b endcodeout }
				n
			:_ecode_fenced_in
				/^${line}\\$/ {
					i OUTPUT
					i # End Output
					i # Begin Input
					i cat <<'INPUT'
					a INPUT
					a # End Input
					a # Begin Output
					a cat <<'OUTPUT'
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
			        G

			        /^${line}~~~\\
					${line}~~~$/      { b _ecode_fenced_close }

			        /^${line}\`\`\`\\
					${line}\`\`\`$/   { b _ecode_fenced_close }

			        ${close_fence}

			        b _ecode_fenced_in
			    }
			    b _ecode_fenced_in

			:_ecode_fenced_close
				i # End Output
				b _code_fenced_close

			:_ecode_indented_open
				i # Start Code Indent
				/^${line}${tab}\\$/! {
					i cat <<'OUTPUT'
					b _code_indented
				}
				x
				/^real$/! {
					b _code_indented 
				}
				x
				i # Begin Input
				i cat <<'INPUT'
				a INPUT
				a # End Input
				a # Begin Output
				a cat <<'OUTPUT'
				###  EINPUT
				s/^${line}${tab}*//

				p
				$ { b endcodeout }
				n
			:_ecode_indented
				/^${line}${tab}\\$/ {
					i OUTPUT
					i # End Output
					i # Begin Input
					i cat <<'INPUT'
					a INPUT
					a # End Input
					a # Begin Output
					a cat <<'OUTPUT'
					###  EINPUT
					s/^${line}${tab}*//

					p
					$ { b endcodeout }
					n
					b _ecode_indented
				}
				###  EOUTPUT
				s/^${line}${tab}*//

				p
				$ { b endcodeout }
				n
			    ${doc_indent} { b _ecode_indented }
			    ${empty_line}   { b _ecode_indented }
			    ${doc_line}   {
			    	i OUTPUT
					i # End Output
			    	b _code_indented_close
			    }
			    b _docfile

			:_code_indented_open
				i # Begin Code Indent
				b _code_indented

			:_code_indented
				###  Code
				s/^${line}${tab}*//

				p
				$ { b endcode }	
				n
			    ${doc_indent} { b _code_indented }
			    ${empty_line}   { b _code_indented }
			    ${doc_line}   { b _code_indented_close }
			    b _docfile

			:_code_indented_close
		    	i OUTPUT
				i }
				i # End Output
				i # End Code Indent
				i # Begin Text
				${doc_text_mark}
				b _body

			:_code_fenced
				i # End Text
				s/^/# Begin Code Fence	/
				p
				$ { b endfence }
				n
			:_code_fenced_in
				###  FENCE
				${remove_number}

				p
				$ { b endfence }
				n
			    ${doc_fence} {
			        G

			        /^${line}~~~\\
					${line}~~~$/      { b _code_fenced_close }

			        /^${line}\`\`\`\\
					${line}\`\`\`$/   { b _code_fenced_close }

			        ${close_fence}

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
				i # Begin Text
				${doc_text_mark}
				b _body_in

			:endbody
				a OUTPUT
				a }
				a # End Text
				a # End File
				a # End Stream
				q
			:endcodeout
		    	a OUTPUT
				a # End Output
			:endcode
				a }
				a # End Code Indent
				a # End File
				a # End Stream
				q
			:endfenceout
		    	a OUTPUT
				a # End Output
			:endfence
				a }
				a # End Fence
				a # End File
				a # End Stream
				q
			:endstream
				a # End File
				a # End Stream
				q

		SED
    )
}
