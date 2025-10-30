{ config, pkgs, pkgs-stable, lib, ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
  ];

}