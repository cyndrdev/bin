#!/usr/bin/env bash

www="http://www.dictionary.com/browse"
word="$@"

get () {
	cmd=$(curl -s "$www/$word" | grep -oP '(?<=<meta name="description" content=").*(?=See more.)' | sed "s/.*definition,/$(tput setaf 2)$word$(tput setaf 1):/")
	if [ -z "$cmd" ]; then
		echo "this word wasn't found."
		exit 1
	else
		echo $cmd
	fi
}

usage() {
	echo "usage: `basename $0` <word>"
	exit 1
}

#if [ -z "$@" ]; then
#	usage
#else
#	get
#fi

[ -z "$@" ] && usage || get
