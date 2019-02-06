#!/usr/bin/env bash
# Manage dotfile symlinks.
#
# Usage:
#   dotfiles.sh [install|remove|list|howto]
#
# When called with no arguments, print help text.

dotfiles="
.bash_aliases
.ctags
.gdbinit
.gitconfig
.hgrc
.muttrc
.offlineimaprc
.pentadactylrc
.signature
.tigrc
.tmux.conf
.vimperatorrc
.vimrc
.xmonad
"

##for dotfile in $(ls -1 .*); do
#for dotfile in $(find . -maxdepth 1 -type f -name ".*"); do
#	echo "ln -sr $PWD/$dotfile $HOME"
#done

prog=$0
path=$(dirname "$prog")
base=$(basename "$prog")
cd "$path" > /dev/null
#echo -e "base: $base\npath: $path\nprog: $prog\nPWD: $PWD\n"

usage()
{
	cat << EOF
Usage:
  $prog [install|remove|list|howto]

install  - install dotfile symlinks (first: move any existing DOTFILE to DOTFILE.orig)
remove   - remove dotfile symlinks
list     - list installed (and not installed) dotfile symlinks
howto    - print commands that install would do (great for manual installation)
EOF
}

do_howto()
{
	for file in $dotfiles; do
		echo "ln -sr $PWD/$file $HOME"
	done | column -t
}

do_install()
{
	for file in $dotfiles; do
		if [ -h "$HOME/$file" ]; then  # symbolic link
			true
		elif [ -d "$HOME/$file" ]; then  # directory
			echo "$HOME/$file -> $PWD/$file (backup: $HOME/${file}.orig)"
			mv "$HOME/$file" "$HOME/${file}.orig"
			ln -sr "$PWD/$file" "$HOME"
		elif [ -f "$HOME/$file" ]; then  # regular file
			echo "$HOME/$file -> $PWD/$file (backup: $HOME/${file}.orig)"
			mv "$HOME/$file" "$HOME/${file}.orig"
			ln -sr "$PWD/$file" "$HOME"
		else
			echo "$HOME/$file -> $PWD/$file"
			ln -sr "$PWD/$file" "$HOME"
		fi
	done | column -t
}

do_remove()
{
	for file in $dotfiles; do
		if [ -h "$HOME/$file" ]; then  # symbolic link
			echo "$HOME/$file -> DELETED (was: $(readlink "$HOME/$file"))"
			rm "$HOME/$file"
		else
			true
		fi
	done | column -t
}

do_list_installed()
{
	for file in $dotfiles; do
		if [ -h "$HOME/$file" ]; then  # symbolic link
			echo -n "$HOME/$file -> "
			readlink "$HOME/$file"
		else
			true
		fi
	done | column -t
}

do_list_not_installed()
{
	for file in $dotfiles; do
		if [ -h "$HOME/$file" ]; then  # symbolic link
			true
		elif [ -d "$HOME/$file" ]; then  # directory
			echo "$HOME/$file -> (Regular directory)"
		elif [ -f "$HOME/$file" ]; then  # regular file
			echo "$HOME/$file -> (Regular file)"
		else
			echo "$HOME/$file -> (Does not exist)"
		fi
	done | column -t
}

cmd=$1
if [ "$cmd" == "install" ]; then
	echo "### Installing symlinks..."
	do_install
	echo "...done!"
elif [ "$cmd" == "remove" ]; then
	echo "### Removing symlinks..."
	do_remove
	echo "...done!"
elif [ "$cmd" == "list" ]; then
	echo "### Installed symlinks:"
	do_list_installed
	echo "### Not installed symlinks:"
	do_list_not_installed
elif [ "$cmd" = "howto" ]; then
	do_howto
else
	usage
	exit 1
fi
