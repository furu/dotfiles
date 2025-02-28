define :dotfile do
  source = File.expand_path("../#{params[:name]}", __FILE__)
  target = "#{ENV.fetch('HOME')}/.config/#{params[:name]}"

  directory File.dirname(target) do
    user node[:user]
  end

  # ln -s source target
  link target do
    to source
    user params[:user]
    force true
  end
end

# Ghostty
dotfile 'ghostty/config'

# fish
dotfile 'fish/conf.d/alias.fish'
dotfile 'fish/functions/fzf-select-repository.fish'

# Starship
dotfile 'starship.toml'

# tmux
dotfile 'tmux/tmux.conf'

# Neovim
dotfile 'nvim/init.vim'

# IdeaVim
dotfile 'ideavim/ideavimrc'

# Git
dotfile 'git/config'
