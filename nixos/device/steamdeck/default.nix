{ config, pkgs, lib, ... }:

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