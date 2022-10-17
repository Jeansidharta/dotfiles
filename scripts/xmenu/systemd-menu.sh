#!/usr/bin/bash

get_unit_status () {
	systemctl --user show $1 --property ActiveState | cut --delimiter== --fields=2
}

get_status_image () {
	if [[ $1 == inactive ]]; then
		echo "IMG:$HOME/images/icons/mui/close-red.svg"
	elif [[ $1 == failed ]]; then
		echo "IMG:$HOME/images/icons/mui/close-red.svg"
	else
		echo "IMG:$HOME/images/icons/mui/done-green.svg"
	fi
}

make_unit_menu_item () {
	local unit_name=$1
	local status=`get_unit_status $unit_name`
	local image=`get_status_image $status`
	cat <<EOF
$image	$unit_name
	$status
	
	Edit	$DEFAULT_EDITOR_COMMAND $SYSTEMD_USER_DIR/$unit_name
	Start	systemctl --user start $unit_name
	Stop	systemctl --user stop $unit_name
	Restart	systemctl --user restart $unit_name
EOF
}

DEFAULT_EDITOR_COMMAND=code

SYSTEMD_USER_DIR=$HOME/.config/systemd/user
SYSTEMD_USER_SERVICES=`find $SYSTEMD_USER_DIR -maxdepth 1 -type f -printf "%f\n" | sort`

FORMATED_SERVICES=`echo "$SYSTEMD_USER_SERVICES" | while read unit_name; do
	make_unit_menu_item $unit_name
done;`

cat <<EOF | xmenu -p 50x30 -r Home | zsh
New File
	xsession dependant	cat $HOME/.config/systemd/templates/xsession-dependant.service | $DEFAULT_EDITOR_COMMAND - $SYSTEMD_USER_DIR/new-service.service
	settings-watch dependant	cat $HOME/.config/systemd/templates/settings-watch-dependant.service | $DEFAULT_EDITOR_COMMAND - $SYSTEMD_USER_DIR/new-service.service
Daemon Reload	systemctl --user daemon-reload

$FORMATED_SERVICES
EOF