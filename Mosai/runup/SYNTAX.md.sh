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

## Non-annotated

OUTPUT
}
_r_indent_27 () {
cat <<'OUTPUT' | "${1:-cat}"
This
is
an
indented
block

OUTPUT
}
_r_text_33 () {
cat <<'OUTPUT' | "${1:-cat}"
OUTPUT
}
_r_fence_33 () {
cat <<'OUTPUT' | "${1:-cat}"
Fenced Block
OUTPUT
}
# End Fence	35	```
_r_text_36 () {
cat <<'OUTPUT' | "${1:-cat}"

OUTPUT
}
_r_fence_37 () {
cat <<'OUTPUT' | "${1:-cat}"
Fenced Block
OUTPUT
}
# End Fence	39	~~~
_r_text_40 () {
cat <<'OUTPUT' | "${1:-cat}"

## Annotated

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
_r_fence_53 () {
cat <<'OUTPUT' | "${1:-cat}"
Fenced Block
OUTPUT
}
# End Fence	55	```
_r_text_56 () {
cat <<'OUTPUT' | "${1:-cat}"

OUTPUT
}
_r_meta_sample_tilded () {
_r_prop_name () ( echo '' ) 

OUTPUT
}
_r_fence_59 () {
cat <<'OUTPUT' | "${1:-cat}"
Fenced Block
OUTPUT
}
# End Fence	61	~~~
_r_text_62 () {
cat <<'OUTPUT' | "${1:-cat}"

## REPL Blocks


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

# Begin Fence	73	```
cat <<'INPUT' | "${2:-cat}"
cat <<'OUTPUT' | "${1:-cat}"
$ echo This is a ticked block
INPUT
This is a ticked block
OUTPUT
}
# End Fence	76	```
_r_text_77 () {
cat <<'OUTPUT' | "${1:-cat}"

OUTPUT
}
_r_meta_repl_sample_tilded () {
_r_prop_name () ( echo '' ) 

# Begin Fence	80	~~~
cat <<'INPUT' | "${2:-cat}"
cat <<'OUTPUT' | "${1:-cat}"
$ echo This is a tilded block
INPUT
This is a tilded block
OUTPUT
}
# End Fence	83	~~~
[ -z "${@:-}" ] || _r_${@:-:}
}
[ -z "${@:-}" ] || _r_${@:-:}
