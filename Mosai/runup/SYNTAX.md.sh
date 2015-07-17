#!/usr/bin/env sh
_27817_list="${_27817_list:-}:file_0"
_27817_file_0_path () ( "${1:-printf}" '/n/Projects/Prototypes/Mosai/runup/./ESSAY.md' ) 
_27817_file_0 () {
_27817_list="text_0"
_27817_text_0 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
Parsing Code Inside Markdown Documents
======================================

An essay about parsing code inside Markdown documents.

Abstract
--------

Markdown is a tool for converting intuitive plain text markup into HTML.
It has been used extensively for documenting software, often with
running samples and instructions marked with specific Markdown syntax.

By creating a tool that can extract and run code inside Markdown
documents by inspecting this syntax we can blend the borders between
document and code by enabling users to interact with code inside
plain text written documents.

This essay explains how I approached that and the goals I'm trying to
achieve.


The Kinds Of Code We Want
-------------------------

Markdown writing has been very permissive since its origins. Although
efforts such as the CommonMark specification added an optional normative
layer upon the standard, its support has been oriented towards
robustness (in the sense that implementations are often loose on its
input rules).

Popular ways of expressing code using markdown writing are:

  - **Plain Code**: Just plain code inside a fence or indented block.

  ```
  echo 'Hello'
  ```

  - **Marked Code**: Code inside a fence with its language tag.

  ```sh
  echo 'Hello'
  ```

  - **REPL Interaction**: Read-eval-print loop "recordings"

  ```sh
  $ echo 'Hello'
  Hello
  ```

On our approach, we will be able to identify these three main cases
when they appear as first-level items in the markdown document. The
REPL identifyer can be configured to accept multiple prompt expressions
such as `php> ` or `custom% `.

Interfacing With Documents
--------------------------

In order to enable more tools, a robust cross-platform library that
can run anywhere should exist.

Such library works by extracting the code blocks into different
available calls that can be invoked separatedly. In this model, a
developer can use the library to list and get individual blocks
from the markdown in their original order:

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_fence_68"
_27817_doc_fence_68_spec () ( "${1:-printf}" '```sh' )
_27817_doc_fence_68 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
$ library.sh source DOCUMENT.md | sh
file_0
$ library.sh source DOCUMENT.md | sh -s file_0
text_0
indent_3
$library.sh source DOCUMENT.md | sh -s file_0 indent_3
This is the contents of an indented block on the line 3!
_27817_OUTPUT
}
# ```
_27817_list="${_27817_list:-}:text_77"
_27817_text_77 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

Creating Invisible Links
------------------------

For simple documents, that may be enough. A more comprehensive
identification system could be designed so specific blocks can receive
aliases:

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_fence_85"
_27817_doc_fence_85_spec () ( "${1:-printf}" '```sh' )
_27817_doc_fence_85 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
$ library.sh source DOCUMENT.md | sh
file_0
$ library.sh source DOCUMENT.md | sh -s file_0
text_0
ns_sample_about_naming_3
$ library.sh source DOCUMENT.md | sh -s file_0 ns_sample_about_naming_3
This is the contents of an indent block on the line 5!
_27817_OUTPUT
}
# ```
_27817_list="${_27817_list:-}:text_94"
_27817_text_94 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

To name these blocks, some markdown limitations need to be considered:

  - The name must not appear on the rendered document. It is a meta
_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_indent_98"
_27817_doc_indent_98 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
information.
_27817_OUTPUT
}
_27817_list="${_27817_list:-}:text_99"
_27817_text_99 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
  - The name can be applied to both indented or code fences.
  - The name should not conflict with CommonMark tags for fences.
  - The syntax should work both on Markdown.pl and CommonMark.

The best invisible markdown construct is the reference:

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_fence_105"
_27817_doc_fence_105_spec () ( "${1:-printf}" '```md' )
_27817_doc_fence_105 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
[Link Name]:http://url (title)
_27817_OUTPUT
}
# ```
_27817_list="${_27817_list:-}:text_108"
_27817_text_108 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

In order to not conflict with links, in this tool we reserve a single
space for meta references:

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_fence_112"
_27817_doc_fence_112_spec () ( "${1:-printf}" '```md' )
_27817_doc_fence_112 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
## Hello!

[ ]:sample:about:naming

   This is the contents of an indented block on the line 3!
_27817_OUTPUT
}
# ```
_27817_list="${_27817_list:-}:text_119"
_27817_text_119 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

The colon `:` from the original syntax is reused as a namespace
separator, generating the call prefixed with `ns_` seen before.


The Guts of a Line-Based Parser
-------------------------------

Related Work
------------

https://github.com/aureliojargas/clitest



_27817_OUTPUT
}
if [ -z "${1:-}" ]; then echo "$_27817_list" | tr ':' '\n'; else _27817_${@:-}; fi
}
_27817_list="${_27817_list:-}:file_1"
_27817_file_1_path () ( "${1:-printf}" '/n/Projects/Prototypes/Mosai/runup/./README.md' ) 
_27817_file_1 () {
_27817_list="text_0"
_27817_text_0 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
**runup** extracts and runs code from technical documents.


Hello!

 - Some List
 - Another Item

Testing some

---

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_indent_13"
_27817_doc_indent_13 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
My Sample Document
==================

To print text on the shell, use the `echo` command:

[ ]:repl

$ echo 'Hello World'
Hello World

_27817_OUTPUT
}
if [ -z "${1:-}" ]; then echo "$_27817_list" | tr ':' '\n'; else _27817_${@:-}; fi
}
_27817_list="${_27817_list:-}:file_2"
_27817_file_2_path () ( "${1:-printf}" '/n/Projects/Prototypes/Mosai/runup/./SYNTAX.md' ) 
_27817_file_2 () {
_27817_list="text_0"
_27817_text_0 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
This document showcases annotations invisible to markdown viewers. It is
recommended that you see it in plain text.

---

# Annotations

Annotations are visible in plain text, invisible to the final markdown
document. They can inform the *runup* parser about the contents of the code.

Below, a raw annotation (rendered invisible):

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_sample_annotation_13"
_27817_ns_sample_annotation_13_name () ( "${1:-printf}" '' )
_27817_ns_sample_annotation_13 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
Below, the same annotation inside a safe code block:

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_indent_17"
_27817_doc_indent_17 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
[ ]:sample:annotation

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:text_19"
_27817_text_19 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
 - Each annotation can target one paragraph, one code block or one code fence.
 - Each annotation is a namespace reference to commands in the `runup`
   command line tool.

# Code Blocks

*runup* is able to parse normal code blocks without any annotation, but
referencing them in the command line may be difficult.

Markdown syntax for fences (using triple-tick or triple-tilde) and indented
code blocks is supported.

## Non-annotated

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_indent_33"
_27817_doc_indent_33 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
This
is
an
indented
block

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:text_39"
_27817_text_39 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_fence_39"
_27817_doc_fence_39_spec () ( "${1:-printf}" '```' )
_27817_doc_fence_39 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
Fenced Block
_27817_OUTPUT
}
# ```
_27817_list="${_27817_list:-}:text_42"
_27817_text_42 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_fence_43"
_27817_doc_fence_43_spec () ( "${1:-printf}" '~~~' )
_27817_doc_fence_43 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
Fenced Block
_27817_OUTPUT
}
# ~~~
_27817_list="${_27817_list:-}:text_46"
_27817_text_46 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

Source:


_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_indent_50"
_27817_doc_indent_50 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
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

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:text_64"
_27817_text_64 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
## Annotated

Annotated code blocks have an annotation prefix to tell *runup* how to map
them to commands.

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_sample_indented_69"
_27817_ns_sample_indented_69_name () ( "${1:-printf}" 'zoid' )
_27817_ns_sample_indented_69 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
This
is
an
indented
block

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_sample_ticked_77"
_27817_ns_sample_ticked_77_name () ( "${1:-printf}" '' )
_27817_ns_sample_ticked_77 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
Fenced Block
_27817_OUTPUT
}
# ```
_27817_list="${_27817_list:-}:text_82"
_27817_text_82 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_sample_tilded_83"
_27817_ns_sample_tilded_83_name () ( "${1:-printf}" '' )
_27817_ns_sample_tilded_83 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
Source:


_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_indent_88"
_27817_doc_indent_88 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
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

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:text_105"
_27817_text_105 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_fence_105"
_27817_doc_fence_105_spec () ( "${1:-printf}" '~~~' )
_27817_doc_fence_105 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
Fenced Block
_27817_OUTPUT
}
# ~~~
_27817_list="${_27817_list:-}:text_108"
_27817_text_108 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

## REPL Blocks

REPL (Read-eval-print-loop) are interactive terminal sessions inside code
blocks. *runup* can parse their structure as well:


_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_repl_sample_indented_115"
_27817_ns_repl_sample_indented_115_name () ( "${1:-printf}" '' )
_27817_ns_repl_sample_indented_115 () {

cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is an indented block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is an indented block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"




_27817_OUTPUT
cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is an indented block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"

_27817_OUTPUT
cat <<'_27817_INPUT' | "${2:-cat}"
$
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_repl_sample_ticked_127"
_27817_ns_repl_sample_ticked_127_name () ( "${1:-printf}" '' )
_27817_ns_repl_sample_ticked_127 () {

# Begin Fence	129	```
cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is a ticked block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is a ticked block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is a ticked block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is a ticked block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
}
# ```
_27817_list="${_27817_list:-}:text_135"
_27817_text_135 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_repl_sample_tilded_136"
_27817_ns_repl_sample_tilded_136_name () ( "${1:-printf}" '' )
_27817_ns_repl_sample_tilded_136 () {

# Begin Fence	138	~~~
cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is a tilded block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is a tilded block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is a tilded block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
}
# ~~~
_27817_list="${_27817_list:-}:text_143"
_27817_text_143 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"


Source:


_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_indent_148"
_27817_doc_indent_148 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
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
_27817_OUTPUT
}
if [ -z "${1:-}" ]; then echo "$_27817_list" | tr ':' '\n'; else _27817_${@:-}; fi
}
_27817_list="${_27817_list:-}:file_3"
_27817_file_3_path () ( "${1:-printf}" '/n/Projects/Prototypes/Mosai/runup/./SYNTAX2.md' ) 
_27817_file_3 () {
_27817_list="text_0"
_27817_text_0 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
This document showcases annotations invisible to markdown viewers. It is
recommended that you see it in plain text.

---

# Annotations

Annotations are visible in plain text, invisible to the final markdown
document. They can inform the *runup* parser about the contents of the code.

Below, a raw annotation (rendered invisible):

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_sample_annotation_13"
_27817_ns_sample_annotation_13_name () ( "${1:-printf}" '' )
_27817_ns_sample_annotation_13 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
Below, the same annotation inside a safe code block:

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_indent_17"
_27817_doc_indent_17 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
[ ]:sample:annotation

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:text_19"
_27817_text_19 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
 - Each annotation can target one paragraph, one code block or one code fence.
 - Each annotation is a namespace reference to commands in the `runup`
   command line tool.

# Code Blocks

*runup* is able to parse normal code blocks without any annotation, but
referencing them in the command line may be difficult.

Markdown syntax for fences (using triple-tick or triple-tilde) and indented
code blocks is supported.

## Non-annotated

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_indent_33"
_27817_doc_indent_33 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
This
is
an
indented
block

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:text_39"
_27817_text_39 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_fence_39"
_27817_doc_fence_39_spec () ( "${1:-printf}" '```' )
_27817_doc_fence_39 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
Fenced Block
_27817_OUTPUT
}
# ```
_27817_list="${_27817_list:-}:text_42"
_27817_text_42 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_fence_43"
_27817_doc_fence_43_spec () ( "${1:-printf}" '~~~' )
_27817_doc_fence_43 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
Fenced Block
_27817_OUTPUT
}
# ~~~
_27817_list="${_27817_list:-}:text_46"
_27817_text_46 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

Source:


_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_indent_50"
_27817_doc_indent_50 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
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

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:text_64"
_27817_text_64 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
## Annotated

Annotated code blocks have an annotation prefix to tell *runup* how to map
them to commands.

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_sample_indented_69"
_27817_ns_sample_indented_69_name () ( "${1:-printf}" 'zoid' )
_27817_ns_sample_indented_69 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
This
is
an
indented
block

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_sample_ticked_77"
_27817_ns_sample_ticked_77_name () ( "${1:-printf}" '' )
_27817_ns_sample_ticked_77 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
Fenced Block
_27817_OUTPUT
}
# ```
_27817_list="${_27817_list:-}:text_82"
_27817_text_82 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_sample_tilded_83"
_27817_ns_sample_tilded_83_name () ( "${1:-printf}" '' )
_27817_ns_sample_tilded_83 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
Source:


_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_indent_88"
_27817_doc_indent_88 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
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

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:text_104"
_27817_text_104 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"
_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_fence_104"
_27817_doc_fence_104_spec () ( "${1:-printf}" '~~~' )
_27817_doc_fence_104 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
Fenced Block
_27817_OUTPUT
}
# ~~~
_27817_list="${_27817_list:-}:text_107"
_27817_text_107 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

## REPL Blocks

REPL (Read-eval-print-loop) are interactive terminal sessions inside code
blocks. *runup* can parse their structure as well:


_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_repl_sample_indented_114"
_27817_ns_repl_sample_indented_114_name () ( "${1:-printf}" '' )
_27817_ns_repl_sample_indented_114 () {

cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is an indented block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"
This is an indented block
_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_repl_sample_ticked_119"
_27817_ns_repl_sample_ticked_119_name () ( "${1:-printf}" '' )
_27817_ns_repl_sample_ticked_119 () {

# Begin Fence	121	```
cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is a ticked block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"
This is a ticked block
_27817_OUTPUT
}
# ```
_27817_list="${_27817_list:-}:text_125"
_27817_text_125 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"

_27817_OUTPUT
}
_27817_list="${_27817_list:-}:ns_repl_sample_tilded_126"
_27817_ns_repl_sample_tilded_126_name () ( "${1:-printf}" '' )
_27817_ns_repl_sample_tilded_126 () {

# Begin Fence	128	~~~
cat <<'_27817_INPUT' | "${2:-cat}"
$ echo This is a tilded block
_27817_INPUT
cat <<'_27817_OUTPUT' | "${1:-cat}"
This is a tilded block
_27817_OUTPUT
}
# ~~~
_27817_list="${_27817_list:-}:text_132"
_27817_text_132 () {

cat <<'_27817_OUTPUT' | "${1:-cat}"


Source:


_27817_OUTPUT
}
_27817_list="${_27817_list:-}:doc_indent_137"
_27817_doc_indent_137 () {
cat <<'_27817_OUTPUT' | "${1:-cat}"
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
_27817_OUTPUT
}
if [ -z "${1:-}" ]; then echo "$_27817_list" | tr ':' '\n'; else _27817_${@:-}; fi
}
if [ -z "${1:-}" ]; then echo "$_27817_list" | tr ':' '\n'; else _27817_${@:-}; fi
