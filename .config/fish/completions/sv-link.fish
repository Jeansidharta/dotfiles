set POSSIBLE_CONTEXTS "service x boot start demand predify-root"

function getServices;
	if commandline -pc | grep "service"
		set RUNIT_DIR "/etc/sv"
	else
		set RUNIT_DIR "$XDG_CONFIG_HOME/runit/services"
	end
	ls -1 --color=never $RUNIT_DIR
end

complete -e sv-link
complete -c sv-link -n '__fish_is_nth_token 1' -f -a $POSSIBLE_CONTEXTS
complete -c sv-link -n '__fish_is_nth_token 2' -f -a '(getServices)'
complete -c sv-link -n '__fish_is_nth_token 3' -f -a ''
