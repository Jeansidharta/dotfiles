#!/bin/sh

if [ "$(tty)" = "/dev/tty1" ]; then
	if ! pgrep bspwn > /dev/null; then
		startx "/home/sidharta/.config/X11/xinitrc"
	fi
fi

