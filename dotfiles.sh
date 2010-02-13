#!/bin/sh
# Manage dotfile symlinks.
#
# Usage:
#   dotfiles.sh [install|remove|list]
#
# When called with no arguments, print help text.

dotfiles="
.bash_aliases
.ctags
.gitconfig
.hgrc
.mrconfig
.msmtprc
.muttrc
.offlineimaprc
.rdesktop.kitron.dvr-sw
.signature
.vimrc
.zshrc
"

##for dotfile in $(ls -1 .*); do
#for dotfile in $(find . -maxdepth 1 -type f -name ".*"); do
#	echo "ln -s $PWD/$dotfile $HOME"
#done

prog=$0
path=$(dirname $prog)
base=$(basename $prog)
cd $path > /dev/null
#echo -e "base: $base\npath: $path\nprog: $prog\nPWD: $PWD\n"

usage()
{
	cat << EOF
Usage:
  $prog [install|remove|list]

install  - install dotfile symlinks (first: move any existing DOTFILE to DOTFILE.orig)
remove   - remove dotfile symlinks
list     - list installed (and not installed) dotfile symlinks
EOF
}

do_install()
{
	for file in $dotfiles; do
		if [ -h $HOME/$file ]; then  # symbolic link
			true
		elif [ -d $HOME/$file ]; then  # directory
			true
		elif [ -f $HOME/$file ]; then  # regular file
			echo "$HOME/$file -> $PWD/$file (backup: $HOME/${file}.orig)"
			mv $HOME/$file $HOME/${file}.orig
			ln -s $PWD/$file $HOME
		else
			echo "$HOME/$file -> $PWD/$file"
			ln -s $PWD/$file $HOME
		fi
	done
}

do_remove()
{
	for file in $dotfiles; do
		if [ -h $HOME/$file ]; then  # symbolic link
			echo -n "Removing symlink: $HOME/$file -> "
			readlink $HOME/$file
			rm $HOME/$file
		else
			true
		fi
	done
}

do_list_installed()
{
	for file in $dotfiles; do
		if [ -h $HOME/$file ]; then  # symbolic link
			echo -n "$HOME/$file -> "
			readlink $HOME/$file
		else
			true
		fi
	done
}

do_list_not_installed()
{
	for file in $dotfiles; do
		if [ -h $HOME/$file ]; then  # symbolic link
			true
		elif [ -d $HOME/$file ]; then  # directory
			echo "$HOME/$file -> (Regular directory)"
		elif [ -f $HOME/$file ]; then  # regular file
			echo "$HOME/$file -> (Regular file)"
		else
			echo "$file"
		fi
	done
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
else
	usage
	exit 1
fi
