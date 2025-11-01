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
    libva-vdpau-driver
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

  # # Hibernation
  # boot.kernelParams = ["resume_offset=63657984"];
  # boot.resumeDevice = "/dev/disk/by-uuid/557944b8-1db4-437b-a4bf-4e614896a5d6";
  # powerManagement.enable = true;

  # services.power-profiles-daemon.enable = true;
  
  # # Suspent then Hibernate on power button pressed
  # services.logind.powerKey = "suspend-then-hibernate";
  # services.logind.powerKeyLongPress = "poweroff";
  # systemd.sleep.extraConfig = ''
  #   HibernateDelaySec=30m
  #   SuspendState=mem
  # '';
}