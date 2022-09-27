if status is-interactive
    # Commands to run in interactive sessions can go here
end

bind \cH backward-kill-word

set --export XDG_DATA_HOME "/home/sidharta/.local/share"
set --export XDG_CONFIG_HOME "/home/sidharta/.config"
set --export XDG_STATE_HOME "/home/sidharta/.local/state"
set --export XDG_RUNTIME_DIR "/home/sidharta/.local/run"
set --export XDG_DOWNLOAD_DIR "$HOME/Downloads"

fish_add_path /home/sidharta/bin
fish_add_path /home/sidharta/scripts
fish_add_path /home/sidharta/.cargo/bin
fish_add_path /home/sidharta/.npm/global/bin
fish_add_path /home/sidharta/go/bin

function userSV -a dir
    begin
        set -lx SVDIR $XDG_CONFIG_HOME/runit/$dir
        set -e argv[1]
        sv $argv
    end
end

alias bootsv="userSV onBoot"
alias startsv="userSV onStart"
alias xsv="userSV onXSession"
alias ls="ls -h --color --time-style \"long-iso\""
alias config="/usr/bin/git --git-dir=$HOME/dotfiles-repo/ --work-tree=$HOME"
set fish_greeting

fish_vi_key_bindings
