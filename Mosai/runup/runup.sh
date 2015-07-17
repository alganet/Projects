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
		Usage: $0 source [COMMAND]

		Commands: source [FILES]  Prints markdown [FILES] as code
		          list   [FILES]  Output a list of [FILES] resources


		Examples: $0 source FILE.md | sh file_0
		          $0 list FILE.md
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

runup_command_list () {
	filelist="${@:-}"
	runup_prefix="${runup_prefix:-_${RANDOM}}${RANDOM}_"
	runup_command_load "${filelist}" >/dev/null
	eval "echo \$${runup_prefix}list" |
	tr ':' '\n' | while read item
	do
		if [ ! -z "$item" ]
		then
			printf "${item}: "
			${runup_prefix}${item} >/dev/null
			${runup_prefix}${item}_path echo
			eval "echo \$${runup_prefix}list" |
			tr ':' '\n' |
			while read subitem
			do
				case "${subitem}" in
					ns_* )
						printf "${runup_tab}${subitem}: "
						${runup_prefix}${subitem}_name
						echo
					;;
					doc_fence*  )
						printf "${runup_tab}${subitem}: "
						${runup_prefix}${subitem}_spec
						echo
					;;
					doc_*  )
						echo "${runup_tab}${subitem}"
					;;
				esac
			done
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

	if [ -z "${1:-}" ]
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

