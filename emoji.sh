#!/usr/bin/env bash
# original by tadly
# depends on rofi, xsel, xdotool, xmllint and curl

# where to save the emojis file.
EMOJI_FILE="$HOME/.cache/emojis.txt"

# urls of emoji to download.
URLS=(
    'https://emojipedia.org/people/'
    'https://emojipedia.org/nature/'
    'https://emojipedia.org/food-drink/'
    'https://emojipedia.org/activity/'
    'https://emojipedia.org/travel-places/'
    'https://emojipedia.org/objects/'
    'https://emojipedia.org/symbols/'
    'https://emojipedia.org/flags/'
)


function notify() {
	[ "$(command -v notify-send)" ] && notify-send "$1" "$2"
}


function download() {
    notify `basename "$0"` 'Downloading all emoji for your pleasure'

    echo "" > "$EMOJI_FILE"

    for url in "${URLS[@]}"; do
        echo "Downloading: $url"

        # download the list of emoji and remove all the junk around it
        emojis=$(curl -s "$url" | \
                 xmllint --html \
                         --xpath '//ul[@class="emoji-list"]' - 2>/dev/null)

        # get rid of starting/closing ul tags
        emojis=$(echo "$emojis" | head -n -1 | tail -n +1)

        # extract the emoji and its description
        emojis=$(echo "$emojis" | \
                 sed -rn 's/.*<span class="emoji">(.*)<\/span> (.*)<\/a><\/li>/\1 \2/p')

        echo "${emojis,,}" >> "$EMOJI_FILE"
done

    notify `basename "$0"` "We're all set!"
}


function display() {
	emoji=$(cat "$EMOJI_FILE" | grep -v '#' | grep -v '^[[:space:]]*$')
	line=$(echo "$emoji" | rofi -dmenu -i -p emoji -kb-custom-1 Ctrl+c $@)
	exit_code=$?

	line=($line)

	if [ $exit_code == 0 ]; then
		xdotool type --clearmodifiers "${line[0]}"
	elif [ $exit_code == 10 ]; then
		echo -n "${line[0]}" | xsel -i -b
	fi
}

# some simple argparsing
if [[ "$1" =~ -D|--download ]]; then
	download
	exit 0
elif [[ "$1" =~ -h|--help ]]; then
	echo "usage: $(basename $0) [-D|--download]"
	exit 0
fi

# download all emoji if they don't exist yet
if [ ! -f "$EMOJI_FILE" ]; then
    download
fi

# display displays :)
display
