# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

export TERM=xterm-256color

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# add git stuff to the prompt
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1


# define a new prompt

# add run time of the last command to the prompt
timer_now() {
	date +%s%N
}

timer_start() {
	timer=${timer:-$(timer_now)}
}

timer_stop() {
    local delta_us=$((($(timer_now) - $timer) / 1000))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    # Goal: always show around 3 digits of accuracy
    if ((h > 0)); then timer_show=${h}h${m}m
    elif ((m > 0)); then timer_show=${m}m${s}s
    elif ((s >= 10)); then timer_show=${s}.$((ms / 100))s
    elif ((s > 0)); then timer_show=${s}.$(printf %03d $ms)s
    elif ((ms >= 100)); then timer_show=${ms}ms
    elif ((ms > 0)); then timer_show=${ms}.$((us / 100))ms
    else timer_show=${us}us
    fi
    unset timer
}

set_my_PS() {
    Last_Command=$? # Must come first!
    if [ "$color_prompt" = yes ]; then
	    Blue=$'\033[01;34m'
	    White=$'\033[01;37m'
	    Red=$'\033[01;31m'
	    Green=$'\033[01;32m'
	    Reset=$'\033[00m'
    fi
    FancyX=$'\u2718'
    Checkmark=$'\u2714'
    Runner=$'🏃'
    
    if [ "$USER" == "wojtuss" ]; then
	    my_name=$Runner
    else
	    my_name=$USER
    fi

    PS1="\n$Reset[$Last_Command "
    if [[ $Last_Command == 0 ]]; then
	    PS1+="$Green$Checkmark "
    else
	    PS1+="$Red$FancyX "
    fi

    timer_stop
    PS1+="$Reset($timer_show)] "
    PS1+="${Green}${my_name}@\h${Reset}:${Blue}\w${Reset}"
    PS1+=$(__git_ps1 " (%s)")
    PS1+="\n\$ "
}

trap 'timer_start' DEBUG
PROMPT_COMMAND='set_my_PS'

#unset color_prompt force_color_prompt


# custom bash command line shortcuts (handled by readline)
export INPUTRC=~/.inputrc

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -lF'
alias la='ls -AlF'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

mkdircd()
{
	mkdir -p -- "$1" && cd -P -- "$1"
}

# For Vim to be your default man pages viewer
export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'set nonumber' -c 'set cc=' -\""

source ~/.git-completion.bash
__git_complete gs _git_status
__git_complete ga _git_add
__git_complete gb _git_branch
__git_complete go _git_checkout
__git_complete gd _git_diff
__git_complete gl _git_log
__git_complete gf _git_fetch
__git_complete grb _git_rebase
__git_complete gri _git_rebase
__git_complete grs _git_reset
__git_complete grh _git_reset
__git_complete gp _git_push
__git_complete gpf _git_push
__git_complete gg _git_grep

# Set vi-mode for bash
# set -o vi

# added by travis gem
[ -f /home/wojtuss/.travis/travis.sh ] && source /home/wojtuss/.travis/travis.sh
