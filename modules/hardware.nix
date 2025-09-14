{ config, pkgs, ... }:

{
  imports = [];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    mesa
  ];

  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  # Configure NVIDIA specific options
  hardware.nvidia = {
    # If your card is a Turing generation (RTX 20xx) or newer, set this to true.
    # Otherwise, set to false.
    open = true;
    # Other options can be added here, like modesetting
    modesetting.enable = true;
  };
  hardware.enableRedistributableFirmware = true;
}