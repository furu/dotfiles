package 'curl'
package 'lv'
package 'gnome-tweaks'
package 'wmctrl'

execute 'Google Chrome' do
  command <<~COMMAND
    cd /tmp
    curl -sLO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt-get -y install ./google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
  COMMAND

  not_if 'type google-chrome'
end

execute '1Password' do
  command <<~COMMAND
    cd /tmp
    curl -sLO https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb
    sudo apt-get -y install ./1password-latest.deb
    rm 1password-latest.deb
  COMMAND

  not_if 'type 1password'
end

execute 'Ulauncher' do
  command <<~COMMAND
    cd /tmp
    curl -sLO https://github.com/Ulauncher/Ulauncher/releases/download/5.15.7/ulauncher_5.15.7_all.deb
    sudo apt-get -y install ./ulauncher_5.15.7_all.deb
    rm ulauncher_5.15.7_all.deb
  COMMAND

  not_if 'type ulauncher'
end

define :dotfile do
  source = File.expand_path("../#{params[:name]}", __FILE__)
  target = "#{ENV.fetch('HOME')}/.config/#{params[:name]}"

  directory File.dirname(target) do
    #user node[:user]
    user 'tfrkd'
  end

  # ln -s source target
  link target do
    to source
    #user node[:user]
    user 'tfrkd'
    force true
  end
end

# libskk
package 'ibus-skk'
dotfile 'libskk/rules/sticky-shift/metadata.json'
dotfile 'libskk/rules/sticky-shift/keymap/hiragana.json'
dotfile 'libskk/rules/sticky-shift/rom-kana/default.json'

# Ghostty
execute 'Ghostty' do
  command <<~COMMAND
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
  COMMAND

  not_if 'type ghostty'
end
dotfile 'ghostty/config'

# fish
package 'fish'
dotfile 'fish/conf.d/alias.fish'
dotfile 'fish/conf.d/ubuntu.fish'
dotfile 'fish/functions/fzf-select-repository.fish'

# Starship
execute 'Starship' do
  command <<~COMMAND
    cd /tmp
    curl -sS -o install-starship.sh https://starship.rs/install.sh
    chmod +x install-starship.sh
    ./install-starship.sh --yes
    rm install-starship.sh
  COMMAND

  not_if 'type starship'
end
dotfile 'starship.toml'

# tmux
package 'tmux'
dotfile 'tmux/tmux.conf'

# Neovim
package 'neovim'
dotfile 'nvim/init.vim'

# IdeaVim
#dotfile 'ideavim/ideavimrc'

# Git
package 'git'
dotfile 'git/config'
