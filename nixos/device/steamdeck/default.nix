{ config, pkgs, lib, inputs, ... }:


let
  pkgs-stable = import inputs.nixpkgs-stable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{

  imports = [
    ./configuration.nix
    ./users.nix
    ./hardware.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];
  jovian = {
    steamos.useSteamOSConfig = true;
    steam = {
      user = "deck";
      enable = true;
      autoStart = true;
      desktopSession = "gnome";
    };
    decky-loader = {
      enable = true;
    };
    devices.steamdeck = {
      enable = true;
    };
    # hardware.has.amd.gpu = true;

  };
}