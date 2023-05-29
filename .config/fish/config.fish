if status is-interactive
    # Commands to run in interactive sessions can go here

	# Run a login script exactly once
	if test ! -e /tmp/login-script-executed
		touch /tmp/login-script-executed
		exec ~/.login
	end
end

bind \cH backward-kill-word

set --export XDG_DATA_HOME "/home/sidharta/.local/share"
set --export XDG_CONFIG_HOME "/home/sidharta/.config"
set --export XDG_STATE_HOME "/home/sidharta/.local/state"
set --export XDG_RUNTIME_DIR "/home/sidharta/.local/run"
set --export XDG_DOWNLOAD_DIR "$HOME/Downloads"
set --export XDG_CACHE_HOME "$HOME/.cache"

set --export ZK_NOTEBOOK_DIR "$HOME/notas"
set --export STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"
set --export STARSHIP_CACHE "$XDG_CACHE_HOME/starship"

set --export PAGER "moar"
set --export EDITOR "vim"
set --export BROWSER "firefox"
set --export NODE_OPTIONS "--openssl-legacy-provider"

set --export NVM_DIR "$XDG_CONFIG_HOME/nvm"

fish_add_path /home/sidharta/bin
fish_add_path /home/sidharta/scripts
fish_add_path /home/sidharta/.cargo/bin
fish_add_path /home/sidharta/.local/bin
fish_add_path /home/sidharta/go/bin

# funced nvm
# function nvm
#    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
# end

# if test -s "$NVM_DIR/nvm.sh"
# bass source "$NVM_DIR/nvm.sh" --no-use ';' nvm use iojs
# end
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function userSV -a dir
    begin
        set -lx SVDIR $XDG_CONFIG_HOME/runit/$dir
        set -e argv[1]
        sv $argv
    end
end

# alias ls="ls -h --color --time-style \"long-iso\""
alias ls="exa"
alias config="/usr/bin/git --git-dir=$HOME/dotfiles-repo/ --work-tree=$HOME"
alias sessionctl="systemctl --user"
set fish_greeting

fish_vi_key_bindings

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.fish ]; and . ~/.config/tabtab/__tabtab.fish; or true

starship init fish | source
