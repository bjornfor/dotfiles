#!/bin/sh

#
# .xinitrc
#
# Executed by startx (run your window manager from here)

#setxkbmap no
#unclutter &

#xmodmap ~/.Xmodmap

# set the cursor, most useful with xmonad (which does not set the cursor)
#xsetroot -cursor_name left_ptr
#exec ck-launch-session xmonad

# ck-launch-session is needed if you want the DE to shutdown and/or reboot the
# machine. Also, HAL must be running an you probably must be in the 'power'
# group. That is, instead of just 'startxfce4', use 'ck-launch-session
# startxfce4'.

# The following variable defines the session which is started if the user doesn't explicitly select a session

DEFAULT_SESSION=startxfce4

case $1 in
kde)
	exec ck-launch-session startkde
	;;
gnome)
	exec ck-launch-session gnome-session
	;;
xfce4)
	exec ck-launch-session startxfce4
	;;
icewm)
	icewmbg &
	icewmtray &
	exec icewm
	;;
wmaker)
	exec wmaker
	;;
blackbox)
	exec blackbox
	;;
*)
	exec ck-launch-session $DEFAULT_SESSION
	;;
esac
