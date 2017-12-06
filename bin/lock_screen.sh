#!/bin/bash -e

lock_cmd="gnome-screensaver-command --lock"
set -- $lock_cmd
if command -v -- $1 > /dev/null 2>&1; then
	$lock_cmd >/dev/null 2>&1 &
	sleep 1
	xset dpms force off
fi
