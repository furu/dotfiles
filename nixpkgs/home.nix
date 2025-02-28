{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "furukido";
  home.homeDirectory = "/Users/furukido";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.awscli2
    pkgs.deno
    pkgs.ffmpeg_5
    pkgs.fnm
    pkgs.ghq
    pkgs.httpie
    pkgs.jq
    pkgs.mycli
    pkgs.nkf
    pkgs.neovim
    pkgs.peco
    pkgs.pgcli
    pkgs.tmux
    pkgs.tree
    pkgs.wget
  ];

  programs.direnv.enable = true;
  programs.fish.enable = true;
}
