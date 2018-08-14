upower -i $(upower -e | /usr/bin/grep 'BAT') | /usr/bin/grep -E "state|to\ full|to\ empty|energy-rate|percentage"
