#!/usr/bin/env bash 
# script by cyndrdev
# depends on pgrep

compositor="compton"
pid=$(pgrep $compositor)

function notify () {
	[ "$(command -v notify-send)" ] && notify-send "$1" "$2"
}

if [ $pid ]; then
	kill -9 $pid
	notify "$compositor disabled"
else
	$compositor &
	disown
	notify "$compositor enabled"
fi
