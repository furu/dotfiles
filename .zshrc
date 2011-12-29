# Filename: .zshrc
# Last Change: 27-Nov-2011.
# Maintainer: furu

# Japanese
export LANG=ja_JP.UTF-8

# Prompt
PROMPT="
[%~]
[%n@%M]%# "

# Title
case "${TERM}" in
kterm*|xterm)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  ;;
esac

# History
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt extended_history
function history-all { history -E l }
setopt share_history

# Completion
autoload -Uz compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle :compinstall filename '/home/furu/.zshrc'

#bindkey -v
bindkey -e

setopt prompt_subst
setopt nobeep
setopt auto_list
setopt auto_menu
setopt auto_param_slash
setopt auto_cd
setopt list_types
#setopt correct
setopt list_packed

# Alias
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#alias vi='vim'

# Directory
setopt auto_pushd
setopt pushd_ignore_dups

# PATH
#export ECLIPSE_HOME=/usr/local/eclipse
#export PATH=$ECLIPSE_HOME:$PATH

#export JAVA_HOME=/usr/local/java/jdk1.6.0_24
#export PATH=$JAVA_HOME/bin:$PATH
#export CLASSPATH=.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/mysql-connector-java-5.1.16-bin.jar:/usr/local/java/jfreechart-1.0.13/lib/jfreechart-1.0.13.jar:/usr/local/java/jfreechart-1.0.13/lib/jcommon-1.0.16.jar

#export PATH=/home/furu/app/termtter/bin:$PATH
export PATH=$HOME/bin:$PATH
export RSENSE_HOME=$HOME/opt/rsense-0.3

# export LESS='-R'
# export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'

# This loads RVM into a shell session.
# fpath=(~/.zsh/Completion $fpath)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
