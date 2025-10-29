{ config, pkgs, lib, ... }:

{
  modules = [
    ./dconf.nix
    ./home.nix
    # ./gtk.nix
  ];
}