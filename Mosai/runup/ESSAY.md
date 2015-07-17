Reusing Code Inside Markdown Documents
======================================

An essay about reusing code inside Markdown documents.

Introduction
------------

Markdown is focused on simplicity. Using it for code instructions,
samples and snippets might be good for writing, but it isn't very
good for reuse. Snippets often cannot be run and code inside
documents remains dead.

By making Markdown code blocks runnable, we enable users to execute its
snippets using the command line. The same document containing prose
and code can be reused for both HTML rendering and task running.

Parsing Requirements
--------------------

Markdown writing has been very permissive since its origins. Although
efforts such as the CommonMark specification added an optional normative
layer upon the standard, its implementors had been oriented towards
robustness (in the sense that implementations are often loose on its
input rules).

Popular ways of expressing code using markdown writing are:

  - **Plain Code**: Just plain code inside a fence or indented block.

  Indent blocks may have four spaces or a tab, fences may be delimited
  by ````` or `~~~`.

  ```
  echo 'Hello'
  ```

  - **Marked Code**: Code inside a fence with its language tag.

  Markings often are added after the fence opening `~~~sh`

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

Interface Requirements
----------------------


Usability Requirements
----------------------

Performance Requirements
------------------------

Arquitecture Overview
---------------------

Related Work
------------
