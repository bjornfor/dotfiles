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
# provide the same completion support for the 'a' alias as for the aptitude
# command (taken from /etc/bash_completion.d/aptitude)
complete -F _aptitude -o default a
alias ashow='apt-cache show'
alias ain='sudo aptitude install'
alias aup='sudo aptitude update && sudo aptitude safe-upgrade'
alias xo=xdg-open
# copy with a progress bar
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
# untested rsync aliases (copy/move with progress bar)
alias rsynccopy="rsync --partial --progress --append --rsh=ssh -r -h "
alias rsyncmove="rsync --partial --progress --append --rsh=ssh -r -h --remove-sent-files"

alias sshtunnel="ssh -ND 4711 -v -p 8383 bjornfor@forsman.isa-geek.org"

# for Red Hat based distros
test -e /usr/bin/vimx && alias vim='/usr/bin/vimx'

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
		# tmux is like screen, but with ctrl-b as escape char (instead
		# of ctrl-a). And it doesn't mess up Vim colors.
		command ssh "$1" -Xt tmux new-session -A -s main
		# Byobu's most important keybindings:
		# F2 - Create a new window
		# F3 - Move to previous window
		# F4 - Move to next window
		# F6 - Detach from this session
		# For more, see byobu(1) and look for "KEYBINDINGS".
		#command ssh "$1" -Xt byobu-tmux
	else
		command ssh "$@"
	fi
}

genpasswd() {
	local len="$1"
	test "$len" == "" && len=16
	tr -dc "A-Za-z0-9" < /dev/urandom | head -c "$len"; printf "\n"
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

alias nix-shell-callPackage="nix-shell -E '(import <nixpkgs> {}).callPackage ./. {}'"
alias nix-build-callPackage="nix-build -E '(import <nixpkgs> {}).callPackage ./. {}'"

#export PS1="\[\033[1;30m\]\[\033[1;34m\]\W\[\033[1;30m\] $ "
#export PS1="\W $ "
#export PS1="\[\033[1;30m\][\[\033[1;34m\]\u\[\033[1;30m\]@\[\033[0;35m\]\h\[\033[1;30m\]] \[\033[0;37m\]\W \[\033[1;30m\]\$\[\033[0m\] "

#export PS1='\u@\h:\w$(__git_ps1 " [git::%s]")$ '

export CDPATH=.:~:~/projects

export EDITOR=vim
export BROWSER=firefox

export HISTCONTROL=ignoreboth   # ignorespace + ignoredups
export HISTSIZE=1000000         # big big history
export HISTFILESIZE=$HISTSIZE
shopt -s histappend             # append to history, don't overwrite it

export LESS="--ignore-case"

# This is a fix for nixpkgs programs. They get broken fonts on non-NixOS
# distros without this. Eelco says that this is a regression (it used to work
# before).
#export FONTCONFIG_FILE=/etc/fonts/fonts.conf

## Save and reload the history after each command finishes
##export PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND"
#export PROMPT_COMMAND="history -a; history -n"

# Don't add duplicate ~/.nix-profile/bin to PATH on NixOS
if [ "$(. /etc/os-release; echo $ID)" != nixos -a -d $HOME/.nix-profile/bin ]; then
    export PATH=$HOME/.nix-profile/bin:$HOME/.nix-profile/sbin:$PATH
fi


# (Copied from https://mg.pov.lt/blog/bash-prompt.html)
#
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*)
                # The command is trying to set the title bar as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them.
                ;;
            *)
                echo -ne "\033]0;${USER}@${HOSTNAME}: ${BASH_COMMAND}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac
