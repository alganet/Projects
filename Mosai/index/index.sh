 #!/usr/bin/env sh

# Define the index namespace
index="${index:-$(cd "$(dirname "$0")";pwd)}/.."

# Load required libraries
. ${index:-..}/dispatch/dispatch.sh
. ${index:-..}/index/loader.sh

# Main function and namespace, dispatches calls to others
index () {
	dispatch index "${@:-}"
}

# Function called by the dispatch library when no namespace is found
index_missing () {
	echo "Call '${@:-}' not found."
}

# Short help function (index -h)
index_option_h () {
	index_option_help
}

# Long help function (index --help)
index_option_help () {
	cat <<-HELP
	Usage: index [OPTIONS] [COMMANDS]

	Loads shell script libraries by convention.

	Commands:
	  open [TARGET]  Opens a target library.
	  list           Lists current available libraries.
	  hook [NAME]    Hooks 'index open' on your terminal to
	                         the [NAME] command of your choice.

	Options:
	  -h, --help     Displays this text and exit
	  -V, --version  Displays version info and exit
	HELP
}

index_command_list () {
	find "$(cd "${index}/..";pwd)" -name "*.sh"   |
		while read sibling; do
			libname="$(printf %s "$sibling" |
				   sed 's,.*/\(.*\).sh,\1,')"
			libdir="$(printf %s "$sibling"  |
				  sed 's,/[^/]*$,,;s,.*/,,')"
			[ "$libname" = "$libdir" ] && echo "$libname"
		done
}

# Open a namespace (index open mylib)
index_command_open () {
	index_loader "${@:-}"
}

index_command_hook () {
	# TODO check sanity for argument 1 to prevent shellshocking
	echo eval "${1:-index} () ( ${index}/index.sh open "\${@:-}")"
}

index "${@:-}"
