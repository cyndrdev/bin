#!/usr/bin/env bash
# depends on pgrep and cmus

# launches cmus in a screen, or re-attaches to the cmus screen if it's already running.

if [ -v $(pgrep cmus) ]; then
    screen -S cmus /bin/cmus
else
    screen -q -r -D cmus
fi
