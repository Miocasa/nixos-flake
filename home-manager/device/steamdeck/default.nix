{ config, pkgs, lib, ... }:

{
  imports = [
    ./home-manager/device/steamdeck/home.nix 
    ./home-manager/device/steamdeck/gtk.nix 
    ./home-manager/device/steamdeck/dconf.nix
  ];
}