#!/usr/bin/env sh

. ../dispatch/dispatch.sh
. ../runup/runup/builder.sh

runup_sed="${PWD}/../runup/runup.sed"
runup_tab=$(printf '\t')
runup_prefix="_r_"

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
		Usage: runup source [FILES]  Output markdown [FILES] as code
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
	eval "
		set -v
		$(runup_command_source ${sourceargs})
		set +v
	" 2>&1
	set "${sourceargs}"
}

runup_command_source () {
	if [ -f "${runup_sed}" ]
	then
		transpile_sed="sed -n -f"
	else
		transpile_sed="sed -n"
		runup_sed="$(runup_builder $runup_prefix)"
	fi

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

