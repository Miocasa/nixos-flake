{ config, pkgs, lib, ... }:

let
  resumeOffset = 63657984;  # ← Replace with your swapfile offset value 
  # sudo filefrag -v /home/swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
in
{
  # imports = [];
  # boot.kernelPackages = pkgs.linuxPackages_zen; # define kernel, if device is steam deck don't uncomment line
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  
  # Hibernation
  swapDevices = [ { device = "/home/swapfile"; } ];
  boot.kernelParams = [
    "resume=UUID=7d475dca-9f54-4482-b2e2-f66ee22daae5"
    "resume_offset=${toString resumeOffset}"
  ];

  powerManagement.enable = true;

  services.power-profiles-daemon.enable = true;
  systemd.targets = {
    suspend.enable = true;
    hibernate.enable = true;
    hybrid-sleep.enable = true;
  };
  
  systemd.sleep.extraConfig = ''
    AllowSuspendThenHibernate=yes
    HibernateDelaySec=5m
  '';

  services.logind.settings.Login = {
    HandlePowerKey = lib.mkForce "hybrid-sleep";
    HandleSuspendKey = "hybrid-sleep";
    HandleHibernateKey = "hibernate";
    IdleAction = "hybrid-sleep";
    IdleActionSec = "15min";
  };


  # Suspent then Hibernate on power button pressed
  # services.logind.powerKey = lib.mkForce "suspend-then-hibernate";
  # services.logind.powerKeyLongPress = "poweroff";

  # services.logind.settings = {
  #   Login = {
  #     HandlePowerKey = lib.mkForce "suspend-then-hibernate";                    # Ignore short press
  #     HandlePowerKeyLongPress = lib.mkForce "poweroff";         # Long press = shutdown
  #     # HandleSuspendKey = lib.mkForce "suspend";                  # Steam button = suspend
  #     # HandleSuspendKeyLongPress = lib.mkForce "poweroff";       # Long Steam button = hibernate
  #     # HandleLidSwitch = lib.mkForce "suspend";                   # Close lid = suspend
  #     # HandleLidSwitchExternalPower = lib.mkForce "ignore";       # Lid on charger = ignore
  #     # HandleLidSwitchDocked = lib.mkForce "ignore";              # Lid docked = ignore
  #     IdleAction = lib.mkForce "suspend-then-hibernate";                        # Suspend after idle
  #     IdleActionSec = lib.mkForce "25min";                       # 30 minutes idle timeout
  #     HibernateDelaySec="30m";
  #   };
  # }; 


  # Graphic settings
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
}