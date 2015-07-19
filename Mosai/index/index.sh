#!/usr/bin/env sh

# Define the index namespace
export index="${index:-$(cd "$(dirname "$0")";pwd)}"

# Load required libraries
. "${index}/../dispatch/dispatch.sh"

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

	index is a POSIX Shell Script namespace and loading convention.

	Commands: index open [TARGET]  Opens a target namespace
	          index list           Lists current available libraries

	Options: --help      | -h  Displays this text and exit
	         --version   | -V  Displays version info and exit
	         --verbose   | -v  Enables verbose mode
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
	target="${1:-}"               # Keep target name

	[ -z "${target}" ]           &&   # If no target...
		index_command_list &&   # ...show list...
		return                    # ...and exit.

	orig_args="${@:-}"
	shift                         # Remove first argument
	args="${@:-}"                 # Store current arguments
	current="$(pwd)"              # Store current folder
	set --                        # Remove arguments
	cd "${index}"                 # Change into index folder
	[ -z "${target}" ] && return
	. "../${target}/${target}.sh" # Load target source
	cd "${current}"               # Back to stored folder
	"${target}" "${args}"         # Open target
	unset current args target     # Remove variables
}

index "${@:-}"
