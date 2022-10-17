set POSSIBLE_CONTEXTS "service x boot login demand predify-root"

function getServices;
	set -l CONTEXT $(__fish_nth_token 1)

	switch $CONTEXT
		case "x"
			set SERVICE_PATH "$XDG_CONFIG_HOME/runit/onXSession/"
		case "boot"
			set SERVICE_PATH "$XDG_CONFIG_HOME/runit/onBoot/"
		case "login"
			set SERVICE_PATH "$XDG_CONFIG_HOME/runit/onLogin/"
		case "demand"
			set SERVICE_PATH "$XDG_CONFIG_HOME/runit/onDemand/"
		case "predify-root"
			set SERVICE_PATH "$XDG_CONFIG_HOME/runit/onDemandPredifyRoot/"
		case "service"
			set SERVICE_PATH "/var/service/"
	end

	if test -n "$SERVICE_PATH"
		ls -1 --color=never $SERVICE_PATH
	end
end

complete -e sv-unlink
complete -c sv-unlink -n '__fish_is_nth_token 1' -f -a $POSSIBLE_CONTEXTS
complete -c sv-unlink -n '__fish_is_nth_token 2' -f -a '(getServices)'
complete -c sv-unlink -n '__fish_is_nth_token 3' -f -a ''
