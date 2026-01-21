{ config, pkgs, lib, ... }:

{
  imports = [
    ./home.nix 
    ./gtk.nix 
    ./dconf.nix
    ./shell.nix
  ];
}