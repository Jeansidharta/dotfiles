if status is-interactive
    # Commands to run in interactive sessions can go here
	~/.login
end

function bw
    if test ! -e /tmp/bw-token
        echo 'bw locked - unlocking into a new session'
		/usr/bin/bw unlock --raw > /tmp/bw-token
    end

	export BW_SESSION="$(cat /tmp/bw-token)"
	/usr/bin/bw $argv
end

function bwy
	bw $argv | jy
end

bind \cH backward-kill-word

set --export XDG_DATA_HOME "/home/sidharta/.local/share"
set --export XDG_CONFIG_HOME "/home/sidharta/.config"
set --export XDG_STATE_HOME "/home/sidharta/.local/state"
set --export XDG_RUNTIME_DIR "/run/user/1000"
set --export XDG_DOWNLOAD_DIR "$HOME/Downloads"
set --export XDG_CACHE_HOME "$HOME/.cache"

set --export ZK_NOTEBOOK_DIR "$HOME/notes"
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
alias xclip="xclip -selection clipboard"
set fish_greeting

fish_vi_key_bindings

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.fish ]; and . ~/.config/tabtab/__tabtab.fish; or true

starship init fish | source

# opam configuration
source /home/sidharta/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/sidharta/.ghcup/bin # ghcup-env