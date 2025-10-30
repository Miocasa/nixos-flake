{ config, pkgs, lib, ... }:
{
  imports = [
    ./configuration.nix
    ./users.nix
    ./hardware.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];
}