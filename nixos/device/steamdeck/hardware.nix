{ config, pkgs, ... }:

{
  imports = [];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    # mesa
    # amdvlk
    # libva-vdpau-driver
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer
  ];
  
  services.xserver.videoDrivers = ["amdgpu"];
  
  
  hardware.enableRedistributableFirmware = true;

  # Hibernation
  boot.kernelParams = ["resume_offset=63657984"];
  boot.resumeDevice = "/dev/disk/by-uuid/557944b8-1db4-437b-a4bf-4e614896a5d6";
  powerManagement.enable = true;

  services.power-profiles-daemon.enable = true;
  
  # Suspent then Hibernate on power button pressed
  services.logind.powerKey = "suspend-then-hibernate";
  services.logind.powerKeyLongPress = "poweroff";
  services.logind.settings = {
  Login = {
  IdleAction = "suspend";                        # Suspend after idle
  IdleActionSec = "15min";                       # 30 minutes idle timeout
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';
}