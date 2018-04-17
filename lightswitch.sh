#!/usr/bin/env bash
# script by cyndrdev
# depends on wal and bspwm

# toggles between the light and dark themes for the current wallpaper

lock="/tmp/wal_light"
if [ -f $lock ]; then
	wal -R 2>&1 >> /dev/null
	rm $lock
else
	wal -R -l 2>&1 >> /dev/null
	touch $lock
fi

. "${BSPWM_CONFIG}/bspwmrc" reload
