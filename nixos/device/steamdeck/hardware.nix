{ config, pkgs, lib, ... }:

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
  # services.logind.powerKey = lib.mkForce "suspend-then-hibernate";
  # services.logind.powerKeyLongPress = "poweroff";

  services.logind.settings = {
    Login = {
      HandlePowerKey = lib.mkForce "suspend-then-hibernate";                    # Ignore short press
      HandlePowerKeyLongPress = lib.mkForce "poweroff";         # Long press = shutdown
      # HandleSuspendKey = lib.mkForce "suspend";                  # Steam button = suspend
      # HandleSuspendKeyLongPress = lib.mkForce "poweroff";       # Long Steam button = hibernate
      # HandleLidSwitch = lib.mkForce "suspend";                   # Close lid = suspend
      # HandleLidSwitchExternalPower = lib.mkForce "ignore";       # Lid on charger = ignore
      # HandleLidSwitchDocked = lib.mkForce "ignore";              # Lid docked = ignore
      IdleAction = lib.mkForce "suspend-then-hibernate";                        # Suspend after idle
      IdleActionSec = lib.mkForce "25min";                       # 30 minutes idle timeout
    };
  }; 
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';
}