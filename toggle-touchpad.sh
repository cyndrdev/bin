#!/usr/bin/env bash
# script by cyndrdev
# depends on xinput

device_id=$(xinput --list | grep "TouchPad" | awk '{print $6}' | sed 's/id=//')
device_state=$(xinput list-props $device_id | grep "Device Enabled" | awk '{print $4}')
let "new_state = (device_state == 1) ? 0 : 1"

xinput set-prop $device_id "Device Enabled" $new_state
