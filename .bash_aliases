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
# alias gitk='gitk --all& '
alias gk='gitk '
alias gs='git status '
# gs without untracked-files: git status --untracked-files=no
alias gst='git status -uno'
alias ga='git add '
alias gau='git add -u'
alias gb='git branch '
alias gc='git commit -m '
alias gca='git commit -a -m '
alias gd='git diff '
alias gdn='git diff --name-only'
alias gdt='git difftool '
alias go='git checkout '
alias gl='git log '
alias gf='git fetch '
alias gfu='git fetch upstream'
alias gfo='git fetch origin'
alias gfw='git fetch wojtuss'
alias gfa='git fetch aipg'
alias gfall='git fetch --all'
alias grb='git rebase '
alias gri='grb -i'
alias grih^^='gri HEAD^^'
alias grih^^^='gri HEAD^^^'
alias grih^^^^='gri HEAD^^^^'
alias griumaster='gri upstream/master'
alias grium='gri upstream/main'
alias griom='gri origin/main'
# alias griud='gri upstream/develop'
alias grs='git reset '
alias grh='grs --hard '
alias grhumaster='grh upstream/master'
alias grhum='grh upstream/main'
alias grhom='grh origin/main'
alias grhud='grh upstream/develop'
alias gp='git push '
alias gpf='gp -f '
alias gpo='gp origin HEAD'
alias gpfo='gpf origin HEAD'
alias gg='git grep'
alias ggi='git grep -i'
# list files modified in the commit:
alias gdtr='git diff-tree -r --no-commit-id --name-only'
# git stash commands
alias gslist='git stash list'
alias gsshow='git stash show'
alias gspush='git stash push -m'
alias gspushki='git stash push --keep-index -m'
alias gspop='git stash pop'
alias gsapply='git stash apply'
alias gsclear='git stash clear'


alias cs='config status'
alias ca='config add'
alias cb='config branch'
alias cc='config commit -m'
alias cca='config commit -a -m'
alias cdiff='config diff'
alias cdt='config difftool'
alias co='config checkout'
alias cl='config log'
# cf is used by clang-format
# alias cf='config fetch'
alias cpull='config pull'
alias cpush='config push'

unalias cf &>/dev/null
# clang-format
cf() {
	for FILE in $(git diff --cached --name-only)
	do
		if [[ $FILE == "*\.(c|h|cpp|cc|hpp)" ]]; then
			clang-format -style=file -i $FILE
		fi
	done
}

# turbo boost setting
alias turbo_check='cat /sys/devices/system/cpu/intel_pstate/no_turbo'
alias turbo_enable='echo "0" | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo'
alias turbo_disable='echo "1" | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo'

alias sudolast='sudo $(history -p \!\!)'
alias psg='ps ax | grep'

alias reload_bash='. ~/.bashrc'
alias .b='. ~/.bashrc'

if [ -f ~/.bash_aliases_lux ]; then
	. ~/.bash_aliases_lux
fi

if [ -f ~/.bash_aliases_local ]; then
	. ~/.bash_aliases_local
fi

# TensorFlow
alias tensorflow_activate='. ~/tensorflow/bin/activate'
alias tensorflow_deactivate='deactivate'

# GNU screen
alias s='screen -S'
alias sls='screen -ls'
alias sx='screen -x'

# tmux
alias t='tmux new -s'
alias tls='tmux ls'
alias ta='tmux a -t'
alias ts='tmux switch -t'
alias td='tmux detach'

# copy with progress indicator
alias cp='rsync --info=progress2 -arh'

# YouCompleteMe
alias cmake_ycm='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'

# andki-slideshow
anki-slideshow() {
	cd /home/wojtuss/Apps/anki-slideshow
	rackup -p4567
	cd -
}

# xdot
xdot() {
	/usr/bin/xdot $@ &
}

# meld
meld() {
	/usr/bin/meld $@ &
}

# ccache
set_ccache_dir() {
	ccache_dir=$(readlink -f $1)
	export CCACHE_DIR=${ccache_dir}
}

# jupyter notebook
alias jn='jupyter notebook'

