{ config, pkgs, lib, ... }:

let
  username = "miocasa";
in
{
  programs.home-manager.enable = true;

  home-manager.users.${username} = { pkgs, ... }:
    {
      programs.zsh.enable = true;
      programs.zsh.ohMyZsh.enable = false;
      programs.zsh.shellAliases = {
        ll = "ls -la";
      };

      programs.neovim = {
        enable = true;
        package = pkgs.neovim;
      };

      programs.flatpak.enable = true;

      home.packages = with pkgs; [ vscodium google-chrome ];

      xsession.windowManager.gnome.enable = true;
    };
}