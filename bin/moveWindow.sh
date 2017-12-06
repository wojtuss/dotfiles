#!/bin/bash
#
# Move the current window to the left (0) or right (1) monitor.
# Usage: e.g.
# moveWindow.sh 0

displays=(0 1 2)
widths=(1920 1200 1920)
xoffsets=(0 1920 3120)

# Get info about the active window
window_id=`xdotool getactivewindow`
window_width=`xwininfo -id $window_id | awk '/Width:/ { print $2 }'`

# Remember if it was maximized.
window_state=`xprop -id $window_id _NET_WM_STATE`

# Un-maximize current window so that we can move it
wmctrl -ir $window_id -b remove,maximized_vert,maximized_horz

# Read window position
x=`xwininfo -id $window_id | awk '/Absolute upper-left X:/ { print $4 }'`
y=`xwininfo -id $window_id | awk '/Absolute upper-left Y:/ { print $4 }'`

# Subtract any offsets caused by panels or window decorations
x_offset=`xwininfo -id $window_id | awk '/Relative upper-left X:/ { print $4 }'`
y_offset=`xwininfo -id $window_id | awk '/Relative upper-left Y:/ { print $4 }'`
x=`expr $x - $x_offset`
y=`expr $y - $y_offset`

# Calculate the middle of the window
xmid=`expr $x + $window_width / 2`

# Get current display
if [ "$xmid" -le "${xoffsets[1]}" ]
then
	display=0
elif [ "$xmid" -le "${xoffsets[2]}" ]
then
	display=1
else
	display=2
fi

# Get next display's width
if [ "$1" -eq "0" ]
then
	next_display=`expr $(( ($display + 3 - 1) % 3 ))`
else
	next_display=`expr $(( ($display + 3 + 1) % 3 ))`
fi

xmidlocal=`expr $xmid - ${xoffsets[$display]}`

# Compute new X position
new_xmid=`expr $(( ($xmidlocal * ${widths[$next_display]}) / ${widths[$display]} + ${xoffsets[$next_display]} ))`
new_x=`expr $(( $new_xmid - ($window_width / 2) ))`

# Compute new Y position
if [ "$y" -le "330" ]
then
	new_y=330
else
	new_y=$y
fi

# Don't move off the left side.
if [ $new_x -lt 0 ]; then
  new_x=0
fi

# Move the window
xdotool windowmove $window_id $new_x $new_y

# Maximize window again, if it was before
if [[ $window_state == *_NET_WM_STATE_MAXIMIZED_HORZ*_NET_WM_STATE_MAXIMIZED_VERT* ]]; then
  wmctrl -ir $window_id -b add,maximized_horz,maximized_vert
fi



