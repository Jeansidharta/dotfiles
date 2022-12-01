#!/bin/sh

if [ "$(tty)" = "/dev/tty1" ]; then
	if ! pgrep bspwn > /dev/null; then
		# runsvdir ~/.config/runit/onLogin &
		startx "/home/sidharta/.config/X11/xinitrc"
	fi
fi

