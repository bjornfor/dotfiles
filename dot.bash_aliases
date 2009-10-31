# My Bash aliases and other Bash stuff
# Make sure this file is sourced by the shell

alias ls='ls --color=auto'
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias g='git'
alias s='sudo'
alias v=vim
alias gdb='gdb --quiet' # suppress the introductory and copyright messages
alias pacman='pacman-color'

alias sshtunnel="ssh -ND 4711 -v -p 8383 bjornfor@forsman.isa-geek.org"

# Compress the cd, ls -l series of commands.
function cl() {
   if [ $# = 0 ]; then
      cd && ll
   else
      cd "$*" && ll
   fi
}

#alias cdl='cl'
# prevent annoying typo's
#alias lc='cl'


#alias cddvr="cd /media/raid/bjornfor/development/lang/python/dvr-control"
#alias gvc=gnome-volume-control

alias t='/media/raid/bjornfor/projects/todo.txt-cli/todo.sh'
#alias todo='vim $HOME/todo.txt'
#alias t='todo'
alias gtd='vim ~/raid/documents/vim-wiki/index.txt'
#alias gtd='vim -c "cd %:h" ~/raid/documents/vim-wiki/index.txt'


#export PS1="\[\033[1;30m\]\[\033[1;34m\]\W\[\033[1;30m\] $ "
#export PS1="\W $ "
#export PS1="\[\033[1;30m\][\[\033[1;34m\]\u\[\033[1;30m\]@\[\033[0;35m\]\h\[\033[1;30m\]] \[\033[0;37m\]\W \[\033[1;30m\]\$\[\033[0m\] "


export EDITOR=vim
export BROWSER=firefox

export PATH=$PATH:$HOME/bin

# my ruby gems
export PATH=$PATH:$HOME/.gem/ruby/1.8/bin

# CodeSourcery ARM toolchain
export PATH=$PATH:/opt/arm-2009q3/bin

# crosstool-NG
#export PATH=$PATH:$HOME/workdir/crosstool-ng-prefix/bin
#export PATH=$PATH:$HOME/x-tools/arm-unknown-eabi/bin
#export PATH=$PATH:$HOME/x-tools/arm-unknown-linux-gnueabi/bin

# small device c compiler (sdcc)
#export PATH=$HOME/workdir/sdcc/bin:$PATH

# Buildroot toolchain
#export PATH=$PATH:/home/bjornfor/raid/documents/dev/os/linux/buildroot/build_arm/staging_dir/usr/bin

# Google Android SDK
#export PATH=$PATH:$HOME/raid/documents/dev/os/linux/android/android-sdk-linux_x86-1.1_r1/tools

# Scratchbox
#export PATH=$HOME/sb2/bin:$PATH

# DaVinci (TI) stuff
#export C6X_C_DIR=/opt/TI/cg6x_6_0_16/include;/opt/TI/cg6x_6_0_16/lib;

# MontaVista
#export PATH=$PATH:/opt/mv_pro_5.0/montavista/pro/devkit/arm/v5t_le/bin

# OpenEmbedded (OE)
export OEBASE=/media/raid/bjornfor/development/os/linux/oe-stuff
export BBPATH=$OEBASE/build:$OEBASE/openembedded
export PATH=$OEBASE/bitbake/bin:$PATH
# allow bitbake to inherit OEBASE from the environment
export BB_ENV_EXTRAWHITE="OEBASE"
# allow using OE toolchain outside of OE
#export PATH=$PATH:/media/raid/bjornfor/development/os/linux/oe-stuff/build/tmp/cross/armv5te/bin

# Xilinx ISE
#source $HOME/Xilinx92i/settings.sh
#export LD_PRELOAD=$HOME/prosjekt/usb-driver/libusb-driver.so
#export LD_PRELOAD=$HOME/prosjekt/usb-driver/libusb-driver-DEBUG.so
# for Xilinx floorplanner
#export DISPLAY=:0

# let the Bash history file grow!
export HISTSIZE=1000000
export HISTFILESIZE=1000000

# Multiple Repository management tool (mr) (I don't know what this variable is for...!)
#export MR_REPO=/tmp/mr-repo

# Run the .Xmodmap script which I use to remap caps lock to escape.
# Put in "brukervalg -> sesjoner" instead to avoid errors on subsequent shell invocations.
#xmodmap ~/.Xmodmap
