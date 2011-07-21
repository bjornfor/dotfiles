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
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."


alias g='git'
alias s='sudo'
alias v=vim
alias gdb='gdb --quiet' # suppress the introductory and copyright messages
alias pacman='pacman-color'
alias a='sudo aptitude'
alias as='aptitude search'
alias ashow='apt-cache show'
alias ain='sudo aptitude install'
alias aup='sudo aptitude update; sudo aptitude safe-upgrade'
alias xo=xdg-open
# copy with a progress bar
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
# untested rsync aliases (copy/move with progress bar)
alias rsynccopy="rsync --partial --progress --append --rsh=ssh -r -h "
alias rsyncmove="rsync --partial --progress --append --rsh=ssh -r -h --remove-sent-files"

alias sshtunnel="ssh -ND 4711 -v -p 8383 bjornfor@forsman.isa-geek.org"

# Compress the cd, ls -l series of commands.
function cl() {
   if [ $# = 0 ]; then
      cd && ll
   else
      cd "$*" && ll
   fi
}

# Pronounce an English word using Merriam-Webster.com
pronounce() {
	wget -qO- $(wget -qO- "http://www.m-w.com/dictionary/$@" | grep 'return au' | sed -r "s|.*return au\('([^']*)', '([^'])[^']*'\).*|http://cougar.eb.com/soundc11/\2/\1|") | aplay -q;
}

# awk calculator (remember to quote arguments if they contain parentheses)
c ()
{
    awk "BEGIN{ pi=4.0*atan2(1.0,1.0); deg=pi/180.0;  print $* }";
}

ssh()
{
	if [[ "$2" == "" ]]; then
		command ssh "$1" -Xt screen -aAdr -RR work bash
	else
		command ssh $@
	fi
}

#alias cdl='cl'
# prevent annoying typo's
#alias lc='cl'


alias cddvr="cd /media/raid/bjornfor/projects/dvr-control"
#alias gvc=gnome-volume-control

#alias todo='vim $HOME/todo.txt'
#alias t='todo'
alias gtd='vim ~/raid/projects/vim-wiki/index.txt'
#alias gtd='vim -c "cd %:h" ~/raid/documents/vim-wiki/index.txt'

# Remember 'sudo apt-get install libnotify-bin' for this.
# Usage: sleep 5; alert
# (this alias is actually in .bashrc in Ubuntu 10.10)
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1| sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#export PS1="\[\033[1;30m\]\[\033[1;34m\]\W\[\033[1;30m\] $ "
#export PS1="\W $ "
#export PS1="\[\033[1;30m\][\[\033[1;34m\]\u\[\033[1;30m\]@\[\033[0;35m\]\h\[\033[1;30m\]] \[\033[0;37m\]\W \[\033[1;30m\]\$\[\033[0m\] "


export EDITOR=vim
export BROWSER=firefox

export HISTCONTROL=ignoreboth   # ignorespace + ignoredups
export HISTSIZE=1000000         # big big history
export HISTFILESIZE=$HISTSIZE
shopt -s histappend             # append to history, don't overwrite it

## Save and reload the history after each command finishes
##export PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND"
#export PROMPT_COMMAND="history -a; history -n"
