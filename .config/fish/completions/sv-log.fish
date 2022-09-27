function getServices;
	ls -1 --color=never "$XDG_CONFIG_HOME/runit/onXSession"
	ls -1 --color=never "$XDG_CONFIG_HOME/runit/onStart"
	ls -1 --color=never "$XDG_CONFIG_HOME/runit/onBoot"
	ls -1 --color=never "$XDG_CONFIG_HOME/runit/onDemand"
	ls -1 --color=never "$XDG_CONFIG_HOME/runit/onDemand"
	# ls -1 --color=never "/var/service"
end

complete -e sv-log
complete -c sv-log -n '__fish_is_nth_token 1' -f -a '(getServices)'
complete -c sv-log -n '__fish_is_nth_token 2' -f -a ''
