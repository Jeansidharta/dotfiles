# BATATA=0
# while true; do
# 	BATATA=$(($BATATA + 1))
# 	echo "$BATATA"
# 	sleep 1
# done

getDesktopLayout () {
	local desktop_raw_state=$(bspc query -T --desktop focused)
	if echo $desktop_raw_state | grep monocle > /dev/null; then
		echo "monocle"
	else
		echo "tiled"
	fi
}

# echo $(getDesktopLayout)

bspc subscribe desktop_layout | while read event_name monitor_id desktop_id layout; do
	if [[ $layout == "monocle" ]]; then
		echo "Monocle"
	else
		echo "Tiled"
	fi
done