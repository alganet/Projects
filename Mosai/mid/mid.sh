#!/usr/bin/env sh

# Be Strict
set -euf
unsetopt NO_MATCH >/dev/null 2>&1 || :

# Load required libraries
. ${index:-..}/dispatch/dispatch.sh
. ${index:-..}/mid/parser.sh

# Setting defaults
mid_tab=$(printf '\t')
mid_parser=""

# Define the mid namespace
mid () ( dispatch mid "${@:-}" )

# What to do when command is not found
mid_missing () {
	echo "Call '${@:-[empty]}' not found. See ${0:-mid} --help"
}

# Short options
mid_option_h () ( mid_option_help "${@:-}" )
mid_option_V () ( mid_option_version )

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

	automates code blocks inside markdown blocks

	Commands:
	  list    [FILE]        Lists named block IDs for [FILE]
	  get     [FILE] [ID]   Prints block [ID] for [FILE]
	  inspect [FILE] [ID]   Shows extra info about block [ID] for [FILE]
	  source  [FILE]        Prints markdown [FILE] as executable shell
	  build                 Prints the sed parser for current env

	Options:
	  -h, --help            Displays help
	  -V, --version         Displays version info
	      --prefix=[PRE]    Set prefix [PRE] for parser
	      --parser=[SED]    Sets the [SED] file as the parser
	HELP
}

# Gets the source for a markdown file
mid_command_source () {
	mid_parse "${@:-}"
}


# Builds the parser
mid_command_build () {
	mid_parser_build "${mid_prefix}"
}

mid_command_list ()
{
	mid_load "${1:-}"

	${mid_prefix}list | sed 's/\([a-zA-Z0-9]*\)_/\1:/g'
}

mid_command_inspect ()
{
	mid_command_get "${@:-}"
}

mid_command_get ()
{
	mid_load "${1:-}"
	block_id="${2:-}"
	shell_command="$(printf "${block_id}" | tr ':' '_')"
	shift 2
	shell_args="${@:-}"
	set --
	case "${block_id}" in
		*:attr )
			${mid_prefix}${shell_command} "${shell_args:-}"
			;;
		doc:* )
			${mid_prefix}${shell_command} "${shell_args:-}"
			;;
		* )
			redir_command="$(${mid_prefix}${shell_command} "${shell_args:-}" 2>&1)"
			[ -z "$redir_command" ] || ${mid_prefix}${redir_command} "${shell_args:-}"
			;;
	esac
}

mid "${@:-}"

