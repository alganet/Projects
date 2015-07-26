# Handling Empty Documents

When processing source, an empty document should render a standard
empty output.

[~]:test

    $ rm EMPTY.md       # Removing any previous test files
    $ touch EMPTY.md    # Create an empty file
    $ mid.sh source EMPTY.md > EMPTY.md.sh
    $ cat EMPTY.md.sh   # No output

[~]:test

    $ rm EMPTY.md       # Removing any previous test files
    $ touch EMPTY.md    # Create an empty file
    $ mid.sh source EMPTY.md > EMPTY.md.sh
    $ cat EMPTY.md.sh   # No output

[~]:test

    $ rm EMPTY.md       # Removing any previous test files
    $ touch EMPTY.md    # Create an empty file
    $ mid.sh source EMPTY.md > EMPTY.md.sh
    $ cat EMPTY.md.sh   # No output


