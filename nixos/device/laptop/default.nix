{ config, pkgs, lib, nixos-conf-editor, mac-style-plymouth, ... }:
{
  imports = [
    ./configuration.nix
    ./users.nix
    ./hardware.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];
}