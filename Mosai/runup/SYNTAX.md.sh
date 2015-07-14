# Begin Stream
_r_list="${_r_list:-}:file_8f0643d49be0350b42ee4cf9bcc3065c"
_r_file_8f0643d49be0350b42ee4cf9bcc3065c () {
_r_path_8f0643d49be0350b42ee4cf9bcc3065c () ( echo '/n/Projects/Prototypes/Mosai/runup/SYNTAX.md' ) 
_r_list="text_0"
_r_text_0 () {
cat <<'OUTPUT' | "${1:-cat}"
This document showcases annotations invisible to markdown viewers. It is
recommended that you see it in plain text.

---

# Annotations

Annotations are visible in plain text, invisible to the final markdown
document. They can inform the *runup* parser about the contents of the code.

Below, a raw annotation (rendered invisible):

OUTPUT
}
_r_list="${_r_list:-}:ns_sample_annotation"
_r_ns_sample_annotation () {
_r_title () ( echo '' ) 

cat <<'OUTPUT' | "${1:-cat}"
Below, the same annotation inside a safe code block:

OUTPUT
}
_r_list="${_r_list:-}:indent_17"
_r_indent_17 () {
cat <<'OUTPUT' | "${1:-cat}"
[ ]:sample:annotation

OUTPUT
}
_r_list="${_r_list:-}:text_19"
_r_text_19 () {

cat <<'OUTPUT' | "${1:-cat}"
 - Each annotation can target one paragraph, one code block or one code fence.
 - Each annotation is a namespace reference to commands in the `runup`
   command line tool.

# Code Blocks

*runup* is able to parse normal code blocks without any annotation, but
referencing them in the command line may be difficult.

Markdown syntax for fences (using triple-tick or triple-tilde) and indented
code blocks is supported.

## Non-annotated

OUTPUT
}
_r_list="${_r_list:-}:indent_33"
_r_indent_33 () {
cat <<'OUTPUT' | "${1:-cat}"
This
is
an
indented
block

OUTPUT
}
_r_list="${_r_list:-}:text_39"
_r_text_39 () {

cat <<'OUTPUT' | "${1:-cat}"
OUTPUT
}
_r_list="${_r_list:-}:fence_39"
_r_fence_39 () {
cat <<'OUTPUT' | "${1:-cat}"
Fenced Block
OUTPUT
}
# End Fence	41	```
_r_list="${_r_list:-}:text_42"
_r_text_42 () {

cat <<'OUTPUT' | "${1:-cat}"

OUTPUT
}
_r_list="${_r_list:-}:fence_43"
_r_fence_43 () {
cat <<'OUTPUT' | "${1:-cat}"
Fenced Block
OUTPUT
}
# End Fence	45	~~~
_r_list="${_r_list:-}:text_46"
_r_text_46 () {

cat <<'OUTPUT' | "${1:-cat}"

Source:


OUTPUT
}
_r_list="${_r_list:-}:indent_50"
_r_indent_50 () {
cat <<'OUTPUT' | "${1:-cat}"
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

OUTPUT
}
_r_list="${_r_list:-}:text_64"
_r_text_64 () {

cat <<'OUTPUT' | "${1:-cat}"
## Annotated

Annotated code blocks have an annotation prefix to tell *runup* how to map
them to commands.

OUTPUT
}
_r_list="${_r_list:-}:ns_sample_indented"
_r_ns_sample_indented () {
_r_title () ( echo '' ) 

cat <<'OUTPUT' | "${1:-cat}"
This
is
an
indented
block

OUTPUT
}
_r_list="${_r_list:-}:ns_sample_ticked"
_r_ns_sample_ticked () {
_r_title () ( echo '' ) 

OUTPUT
}
_r_list="${_r_list:-}:fence_79"
_r_fence_79 () {
cat <<'OUTPUT' | "${1:-cat}"
Fenced Block
OUTPUT
}
# End Fence	81	```
_r_list="${_r_list:-}:text_82"
_r_text_82 () {

cat <<'OUTPUT' | "${1:-cat}"

OUTPUT
}
_r_list="${_r_list:-}:ns_sample_tilded"
_r_ns_sample_tilded () {
_r_title () ( echo '' ) 

cat <<'OUTPUT' | "${1:-cat}"
Source:


OUTPUT
}
_r_list="${_r_list:-}:indent_88"
_r_indent_88 () {
cat <<'OUTPUT' | "${1:-cat}"
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

OUTPUT
}
_r_list="${_r_list:-}:text_104"
_r_text_104 () {

cat <<'OUTPUT' | "${1:-cat}"
OUTPUT
}
_r_list="${_r_list:-}:fence_104"
_r_fence_104 () {
cat <<'OUTPUT' | "${1:-cat}"
Fenced Block
OUTPUT
}
# End Fence	106	~~~
_r_list="${_r_list:-}:text_107"
_r_text_107 () {

cat <<'OUTPUT' | "${1:-cat}"

## REPL Blocks

REPL (Read-eval-print-loop) are interactive terminal sessions inside code
blocks. *runup* can parse their structure as well:


OUTPUT
}
_r_list="${_r_list:-}:ns_repl_sample_indented"
_r_ns_repl_sample_indented () {
_r_title () ( echo '' ) 

cat <<'INPUT' | "${2:-cat}"
cat <<'OUTPUT' | "${1:-cat}"
$ echo This is an indented block
INPUT
This is an indented block

OUTPUT
}
_r_list="${_r_list:-}:ns_repl_sample_ticked"
_r_ns_repl_sample_ticked () {
_r_title () ( echo '' ) 

# Begin Fence	121	```
cat <<'INPUT' | "${2:-cat}"
$ echo This is a ticked block
INPUT
cat <<'OUTPUT' | "${1:-cat}"
This is a ticked block
OUTPUT
}
# End Fence	124	```
_r_list="${_r_list:-}:text_125"
_r_text_125 () {

cat <<'OUTPUT' | "${1:-cat}"

OUTPUT
}
_r_list="${_r_list:-}:ns_repl_sample_tilded"
_r_ns_repl_sample_tilded () {
_r_title () ( echo '' ) 

# Begin Fence	128	~~~
cat <<'INPUT' | "${2:-cat}"
$ echo This is a tilded block
INPUT
cat <<'OUTPUT' | "${1:-cat}"
This is a tilded block
OUTPUT
}
# End Fence	131	~~~
_r_list="${_r_list:-}:text_132"
_r_text_132 () {

cat <<'OUTPUT' | "${1:-cat}"


Source:


OUTPUT
}
_r_list="${_r_list:-}:indent_137"
_r_indent_137 () {
cat <<'OUTPUT' | "${1:-cat}"
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
OUTPUT
}
if [ -z "${1:-}" ]; then echo "$_r_list" | tr ':' '\n'; else _r_${@:-}; fi
}
_r_list="${_r_list:-}:file_9341c83f3a04106cc62931aa597ad6aa"
_r_file_9341c83f3a04106cc62931aa597ad6aa () {
_r_path_9341c83f3a04106cc62931aa597ad6aa () ( echo '/n/Projects/Prototypes/Mosai/runup/README.md' ) 
_r_list="text_0"
_r_text_0 () {
cat <<'OUTPUT' | "${1:-cat}"
**runup** extracts and runs code from technical documents.


OUTPUT
}
_r_list="${_r_list:-}:indent_4"
_r_indent_4 () {
cat <<'OUTPUT' | "${1:-cat}"
My Sample Document
==================

To print text on the shell, use the `echo` command:

[ ]:repl

$ echo 'Hello World'
Hello World

OUTPUT
}
if [ -z "${1:-}" ]; then echo "$_r_list" | tr ':' '\n'; else _r_${@:-}; fi
}
if [ -z "${1:-}" ]; then echo "$_r_list" | tr ':' '\n'; else _r_${@:-}; fi
