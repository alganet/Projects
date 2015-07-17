#!/usr/bin/env sh

# Define the eremita namespace
export eremita="${eremita:-$(cd "$(dirname "$0")";pwd)}"

# Load required libraries
. "${eremita}/../dispatch/dispatch.sh"

# Main function and namespace, dispatches calls to others
eremita () {
	dispatch eremita "${@:-}"
}

# Function called by the dispatch library when no namespace is found
eremita_missing () {
	echo "Call '${@:-}' not found."
}

# Short help function (eremita -h)
eremita_option_h () {
	eremita_option_help
}

# Long help function (eremita --help)
eremita_option_help () {
	cat <<-HELP
	Usage: eremita [OPTIONS] [COMMANDS]

	eremita is a POSIX Shell Script namespace and loading convention.

	Commands: eremita open [TARGET]  Opens a target namespace
	          eremita list           Lists current available libraries

	Options: --help      | -h  Displays this text and exit
	         --version   | -V  Displays version info and exit
	         --verbose   | -v  Enables verbose mode
	HELP
}

eremita_command_list () {
	find "$(cd "${eremita}/..";pwd)" -name "*.sh"   |
		while read sibling; do
			libname="$(printf %s "$sibling" |
				   sed 's,.*/\(.*\).sh,\1,')"
			libdir="$(printf %s "$sibling"  |
				  sed 's,/[^/]*$,,;s,.*/,,')"
			[ "$libname" = "$libdir" ] && echo "$libname"
		done
}

# Open a namespace (eremita open mylib)
eremita_command_open () {
	target="${1:-}"               # Keep target name

	[ -z "${target}" ]           &&   # If no target...
		eremita_command_list &&   # ...show list...
		return                    # ...and exit.

	shift                         # Remove first argument
	args="${@:-}"                 # Store current arguments
	current="$(pwd)"              # Store current folder
	set --                        # Remove arguments
	cd "${eremita}"               # Change into eremita folder
	[ -z "${target}" ] && return
	. "../${target}/${target}.sh" # Load target source
	cd "${current}"               # Back to stored folder
	"${target}" "${args}"         # Open target
	unset current args target     # Remove variables
}

eremita "${@:-}"
