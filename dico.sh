#!/usr/bin/env bash
# original by eti0
# depends on curl, grep and sed

www="http://www.dictionary.com/browse"
word="$@"

get () {
	output=$(
		curl -s "$www/$word" |
		grep -oP '(?<=<meta name="description" content=").*(?=See more.)' |
		sed "s/.*definition,/$(tput setaf 2)$word$(tput setaf 1):/")

	if [ -z "$output" ]; then
		echo "this word wasn't found."
		exit 1
	else
		echo $output
	fi
}

usage() {
	echo "usage: `basename $0` <word>"
	exit 1
}

[ -z "$1" ] && usage || get
