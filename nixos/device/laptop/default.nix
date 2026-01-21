{ config, pkgs, lib, nixos-conf-editor, ... }:
{
  imports = [
    ./configuration.nix
    ./users.nix
    ./hardware.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];
}