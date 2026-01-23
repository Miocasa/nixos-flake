{ config, pkgs, pkgs-stable, inputs, prism, ... }:

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
    obsidian
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
    
    appimage-run
    steam-run
    # sccache

    # Console
    ptyxis
    
    # pkg that exist only in stable repo 
    pkgs-stable.efibootmgr
    # inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor

    home-manager

    inputs.prism.packages.${system}.prismlauncher
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