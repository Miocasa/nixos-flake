{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  services.flatpak.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [
    steam
    vscodium
    google-chrome
    zsh
    lua
    neovim
    flatpak
    git
    tree
    gamescope
    vesktop
    libreoffice-fresh
  ];
}