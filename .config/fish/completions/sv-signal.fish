set POSSIBLE_SIGNALS "up down once pause continue hangup alarm interrupt quit user1 user2 terminate kill exit"

function getServices;
	set RUNIT_DIR "$XDG_CONFIG_HOME/runit/services"
	ls -1 --color=never $RUNIT_DIR
end

complete -e sv-signal
complete -c sv-signal -n '__fish_is_nth_token 1' -f -a '(getServices)'
complete -c sv-signal -n '__fish_is_nth_token 2' -f -a $POSSIBLE_SIGNALS
complete -c sv-signal -n '__fish_is_nth_token 3' -f -a ''
