define :dotfile do
  source = File.expand_path("../#{params[:name]}", __FILE__)
  target = "#{ENV.fetch('HOME')}/.config/#{params[:name]}"

  directory File.dirname(target) do
    #user node[:user]
    user 'furukido'
  end

  # ln -s source target
  link target do
    to source
    #user node[:user]
    #user 'tfrkd'
    user 'furukido'
    force true
  end
end

# fish
package 'fish'
dotfile 'fish/conf.d/alias.fish'
dotfile 'fish/conf.d/mac.fish'
dotfile 'fish/functions/fzf-select-repository.fish'

# Starship
dotfile 'starship.toml'

# tmux
dotfile 'tmux/tmux.conf'

# Ghostty
dotfile 'ghostty/config'

# Git
dotfile 'git/config'
dotfile 'git/ignore'

execute "cp git/config.local.example #{ENV.fetch('HOME')}/.config/git/config.local" do
  not_if "test -f #{ENV.fetch('HOME')}/.config/git/config.local"
end

# Neovim
#sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
dotfile 'nvim/init.vim'
