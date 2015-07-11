#!/usr/bin/env sh

. ../dispatch/dispatch.sh
. ../runup/runup/builder.sh

runup_sed="${PWD}/../runup/runup.sed"
runup_tab=$(printf '\t')

runup () {
	dispatch runup "${@:-}"
}

runup_missing () {
	runup_option_help
}

runup_option_h () {
	runup_option_help "${@:-}"
}

runup_option_V () {
	runup_option_version
}

runup_option_version () {
	echo 'prototype'
}

runup_option_help () {
	cat <<-HELP
		Usage: runup [COMMAND]

		Commands: source     [FILE]  Transforms a markdown file in code
		          statements [FILE]  Lists the code structure for the file
		          documents  [FILE]  Lists all HEREDOCS from a file
		          comments   [FILE]  Lists all generated documents for the code
		          blueprint  [FILE]  Prints the function blueprint for a file
	HELP
}

runup_context () {
	test -z "${name}" && return
	count=$((${count:-0} + 1))
	test "$(eval "${target:-:}" 2>&1)" = "${expect:-}" || printf 'not '
	echo "ok	${count} - ${name}"
	unset name target expect
}


runup_command_statements () {
	sourceargs="${@:-}"
	set --
	eval "
		set -v
		$(runup_command_source ${sourceargs})
		set +v
	" 2>&1
	set "${sourceargs}"
}

runup_command_documents () {
	runup_command_statements "${@:-}" | runup_filter_documents
}

runup_command_comments () {
	runup_command_statements "${@:-}" | sed -n '/^#/p'
}

runup_command_blueprint () {
	runup_command_statements "${@:-}" | sed -n '/() {$/p; /^}$/p;/^runup_[A-Za-z0-9_]* () (/p;'
}

runup_command_each () {
	runup_command_statements "${@:-}" >/dev/null
	for file in ${@:-}; do
		hashed="$(echo "${PWD}/${file}" | md5sum --text | sed 's/[^a-f0-9]//g')"
		runup_file_$hashed runup_prop_name
	done
}

runup_command_source () {
	[ -f "${runup_sed}" ] &&
		transpile_sed="sed -n -f" ||
		transpile_sed="sed -n" runup_sed="$(runup_builder '_r_')"

	while [ ! -z "${1:-}" ]
	do
		echo
		runup_prepare "${PWD}/${1}"
		shift
	done | ${transpile_sed} "${runup_sed}"
}

runup_command_build () {
	runup_builder
}

runup_prepare () {
	runup_filename="${1}"
	runup_hashed="$(echo "${runup_filename}" | md5sum --text | sed 's/[^a-f0-9]//g')"
	echo "0${runup_tab}${runup_hashed}${runup_tab}${runup_filename}"
	sed '=' "$runup_filename" | sed "N;s/\n/${runup_tab}/"
}


runup "${@:-}"

