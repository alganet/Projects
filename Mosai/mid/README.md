**mid** allows you to reuse code blocks from Markdown documentation!

---

It introduces the *annotation*:

[~]:file (HELLO.md)

    [~]:example:hello (An annotated code block!)
    ```sh
    echo Hello
    ```

Annotations are cool because they are:

  - Small simple one-liners for technical documents.
  - Invisible to the HTML output. Only the code block will appear.
  - Backwards-compatible with the [original Markdown](http://daringfireball.net/projects/markdown) and [CommonMark](http://commonmark.org/).

---

You can interact with annotated blocks using the **mid** tool:

[~]:example

    $ mid list HELLO.md

        example:hello
        doc:fence:2
    $ mid open HELLO.md example:hello
