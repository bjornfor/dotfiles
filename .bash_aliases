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
alias ain='sudo aptitude install'
alias aup='sudo aptitude update; sudo aptitude safe-upgrade'
alias xo=xdg-open
# copy with a progress bar
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"

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

#alias cdl='cl'
# prevent annoying typo's
#alias lc='cl'


alias cddvr="cd /media/raid/bjornfor/projects/dvr-control"
#alias gvc=gnome-volume-control

#alias todo='vim $HOME/todo.txt'
#alias t='todo'
alias gtd='vim ~/raid/projects/vim-wiki/index.txt'
#alias gtd='vim -c "cd %:h" ~/raid/documents/vim-wiki/index.txt'


#export PS1="\[\033[1;30m\]\[\033[1;34m\]\W\[\033[1;30m\] $ "
#export PS1="\W $ "
#export PS1="\[\033[1;30m\][\[\033[1;34m\]\u\[\033[1;30m\]@\[\033[0;35m\]\h\[\033[1;30m\]] \[\033[0;37m\]\W \[\033[1;30m\]\$\[\033[0m\] "


export EDITOR=vim
export BROWSER=firefox
export PATH=$PATH:/var/lib/gems/1.8/bin
