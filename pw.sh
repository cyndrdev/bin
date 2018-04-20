#!/usr/bin/env bash
# script by cyndrdev

# generates secure passwords using only standard unix commands

chars="A-Za-z0-9"
default_len=32

function usage() {
    echo "usage: $(basename $0) [len]"
    [ -z "$1" ] && exit 1 || exit $1
}

case "$1" in
'')
    len=$default_len
    ;;
'--help'|'-h')
    usage 0
    ;;
*[!0-9]*)
    usage
    ;;
*)
    len=$1
    ;;
esac

[ $len -lt 13 ] && echo "`tput setaf 1`warning: password is too short to be secure`tput sgr0`";
< /dev/urandom tr -dc $chars | head -c${1:-$len};echo
