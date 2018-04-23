#!/usr/bin/env bash
# script by cyndr

# copies directories or files into your dotfiles repo, removing any dots in front of dirs/files

# ===== SCRIPT CONFIG ===== #
# dirs to be copied from your config dir
declare -a config_paths=(
    "bspwm"
    "dunst"
    "nvim"
    "polybar"
    "rofi"
    "sxhkd"
)

# paths to be copied from your home dir
declare -a home_paths=(
    ".bashrc"
    ".zsh-custom"
    ".zshrc"
    ".xonshrc"
)

# the location of your dotfiles repo
dotfiles=$HOME/.dotfiles

# ===== SCRIPT BODY ====== #
config=${XDG_CONFIG_HOME:-$HOME/.config}

function print_status(){
    terminal=`tty`
    width=$(stty -a <"$terminal" | grep -Po '(?<=columns )\d+')
    width=$(expr $width - 5)
    printf "%-${width}s" "$1"
}

function print_done(){
    echo "done."
}

function smart_copy(){
    from=$1

    [ -z "$2" ] && target=$(basename $from) || target=$2
    [ ${target:0:1} == "." ] && target=${target:1}

    unset dir
    [ -d "$from" ] && dir="/"

    [ "$from" == "$target" ] \
        && print_status "copying ${from}${dir} to dotfiles..." \
        || print_status "copying ${from}${dir} as ${target}${dir} to dotfiles..."

    if [ -v $dir ]; then
        cp $from $dotfiles/$target
    else
        mkdir -p $dotfiles/$target
        cp -R $from/* $dotfiles/$target
    fi

    print_done
}

for i in "${config_paths[@]}"; do
    smart_copy $config/$i
done

for i in "${home_paths[@]}"; do
    smart_copy $HOME/$i
done
