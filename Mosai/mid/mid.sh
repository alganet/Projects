#!/usr/bin/env sh

# Define the mid namespace
mid () ( dispatch mid "${@:-}" )

# Load required libraries
. ../dispatch/dispatch.sh
. ../mid/parser.sh

# Setting defaults
mid_tab=$(printf '\t')
mid_parser=""

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

	Commands: source  [FILE]         Prints markdown [FILE] as executable shell
	          list    [FILE]         Lists named [BLOCK]s for [FILE]
	          open    [FILE] [BLOCK] Prints [BLOCK] for [FILE]

	Options:  -h, --help           Displays help
	          -V, --version        Displays version info
	              --prefix=[PRE]   Set prefix [PRE] for parser
	              --parser=[SED] Sets the [SED] file as the parser
	HELP
}

mid_named           () ( sed -n '/^doc_/!p' )
mid_command_inspect () ( mid_parser_do list "${@:-}" )
mid_command_list    () ( mid_parser_do list "${@:-}" | mid_named )
mid_command_open    () ( mid_parser_do open "${@:-}" )

# Gets the source for a markdown file
mid_command_source () {
	mid_parse "${@:-}"
}


# Builds the parser
mid_command_build () {
	mid_parser_build "${mid_prefix}"
}

mid_action_list ()
{
	cat <<-SHELL
		echo "\${${mid_prefix}list}" | sed 's/\([a-zA-Z0-9]*\)_/\1:/g'
	SHELL
}

mid_action_open ()
{
	maincall="${1:-}"
	maincommand="$(printf "${maincall}" | tr ':' '_')"
	shift
	mainargs="${@:-}"
	set --
	case "${maincall}" in
		doc:* )
			cat <<-SHELL
				"${mid_prefix}${maincommand}" "${mainargs:-}" 2>/dev/null
			SHELL
			;;
		* )
			cat <<-SHELL
				"${mid_prefix}${maincommand}" "${mainargs:-}" 2>/dev/null
			SHELL
			;;
	esac
}

mid "${@:-}"

