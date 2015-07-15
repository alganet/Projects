#!/usr/bin/env sh

. ../dispatch/dispatch.sh
. ../runup/runup/builder.sh

runup_sed="${PWD}/../runup/runup.sed"
runup_tab=$(printf '\t')
runup_prefix=""

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
		Usage: runup source [COMMAND]

		Commands: source [FILES]       Output markdown [FILES] as code
		          list   [FILES]       Output list of resources for [FILES]
		          get    [RES] [FILES] GET resource [RES] on [FILES]
	HELP
}

runup_context () {
	test -z "${name}" && return
	count=$((${count:-0} + 1))
	test "$(eval "${target:-:}" 2>&1)" = "${expect:-}" || printf 'not '
	echo "ok	${count} - ${name}"
	unset name target expect
}


runup_command_load () {
	sourceargs="${@:-}"
	set --
	eval "$(runup_command_source ${sourceargs})" 2>&1
	set "${sourceargs}"
}

runup_command_get () {
	resource="$(echo "${1}" | tr ':' ' ')"
	[ -z "$resource" ] && return
	shift
	filelist="${@:-}"
	runup_prefix="${runup_prefix:-_${RANDOM}}${RANDOM}_"
	runup_command_load "${filelist}" >/dev/null
	set -- ${resource}
	${runup_prefix}${resource} >/dev/null
	eval "echo \$${runup_prefix}list | tr ':' '\\n'" |
	while read subitem
	do
		${runup_prefix}${subitem}
	done
}

runup_command_list () {
	filelist="${@:-}"
	runup_prefix="${runup_prefix:-_${RANDOM}}${RANDOM}_"
	runup_command_load "${filelist}" >/dev/null
	cat <<-HELP
	Usage: $0 get [RESOURCE] $@

	Resources:
	HELP
	eval "echo \$${runup_prefix}list" | tr ':' '\n' | while read item
	do
		if [ ! -z "$item" ]
		then
			case "$item" in
				file_* )
					cat <<-HELP
					  $item
					HELP
					${runup_prefix}${item} | while read subitem
					do
						cat <<-HELP
						   :$subitem
						HELP
					done
					;;
			esac
		fi
	done
}

runup_command_source () {
	if [ -f "${runup_sed}" ]
	then
		transpile_sed="sed -n -f"
	else
		transpile_sed="sed -n"
		runup_sed="$(runup_builder ${runup_prefix:-_${RANDOM}_})"
	fi

	if [ -z "${@:-}" ]
	then
		set -- $(find -name '*.md' | tr '\n' ' ')
	fi
	rescount="$#"

	while [ ! -z "${1:-}" ]
	do
		echo
		resno="$#"
		runup_prepare "${PWD}/${1}" "$(( rescount - resno ))"
		shift
	done | ${transpile_sed} "${runup_sed}"
}

runup_command_build () {
	runup_builder
}

runup_prepare () {
	runup_filename="${1}"
	runup_hashed="${2}"
	echo "0${runup_tab}${runup_hashed}${runup_tab}${runup_filename}"
	sed '=' "$runup_filename" | sed "N;s/\n/${runup_tab}/"
}


runup "${@:-}"

