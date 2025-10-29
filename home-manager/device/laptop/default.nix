{ config, pkgs, lib, ... }:

{
  imports = [
    ./home-manager/device/laptop/home.nix 
    ./home-manager/device/laptop/gtk.nix 
    ./home-manager/device/laptop/dconf.nix
  ];
}