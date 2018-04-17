#!/usr/bin/env bash
# script by cyndrdev
# depends on scrot

dir="$HOME/screenshots"
name="%s.png"

function notify() {
	[ "$(command -v notify-send)" ] && notify-send "$1" "$2"
}

scrot $name -e "mv \$f $dir"
sleep .3 && notify "screenshot taken."
