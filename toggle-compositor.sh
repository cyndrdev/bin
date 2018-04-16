#!/usr/bin/env bash 

compositor="compton"
pid=$(pgrep $compositor)

if [ $pid ]; then
	kill -9 $pid
	notify-send "$compositor disabled"
else
	compton &
	disown
	notify-send "$compositor enabled"
fi
