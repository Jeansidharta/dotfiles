#!/bin/bash

# Update bspwm whenever this file changes
CONFIG_PATH=$1
SET_COMMAND=$2

echo "Listening for changes at $CONFIG_PATH"
inotifywait -mqe close_write $CONFIG_PATH | \
while read file_path file_event; do
	echo "File \"$CONFIG_PATH\" changed. Running command \"$SET_COMMAND\""
	echo $SET_COMMAND | /bin/bash

	# Prevents command from running too many times
	sleep 1
	while read -r -t 0; do read; done
done

