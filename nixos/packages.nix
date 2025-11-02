{ config, pkgs, pkgs-stable, ... }:

{
  programs.steam.enable = true;
  services.flatpak.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };
  programs = {
    appimage = { enable = true; binfmt = true; };
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
    uv
    pipx
    nix-ld
    packet
    # pkg that exist only in stable repo 
    pkgs-stable.efibootmgr
  ];
  programs.nix-ld.enable = true;
  
  # programs.kdeconnect = {
    # enable = true;
  # };
  networking.firewall = rec {
  allowedTCPPortRanges = [ { from = 1714; to = 1764; } ]; # kde connect
  allowedUDPPortRanges = allowedTCPPortRanges;
  allowedUDPPorts = [ 53317 ];
  };
}