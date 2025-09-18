{ config, pkgs, lib, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware.nix
    ./packages.nix
    ./shell.nix
    ./users.nix
  ];

}