#!/usr/bin/bash

# If user goes into monocle mode, remove top padding (the padding is there to make room for Polybar)

monitor_layout_change () {
	bspc subscribe desktop_layout | while read event_name monitor_id desktop_id layout; do
		if [[ $layout == "tiled" ]]; then bspc config top_padding 10
		else bspc config top_padding 30
		fi
	done
}

monitor_desktop_change () {
	bspc subscribe desktop_focus | while read event_name monitor_id desktop_id; do
		layout=$(bspc query -T --desktop $desktop_id | grep monocle > /dev/null && echo "monocle" || echo "tiled")
		if [[ $layout == "tiled" ]]; then bspc config top_padding 10
		else bspc config top_padding 30
		fi
	done
}

monitor_layout_change &
monitor_desktop_change &
