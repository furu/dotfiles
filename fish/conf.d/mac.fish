set -g fish_greeting

$HOME/.local/bin/mise activate fish | source

starship init fish | source
fzf --fish | source
direnv hook fish | source

bind \co fzf-select-repository
