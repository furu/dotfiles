set -g fish_greeting

starship init fish | source
fzf --fish | source

bind \co fzf-select-repository
