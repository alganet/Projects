#!/usr/bin/env sh

# Define the mid namespace
mid () ( dispatch mid "${@:-}" )

# Load required libraries
. ../dispatch/dispatch.sh
. ../mid/parser.sh

# Setting defaults
mid_tab=$(printf '\t')
mid_prefix="md_"
mid_parser=""
mid_env="/usr/bin/env sh"

# What to do when command is not found
mid_missing () {
	echo "Call '${@:-[empty]}' not found. See ${0:-mid} --help"
}

# Short options
mid_option_h () ( mid_option_help "${@:-}" )
mid_option_V () ( mid_option_version )
mid_option_p () ( mid_option_version )

# Long Options
mid_option_version () {
	echo 'prototype'
}

mid_option_prefix () {
	export mid_prefix="${1:-${mid_prefix}}"
	shift
	dispatch mid "${@:-}"
}

mid_option_parser () {
	export mid_parser="${1:-}"
	shift
	dispatch mid "${@:-}"
}

mid_option_help () {
	cat <<-HELP
	Usage: mid [OPTIONS] [COMMAND]

	mid

	Commands: source  [FILE]  Prints markdown [FILE] as executable shell
	          list    [FILE]  Lists named blocks for [FILE]
	          inspect [FILE]  Lists all blocks for [FILE]
	          build           Outputs sed parser for current env

	Options:  -h, --help           Displays help
	          -V, --version        Displays version info
	              --prefix=[PRE]   Set prefix [PRE] for parser
	              --parser=[SED] Sets the [SED] file as the parser
	HELP
}

mid_named           () ( sed -n '/^doc_/!p' )
mid_command_inspect () ( mid_parser_do "${1:-}" list )
mid_command_list    () ( mid_parser_do "${1:-}" list | mid_named )
mid_command_open    () ( mid_parser_do "${1:-}" open )

# Gets the source for a markdown file
mid_command_source () {
	transpile_sed="sed -n"
	mid_sed="$(mid_parser_build ${mid_prefix})"
	if [ -f "${mid_parser}" ]
	then
		transpile_sed="sed -n -f"
		mid_sed="${mid_parser}"
	fi

	if [ -f "${1:-}" ]
	then
		mid_prepare "${PWD}/${1}" | ${transpile_sed} "${mid_sed}"
	fi
}


# Builds the parser
mid_command_build () {
	mid_parser_build "${mid_prefix}"
}


mid "${@:-}"

