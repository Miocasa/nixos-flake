{ config, pkgs, pkgs-stable, lib, inputs, prism, ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
  ];

}