{ config, pkgs, lib, ... }:
{
  imports = [
    ./configuration.nix
    ./users.nix
    ./hardware.nix
  ];
}