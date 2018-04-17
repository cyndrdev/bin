#!/usr/bin/env bash
# sript by cyndrdev
# depends on betterdiscord, wal, xrandr and imagemagick

# discord theme by WhatTDaPuck

bg=$(cat "$HOME/.cache/wal/wal")
bg_tmp=$(mktemp tmp.XXXXXXXX.jpg -p /tmp)
theme="wal.theme.css"

function get_screen_dims(){
	xrandr | grep '*' | grep -Eo '^\s.*\s' | tr -d '[:space:]'
}

function convert_bg(){
	[ "$1" = "blur" ] && blur=2 || blur=0
	convert $bg -resize "$(get_screen_dims)^" $bg_tmp
	convert $bg_tmp -gravity center -crop $(get_screen_dims)+0+0 -blur $blur,$blur $bg_tmp
}

function reload_discord(){
	#kill -USR1 $(pgrep Discord | tail -n 1)
	sleep 0
}

if [ -f "$bg" ]; then
	convert_bg $1
	data=$(base64 --wrap=0 $bg_tmp)

	cd "$(dirname $0)"

	cat head > $theme
	echo "    background: url(data:image/jpg;base64,$data) !important;" >> $theme
	cat tail >> $theme
	rm $bg_tmp
	reload_discord
fi
