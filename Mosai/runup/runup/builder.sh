runup_builder () {
    (
        tab=$(printf '\t')
        line="[0-9][0-9]*${tab}"
        stream_doc="/^0${tab}\(.*\)$/"
        doc_line="/^${line}\(.*\)/"
        doc_indent="/^${line}\(${tab}\|    \)\(.*\)$/"
        doc_fence="/^${line}\(~~~\|\`\`\`\)$/"
        doc_elink="/^${line}\(\[ \]\:\)\([a-zA-Z0-9]*\)\s*(*\([^)]*\)\s*)*\s*$/"
		remove_number="s/^${line}//"
		empty_line="/^${line}$/"
		close_fence="s/^\(${line}\)\(~~~\|\`\`\`\).*/\1\2/"
		doc_text_mark="
				h
				s/^\([0-9][0-9]*\)${tab}\(.*\)/text_at_\1/p
				x
		"
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
				i # End Text
				i # Raw Text
				${doc_text_mark}
				h
				s${doc_elink}\2/
				s/[^a-zA-Z0-9]/_/g
				x
				###  TEXT
				s${doc_elink}\2\3/
				s/[^a-zA-Z0-9]/_/g

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
				i # End Text
				s/^/# Begin Fence	/
				p
				$ { b endfence }
				n
				/^${line}\\$/! b _code_fenced_in
				i # Begin Input
				a # End Input
				a # Begin Output
				###  EINPUT
				${remove_number}

				p
				$ { b endcodeout }
				n
			:_ecode_fenced_in
				/^${line}\\$/ {
					i # End Output
					i # Begin Input
					a # End Input
					a # Begin Output
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
				i # End Text
				i # Start Code Indent
				/^${line}${tab}\\$/! b _code_indented
				x
				/^real$/! { x ; b _code_indented }
				x
				i # Begin Input
				a # End Input
				a # Begin Output
				###  EINPUT
				s/^${line}${tab}*//

				p
				$ { b endcodeout }
				n
			:_ecode_indented
				/^${line}${tab}\\$/ {
					i # End Output
					i # Begin Input
					a # End Input
					a # Begin Output
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
					i # End Output
			    	b _code_indented_close
			    }
			    b _docfile

			:_code_indented_open
				i # End Text
				i # Begin Code Indent
				b _code_indented

			:_code_indented
				###  CODE
				s/^${line}${tab}*//

				p
				$ { b endcode }
				n
			    ${doc_indent} { b _code_indented }
			    ${empty_line}   { b _code_indented }
			    ${doc_line}   { b _code_indented_close }
			    b _docfile

			:_code_indented_close
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
				s/^/# End Stream Fence	/
				p
				$ { b endstream }
				n
				a # Begin Text
				${doc_text_mark}
				b _body_in

			:endbody
				a # End Text
				a # End File
				a # End Stream
				q
			:endcodeout
				a # End Output
			:endcode
				a # End Code Indent
				a # End File
				a # End Stream
				q
			:endfenceout
				a # End Output
			:endfence
				a # End Stream Fence
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
