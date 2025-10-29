{ config, pkgs, ... }:

{
  imports = [];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    mesa
    # amdvlk
    nvidia-vaapi-driver
    vaapiVdpau
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer
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