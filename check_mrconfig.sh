#!/bin/sh
# Check if there are any directories in $PROJECTS/ that are not listed in ~/.mrconfig.

PROJECTS=$HOME/raid/projects

for dir in $(ls -d1 $PROJECTS/*); do
	grep -lq "\[.*$(basename $dir).*\]" $HOME/.mrconfig && echo $(basename $dir) OK || echo $(basename $dir) not found in $HOME/.mrconfig
done
