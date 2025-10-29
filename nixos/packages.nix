{ config, pkgs, pkgs-stable, ... }:

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
    vesktop
    libreoffice-fresh
    blender
    waydroid
    waydroid-helper
    fastfetch
    # kdePackages.kdeconnect-kde
    # python environment
    uv
    pipx

    nix-ld
  ];
  programs.nix-ld.enable = true;
  
  # programs.kdeconnect = {
    # enable = true;
  # };
  networking.firewall = rec {
  allowedTCPPortRanges = [ { from = 1714; to = 1764; } ]; # kde connect
  allowedUDPPortRanges = allowedTCPPortRanges;
  };
}