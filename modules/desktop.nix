{ config, pkgs, ... }:

let
  user = "miocasa";
in
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.flatpak.enable = true;

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
  ];

  users.defaultUserShell = pkgs.zsh;

  services.xserver.displayManager.gdm.wayland = true;
  services.pipewire.enable = true;
}
