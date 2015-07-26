index_loader ()
{
	target="${1:-}"               # Keep target name

	[ -z "${target}" ]           &&   # If no target...
		index_command_list   &&   # ...show list...
		return                    # ...and exit.

	orig_args="${@:-}"
	shift                         # Remove first argument
	args="${@:-}"                 # Store current arguments
	current="$(pwd)"              # Store current folder
	set --                        # Remove arguments
	cd "${index}/${target}"       # Change into index folder
	[ -z "${target}" ] && return
	. "${target}.sh" # Load target source
	cd "${current}"               # Back to stored folder
	"${target}" "${args}"         # Open target
	unset current args target     # Remove variables
}
