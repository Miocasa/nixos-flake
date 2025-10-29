{ config, pkgs, lib, ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
  ];

}