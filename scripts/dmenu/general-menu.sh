#!/usr/bin/bash

is_service_running () {
	local user_status=`systemctl --user show $1 --property ActiveState`
	echo $user_status | cut --delimiter== --fields=2
}

ICONS_DIR=$HOME/images/icons
ICONS_PRE=IMG:$ICONS_DIR

LAMP_JEAN_ID=396211804
LAMP_STRIP_JEAN_ID=433772850
LAMP_FUNCTION=/home/sidharta/bin/xmenu/run-lamp-command

DEFAULT_EDITOR_COMMAND=code
CONFIG_WATCHER_STATUS=`is_service_running settings-watch.target`

WATCHER_LINE=
if [[ $CONFIG_WATCHER_STATUS == inactive ]] ; then
	WATCHER_LINE="$ICONS_PRE/mui/close-red.svg	Watcher Inactive	systemctl --user start settings-watch.target"
else
	WATCHER_LINE="$ICONS_PRE/mui/done-green.svg	Watcher Active	systemctl --user stop settings-watch.target"
fi

let "HUE = $RANDOM % 360"

cat <<EOF | xmenu -p 0x30 -r General | bash
$ICONS_PRE/settings.svg	Configurations
	$WATCHER_LINE
	ZSH
		Edit	$DEFAULT_EDITOR_COMMAND ~/.zshrc
	$ICONS_PRE/bspwm-logo-inverted.svg	Bspwm
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/bspwm/bspwmrc
		Docs	firefox https://github.com/baskerville/bspwm/blob/master/doc/bspwm.1.asciidoc
	Picom
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/picom/picom.conf
		Docs	firefox https://github.com/yshui/picom/blob/next/man/picom.1.asciidoc
	Sxhkd
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/sxhkd/sxhkdrc
		Docs	firefox https://github.com/baskerville/sxhkd/blob/master/doc/sxhkd.1.asciidoc
	Deadd Notification
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/deadd/deadd.conf
		Docs	firefox https://github.com/phuhl/linux_notification_center
	Rofi
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/rofi/config.rasi
		Docs	firefox https://github.com/davatorium/rofi/wiki
	$ICONS_PRE/polybar-logo-darkmode.png	Polybar
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/polybar/config.ini
		Docs	firefox https://github.com/polybar/polybar#readme
	$ICONS_PRE/mpd.png	MPD
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/mpd/mpd.conf
		Docs	firefox https://mpd.readthedocs.io/en/stable/user.html
	$ICONS_PRE/kitty-light.svg	Kitty
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/kitty/kitty.conf
		Docs	firefox https://sw.kovidgoyal.net/kitty/conf/
	Xmenu general
		Edit	$DEFAULT_EDITOR_COMMAND ~/bin/xmenu/general-menu.sh
	Xmenu systemd
		Edit	$DEFAULT_EDITOR_COMMAND ~/bin/xmenu/systemd-menu.sh
	Xresources
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/.Xresources
$ICONS_PRE/wallpaper.svg	Wallpapers
	$ICONS_PRE/random.svg	Random	~/bin/random-static-wallpaper
$ICONS_PRE/lamp.svg	Lamps
	$ICONS_PRE/ceiling.svg	Ceiling
		$ICONS_PRE/change-color.svg	Change Color
			$ICONS_PRE/white.svg	White	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_ct_abx" "[6300, \"sudden\", 30]"
			$ICONS_PRE/sexy-purple.svg	Sexy Purple	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_hsv" "[296, 100, \"sudden\", 30]"
			$ICONS_PRE/blue.svg	Blue	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_hsv" "[240, 100, \"sudden\", 30]"
			$ICONS_PRE/green.svg	Green	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_hsv" "[120, 100, \"sudden\", 30]"
			$ICONS_PRE/red.svg	Red	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_hsv" "[0, 100, \"sudden\", 30]"
			$ICONS_PRE/random.svg	Random	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_hsv" "[$HUE, 100, \"sudden\", 30]"
		$ICONS_PRE/power-on.svg	Power
			$ICONS_PRE/power-on.svg	On	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_power" "[\"on\", \"sudden\", 30, 0]"
			$ICONS_PRE/power-off.svg	Off	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_power" "[\"off\", \"sudden\", 30, 0]"
	$ICONS_PRE/down.svg	Strip
		$ICONS_PRE/change-color.svg	Change Color
			$ICONS_PRE/white.svg	White	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_ct_abx" "[6300, \"sudden\", 30]"
			$ICONS_PRE/sexy-purple.svg	Sexy Purple	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_hsv" "[296, 100, \"sudden\", 30]"
			$ICONS_PRE/blue.svg	Blue	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_hsv" "[240, 100, \"sudden\", 30]"
			$ICONS_PRE/green.svg	Green	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_hsv" "[120, 100, \"sudden\", 30]"
			$ICONS_PRE/red.svg	Red	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_hsv" "[0, 100, \"sudden\", 30]"
			$ICONS_PRE/random.svg	Random	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_hsv" "[$HUE, 100, \"sudden\", 30]"
		$ICONS_PRE/power-on.svg	Power
			$ICONS_PRE/power-on.svg	On	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_power" "[\"on\", \"sudden\", 30, 0]"
			$ICONS_PRE/power-off.svg	Off	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_power" "[\"off\", \"sudden\", 30, 0]"
	$ICONS_PRE/both.svg	Both
		$ICONS_PRE/change-color.svg	Change Color
			$ICONS_PRE/white.svg	White	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_ct_abx" "[6300, \"sudden\", 30]"
			$ICONS_PRE/sexy-purple.svg	Sexy Purple	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_hsv" "[296, 100, \"sudden\", 30]"
			$ICONS_PRE/blue.svg	Blue	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_hsv" "[240, 100, \"sudden\", 30]"
			$ICONS_PRE/green.svg	Green	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_hsv" "[120, 100, \"sudden\", 30]"
			$ICONS_PRE/red.svg	Red	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_hsv" "[0, 100, \"sudden\", 30]"
			$ICONS_PRE/random.svg	Random	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_hsv" "[$HUE, 100, \"sudden\", 30]"
		$ICONS_PRE/power-on.svg	Power
			$ICONS_PRE/power-on.svg	On	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_power" "[\"on\", \"sudden\", 30, 0]"
			$ICONS_PRE/power-off.svg	Off	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_power" "[\"off\", \"sudden\", 30, 0]"
$ICONS_PRE/power-on.svg	Power
	$ICONS_PRE/power-off.svg	Shut down	systemctl poweroff
	$ICONS_PRE/reboot.svg	Reboot	systemctl reboot
	$ICONS_PRE/suspend.svg	Suspend	systemctl suspend
EOF
