# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\w$(__git_ps1 " (%s)")\n\
\[\033[01;32m\]\u \[\033[01;34m\]\$\[\033[00m\] '
# PS1='\w\n\
# \[\033[01;32m\]\u \[\033[01;34m\]\$\[\033[00m\] '

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=1

export HISTSIZE=5000
export HISTFILESIZE=50000
export HISTCONTROL=ignoreboth

[ -f ~/utils/bundler-exec.sh ] && source ~/utils/bundler-exec.sh
