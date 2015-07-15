# Begin Stream
_19966_list="${_19966_list:-}:file_0"
_19966_file_0 () {
_19966_path () ( echo '/n/Projects/Prototypes/Mosai/runup/./README.md' )
_19966_list="text_0"
_19966_text_0 () {
cat <<'_19966_OUTPUT' | "${1:-cat}"
**runup** extracts and runs code from technical documents.


Hello!

 - Some List
 - Another Item

Testing some

---

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:indent_13"
_19966_indent_13 () {
cat <<'_19966_OUTPUT' | "${1:-cat}"
My Sample Document
==================

To print text on the shell, use the `echo` command:

[ ]:repl

$ echo 'Hello World'
Hello World

_19966_OUTPUT
}
if [ -z "${1:-}" ]; then echo "$_19966_list" | tr ':' '\n'; else _19966_${@:-}; fi
}
_19966_list="${_19966_list:-}:file_1"
_19966_file_1 () {
_19966_path () ( echo '/n/Projects/Prototypes/Mosai/runup/./SYNTAX.md' )
_19966_list="text_0"
_19966_text_0 () {
cat <<'_19966_OUTPUT' | "${1:-cat}"
This document showcases annotations invisible to markdown viewers. It is
recommended that you see it in plain text.

---

# Annotations

Annotations are visible in plain text, invisible to the final markdown
document. They can inform the *runup* parser about the contents of the code.

Below, a raw annotation (rendered invisible):

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:ns_sample_annotation_13"
_19966_ns_sample_annotation_13 () {
echo '' | "${3:-:}"

cat <<'_19966_OUTPUT' | "${1:-cat}"
Below, the same annotation inside a safe code block:

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:indent_17"
_19966_indent_17 () {
cat <<'_19966_OUTPUT' | "${1:-cat}"
[ ]:sample:annotation

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:text_19"
_19966_text_19 () {

cat <<'_19966_OUTPUT' | "${1:-cat}"
 - Each annotation can target one paragraph, one code block or one code fence.
 - Each annotation is a namespace reference to commands in the `runup`
   command line tool.

# Code Blocks

*runup* is able to parse normal code blocks without any annotation, but
referencing them in the command line may be difficult.

Markdown syntax for fences (using triple-tick or triple-tilde) and indented
code blocks is supported.

## Non-annotated

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:indent_33"
_19966_indent_33 () {
cat <<'_19966_OUTPUT' | "${1:-cat}"
This
is
an
indented
block

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:text_39"
_19966_text_39 () {

cat <<'_19966_OUTPUT' | "${1:-cat}"
_19966_OUTPUT
}
_19966_list="${_19966_list:-}:fence_39"
_19966_fence_39 () {
cat <<'_19966_OUTPUT' | "${1:-cat}"
Fenced Block
_19966_OUTPUT
}
# End Fence	41	```
_19966_list="${_19966_list:-}:text_42"
_19966_text_42 () {

cat <<'_19966_OUTPUT' | "${1:-cat}"

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:fence_43"
_19966_fence_43 () {
cat <<'_19966_OUTPUT' | "${1:-cat}"
Fenced Block
_19966_OUTPUT
}
# End Fence	45	~~~
_19966_list="${_19966_list:-}:text_46"
_19966_text_46 () {

cat <<'_19966_OUTPUT' | "${1:-cat}"

Source:


_19966_OUTPUT
}
_19966_list="${_19966_list:-}:indent_50"
_19966_indent_50 () {
cat <<'_19966_OUTPUT' | "${1:-cat}"
This
is
an
indented
block

```
Fenced Block
```

~~~
Fenced Block
~~~

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:text_64"
_19966_text_64 () {

cat <<'_19966_OUTPUT' | "${1:-cat}"
## Annotated

Annotated code blocks have an annotation prefix to tell *runup* how to map
them to commands.

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:ns_sample_indented_69"
_19966_ns_sample_indented_69 () {
echo 'zoid' | "${3:-:}"

cat <<'_19966_OUTPUT' | "${1:-cat}"
This
is
an
indented
block

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:ns_sample_ticked_77"
_19966_ns_sample_ticked_77 () {
echo '' | "${3:-:}"

cat <<'_19966_OUTPUT' | "${1:-cat}"
Fenced Block
_19966_OUTPUT
}
# End Fence	81	```
_19966_list="${_19966_list:-}:text_82"
_19966_text_82 () {

cat <<'_19966_OUTPUT' | "${1:-cat}"

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:ns_sample_tilded_83"
_19966_ns_sample_tilded_83 () {
echo '' | "${3:-:}"

cat <<'_19966_OUTPUT' | "${1:-cat}"
Source:


_19966_OUTPUT
}
_19966_list="${_19966_list:-}:indent_88"
_19966_indent_88 () {
cat <<'_19966_OUTPUT' | "${1:-cat}"
[ ]:sample:indented

This
is
an
indented
block

[ ]:sample:ticked

```
Fenced Block
```

[ ]:sample:tilded

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:text_104"
_19966_text_104 () {

cat <<'_19966_OUTPUT' | "${1:-cat}"
_19966_OUTPUT
}
_19966_list="${_19966_list:-}:fence_104"
_19966_fence_104 () {
cat <<'_19966_OUTPUT' | "${1:-cat}"
Fenced Block
_19966_OUTPUT
}
# End Fence	106	~~~
_19966_list="${_19966_list:-}:text_107"
_19966_text_107 () {

cat <<'_19966_OUTPUT' | "${1:-cat}"

## REPL Blocks

REPL (Read-eval-print-loop) are interactive terminal sessions inside code
blocks. *runup* can parse their structure as well:


_19966_OUTPUT
}
_19966_list="${_19966_list:-}:ns_repl_sample_indented_114"
_19966_ns_repl_sample_indented_114 () {
echo '' | "${3:-:}"

cat <<'_19966_INPUT' | "${2:-cat}"
cat <<'_19966_OUTPUT' | "${1:-cat}"
$ echo This is an indented block
_19966_INPUT
This is an indented block

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:ns_repl_sample_ticked_119"
_19966_ns_repl_sample_ticked_119 () {
echo '' | "${3:-:}"

# Begin Fence	121	```
cat <<'_19966_INPUT' | "${2:-cat}"
$ echo This is a ticked block
_19966_INPUT
cat <<'_19966_OUTPUT' | "${1:-cat}"
This is a ticked block
_19966_OUTPUT
}
# End Fence	124	```
_19966_list="${_19966_list:-}:text_125"
_19966_text_125 () {

cat <<'_19966_OUTPUT' | "${1:-cat}"

_19966_OUTPUT
}
_19966_list="${_19966_list:-}:ns_repl_sample_tilded_126"
_19966_ns_repl_sample_tilded_126 () {
echo '' | "${3:-:}"

# Begin Fence	128	~~~
cat <<'_19966_INPUT' | "${2:-cat}"
$ echo This is a tilded block
_19966_INPUT
cat <<'_19966_OUTPUT' | "${1:-cat}"
This is a tilded block
_19966_OUTPUT
}
# End Fence	131	~~~
_19966_list="${_19966_list:-}:text_132"
_19966_text_132 () {

cat <<'_19966_OUTPUT' | "${1:-cat}"


Source:


_19966_OUTPUT
}
_19966_list="${_19966_list:-}:indent_137"
_19966_indent_137 () {
cat <<'_19966_OUTPUT' | "${1:-cat}"
[ ]:repl:sample:indented

$ echo This is an indented block
This is an indented block

[ ]:repl:sample:ticked

```
$ echo This is a ticked block
This is a ticked block
```

[ ]:repl:sample:tilded

~~~
$ echo This is a tilded block
This is a tilded block
~~~
_19966_OUTPUT
}
if [ -z "${1:-}" ]; then echo "$_19966_list" | tr ':' '\n'; else _19966_${@:-}; fi
}
if [ -z "${1:-}" ]; then echo "$_19966_list" | tr ':' '\n'; else _19966_${@:-}; fi
