#!/usr/bin/env bash

set -o verbose
set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

# https://macos-defaults.com/

# Dock
#defaults write com.apple.dock "persistent-apps" -array
defaults write com.apple.dock "autohide" -bool "true"
killall Dock

# デスクトップとステージマネージャ
defaults write com.apple.WindowManager "EnableStandardClickToShowDesktop" -bool "false"
