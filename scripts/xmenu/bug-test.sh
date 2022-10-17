#!/usr/bin/bash
cat <<EOF | xmenu -p 0x30 -r General | bash
Configurations
	$WATCHER_LINE
	Bspwm
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/bspwm/bspwmrc
		Docs	firefox https://github.com/baskerville/bspwm/blob/master/doc/bspwm.1.asciidoc
	Picom
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/picom/picom.conf
		Docs	firefox https://github.com/yshui/picom/blob/next/man/picom.1.asciidoc
	Sxhkd
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/sxhkd/sxhkdrc
		Docs	firefox https://github.com/baskerville/sxhkd/blob/master/doc/sxhkd.1.asciidoc
	Polybar
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/polybar/config.ini
		Docs	firefox https://github.com/polybar/polybar#readme
	MPD
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/mpd/mpd.conf
		Docs	firefox https://mpd.readthedocs.io/en/stable/user.html
	Xmenu general
		Edit	$DEFAULT_EDITOR_COMMAND ~/bin/xmenu/general-menu.sh
	Xmenu systemd
		Edit	$DEFAULT_EDITOR_COMMAND ~/bin/xmenu/systemd-menu.sh
	Xresources
		Edit	$DEFAULT_EDITOR_COMMAND ~/.config/.Xresources
Wallpapers
	Random	~/bin/random-wallpaper
Lamps
	⬆ Ceiling
		Change Color
			White	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_ct_abx" "[6300, \"sudden\", 30]"
			Sexy Purple	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_hsv" "[296, 100, \"sudden\", 30]"
			Blue	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_hsv" "[240, 100, \"sudden\", 30]"
			Green	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_hsv" "[120, 100, \"sudden\", 30]"
			Red	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_hsv" "[0, 100, \"sudden\", 30]"
			Random	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_hsv" "[$HUE, 100, \"sudden\", 30]"
		Power
			⏻	On	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_power" "[\"on\", \"sudden\", 30, 0]"
			⏼	Off	$LAMP_FUNCTION "[$LAMP_JEAN_ID]" "set_power" "[\"off\", \"sudden\", 30, 0]"
	⬇ Strip
		Change Color
			White	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_ct_abx" "[6300, \"sudden\", 30]"
			Sexy Purple	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_hsv" "[296, 100, \"sudden\", 30]"
			Blue	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_hsv" "[240, 100, \"sudden\", 30]"
			Green	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_hsv" "[120, 100, \"sudden\", 30]"
			Red	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_hsv" "[0, 100, \"sudden\", 30]"
			Random	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_hsv" "[$HUE, 100, \"sudden\", 30]"
		Power
			⏻	On	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_power" "[\"on\", \"sudden\", 30, 0]"
			⏼	Off	$LAMP_FUNCTION "[$LAMP_STRIP_JEAN_ID]" "set_power" "[\"off\", \"sudden\", 30, 0]"
	Both
		Change Color
			White	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_ct_abx" "[6300, \"sudden\", 30]"
			Sexy Purple	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_hsv" "[296, 100, \"sudden\", 30]"
			Blue	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_hsv" "[240, 100, \"sudden\", 30]"
			Green	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_hsv" "[120, 100, \"sudden\", 30]"
			Red	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_hsv" "[0, 100, \"sudden\", 30]"
			Random	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_hsv" "[$HUE, 100, \"sudden\", 30]"
		Power
			⏻	On	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_power" "[\"on\", \"sudden\", 30, 0]"
			⏼	Off	$LAMP_FUNCTION "[$LAMP_JEAN_ID, $LAMP_STRIP_JEAN_ID]" "set_power" "[\"off\", \"sudden\", 30, 0]"
⏻ Power
	⏻	Shut down	systemctl poweroff
	⏼	Reboot	systemctl reboot
	⤶	Suspend	systemctl suspend
EOF