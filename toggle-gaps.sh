#!/usr/bin/env bash
# script by cyndrdev
# depends on polybar & bspwm

# toggles offsets on polybar and gaps in bspwm simultaneously.

config="${XDG_CONFIG_HOME:-$HOME/.config}/polybar"

mainconfig="${config}/geometry"
gapconfig="${config}/geometry-gaps"
flatconfig="${config}/geometry-flat"

gapsize=30
bordersize=5

function usage () {
	echo "usage: $(basename $0) (gaps|flat)"
	exit 1
}

if [ -z "$1" ]; then
	[ "$(readlink -f $mainconfig)" = $gapconfig ] && has_gaps=1 || has_gaps=0
	[ $has_gaps = 0 ] && newconfig=$gapconfig || newconfig=$flatconfig
	[ $has_gaps = 0 ] && newgaps=$gapsize || newgaps=0
else
	case "$1" in
	"gaps")
		newconfig=$gapconfig
		newgaps=$gapsize
		;;
	"gapless"|"flat")
		newconfig=$flatconfig
		newgaps=0
		;;
	*)
		usage
		return 1
		;;
	esac
fi

rm $mainconfig
ln -s $newconfig $mainconfig

bspc config top_padding $(expr $gapsize + $bordersize + $newgaps)
pkill -USR1 -x polybar
bspc config window_gap $newgaps
