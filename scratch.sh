#!/usr/bin/env bash
# script by cyndrdev
# depends on xprop, awk and xdo

# creates a scratchpad terminal that can be toggled

term="urxvt"

id=$(xdo id -n scratch);
if [ -z "$id" ]; then
	$term -name scratch &
else
	if [[ $(xprop -id $id | awk '/window state: / {print $3}') != 'Withdrawn' ]]; then
		xdo hide -n scratch
	else
		xdo show -n scratch
	fi
fi
