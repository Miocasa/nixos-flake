{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [ ];

  nixpkgs.config = {
    allowUnfree = true;
  };
}