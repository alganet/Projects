# Begin Stream
_r_file_8f0643d49be0350b42ee4cf9bcc3065c () {
_r_path_8f0643d49be0350b42ee4cf9bcc3065c () ( echo '/n/Projects/Prototypes/Mosai/runup/SYNTAX.md' ) 
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
_r_meta_sample_annotation () {
_r_prop_name () ( echo '' ) 

cat <<'OUTPUT' | "${1:-cat}"
Below, the same annotation inside a safe code block:

OUTPUT
}
_r_indent_17 () {
cat <<'OUTPUT' | "${1:-cat}"
[ ]:sample:annotation

OUTPUT
}
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
_r_indent_33 () {
cat <<'OUTPUT' | "${1:-cat}"
This
is
an
indented
block

OUTPUT
}
_r_text_39 () {
cat <<'OUTPUT' | "${1:-cat}"
OUTPUT
}
_r_fence_39 () {
cat <<'OUTPUT' | "${1:-cat}"
Fenced Block
OUTPUT
}
# End Fence	41	```
_r_text_42 () {
cat <<'OUTPUT' | "${1:-cat}"

OUTPUT
}
_r_fence_43 () {
cat <<'OUTPUT' | "${1:-cat}"
Fenced Block
OUTPUT
}
# End Fence	45	~~~
_r_text_46 () {
cat <<'OUTPUT' | "${1:-cat}"

Source:


OUTPUT
}
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
_r_text_64 () {
cat <<'OUTPUT' | "${1:-cat}"
## Annotated

Annotated code blocks have an annotation prefix to tell *runup* how to map
them to commands.

OUTPUT
}
_r_meta_sample_indented () {
_r_prop_name () ( echo '' ) 

cat <<'OUTPUT' | "${1:-cat}"
This
is
an
indented
block

OUTPUT
}
_r_meta_sample_ticked () {
_r_prop_name () ( echo '' ) 

OUTPUT
}
_r_fence_79 () {
cat <<'OUTPUT' | "${1:-cat}"
Fenced Block
OUTPUT
}
# End Fence	81	```
_r_text_82 () {
cat <<'OUTPUT' | "${1:-cat}"

OUTPUT
}
_r_meta_sample_tilded () {
_r_prop_name () ( echo '' ) 

cat <<'OUTPUT' | "${1:-cat}"
Source:


OUTPUT
}
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
_r_text_104 () {
cat <<'OUTPUT' | "${1:-cat}"
OUTPUT
}
_r_fence_104 () {
cat <<'OUTPUT' | "${1:-cat}"
Fenced Block
OUTPUT
}
# End Fence	106	~~~
_r_text_107 () {
cat <<'OUTPUT' | "${1:-cat}"

## REPL Blocks

REPL (Read-eval-print-loop) are interactive terminal sessions inside code
blocks. *runup* can parse their structure as well:


OUTPUT
}
_r_meta_repl_sample_indented () {
_r_prop_name () ( echo '' ) 

cat <<'INPUT' | "${2:-cat}"
cat <<'OUTPUT' | "${1:-cat}"
$ echo This is an indented block
INPUT
This is an indented block

OUTPUT
}
_r_meta_repl_sample_ticked () {
_r_prop_name () ( echo '' ) 

# Begin Fence	121	```
cat <<'INPUT' | "${2:-cat}"
cat <<'OUTPUT' | "${1:-cat}"
$ echo This is a ticked block
INPUT
This is a ticked block
OUTPUT
}
# End Fence	124	```
_r_text_125 () {
cat <<'OUTPUT' | "${1:-cat}"

OUTPUT
}
_r_meta_repl_sample_tilded () {
_r_prop_name () ( echo '' ) 

# Begin Fence	128	~~~
cat <<'INPUT' | "${2:-cat}"
cat <<'OUTPUT' | "${1:-cat}"
$ echo This is a tilded block
INPUT
This is a tilded block
OUTPUT
}
# End Fence	131	~~~
_r_text_132 () {
cat <<'OUTPUT' | "${1:-cat}"


Source:


OUTPUT
}
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
[ -z "${@:-}" ] || _r_${@:-:}
}
[ -z "${@:-}" ] || _r_${@:-:}
