#!/bin/sh
gconftool-2 -s /desktop/gnome/session/required_components/windowmanager xmonad --type string
echo "Log out and back in to use new WM."
