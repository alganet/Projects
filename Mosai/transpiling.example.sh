# Begin Stream
# Begin File
_n_Projects_Mosai_runup_runup_md () {
text_at_0 () {
# Raw Text
cat <<'OUTPUT'
runup
=====

A format and tool for running code blocks inside markdown files automatically.

--

Create a markdown-compatible document with marked code blocks:

OUTPUT
}
# End Text
file_runup_example_md () {

# Start Code Indent
cat <<'OUTPUT'
Hello from runup
================

A Hello World sample:

[ ]:real:example

```
$ echo 'Hello World'
Hello World
$ echo 'from runup'
from runup
```


OUTPUT
}
# End Output
# End Code Indent
# Begin Text
text_at_27 () {
cat <<'OUTPUT'
Now run it to see results and output:

OUTPUT
}
# End Text
real_example_main () {

# Start Code Indent
# Begin Input
cat <<'INPUT'
$ ./runup.sh run "runup_example.md"
INPUT
# End Input
# Begin Output
cat <<'OUTPUT'
ok	- my runup Script
#	Hello World
#	from runup
OUTPUT
# End Output
# Begin Input
cat <<'INPUT'
$ echo 3
INPUT
# End Input
# Begin Output
cat <<'OUTPUT'
3
OUTPUT
# End Output
}
# End Code Indent
# End File
}
# End Stream
