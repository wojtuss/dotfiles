# Docker
unalias dps dim drm drmi dclean diclean dnclean &>/dev/null
alias dps='docker ps'
alias dim='docker images'
function drm() { docker rm $(docker ps -aq | grep "^$1"); }
function drmi() { docker rmi $(docker images -aq | grep "^$1"); }
function drmin() { docker rmi $(docker images -a | grep "^<none>" | awk '{print $3}' | grep "^$1"); }
#alias dclean='docker rm $(docker ps -aq)'
#alias diclean='docker rmi $(docker images -aq)'
#alias dnclean='docker rmi $(docker images | grep "^<none>" | awk '\''{print $3}'\'')'

#Bash
alias fixpaste='printf "\e[?2004l"'
alias ls='ls -1 --color=auto'
alias ls.='ls -a'

# Vim
#function gvim () { command gvim --remote-tab-silent "$@" || command gvim "$@"; }
#alias gvim='gvim -p --remote-tab-silent'
alias v='vim'

# Git
alias git='PAGER= git'
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias gitk='gitk --all& '
alias gk='gitk '
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit -m '
alias gca='git commit -a -m '
alias gd='git diff '
alias gdt='git difftool '
alias go='git checkout '
alias gl='git log '
alias gf='git fetch '
alias gfu='git fetch upstream'
alias gfa='git fetch --all'
alias grb='git rebase '
alias gri='grb -i'
alias grih^^='gri HEAD^^'
alias grih^^^='gri HEAD^^^'
alias grih^^^^='gri HEAD^^^^'
alias grium='gri upstream/master'
alias griud='gri upstream/develop'
alias grs='git reset '
alias grh='grs --hard '
alias grhum='grh upstream/master'
alias grhud='grh upstream/develop'
alias gp='git push '
alias gpf='gp -f '
alias gpo='gp origin HEAD'
alias gpfo='gpf origin HEAD'
alias gg='git grep'

alias sudolast='sudo $(history -p \!\!)'
alias psg='ps ax | grep'

alias reload_bash='. ~/.bashrc'
alias .b='. ~/.bashrc'

if [ -f ~/.bash_aliases_NVML ]; then
	. ~/.bash_aliases_NVML
fi

if [ -f ~/.bash_aliases_SB ]; then
	. ~/.bash_aliases_SB
fi

if [ -f ~/.bash_aliases_AIPG ]; then
    . ~/.bash_aliases_AIPG
fi

# TensorFlow
alias tensorflow_activate='. ~/tensorflow/bin/activate'
alias tensorflow_deactivate='deactivate'

# GNU screen
alias sls='screen -ls'
