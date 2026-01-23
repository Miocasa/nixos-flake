{ config, pkgs, mac-style-plymouth, inputs, ... }:

{
  imports = [];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.initrd.systemd.enable = true;
  boot.tmp.useTmpfs = true;

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
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    powerManagement = {
      enable = true;
      finegrained = false;
    };
  };
  hardware.enableRedistributableFirmware = true;
  
  nixpkgs.overlays = [
    (final: prev: {
      libfprint = prev.libfprint.overrideAttrs (oldAttrs: {
        version = "git";
        src = final.fetchFromGitHub {
          owner = "deftdawg";
          repo = "libfprint-CS9711";
          rev = "56bf490f8ea2ab9049f410b9dfe78b33d59fd2c4";
          sha256 = "sha256-PVr/Mi3m0P1bojVYriubmpA8QC5oayV5RtHbyXyHPC0=";
        };
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
          final.opencv
          final.cmake
          final.doctest
        ];
      });
    })
    # ... other overlays 
  ];
  services.fprintd.enable = true; # MARK: fingerprint



  boot = {

    plymouth = {
      enable = true;
      theme = "mac-style";
      themePackages = [ inputs.mac-style-plymouth.packages.${pkgs.system}.mac-style-plymouth ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;

  };


  # Hibernation config # not working yeat, 😭 this issue will kill me
  # boot.resumeDevice = "/dev/disk/by-uuid/f06b34ee-2d61-4326-a117-951403adc05e";
    
  # swapDevices = [ 
  #   {
  #     device = "/var/lib/swapfile";
  #     size   = 18 * 1024;
  #   }
  # ];
  
  # boot.kernelParams = [
  #   "resume=/dev/disk/by-uuid/f06b34ee-2d61-4326-a117-951403adc05e"
  #   "resume_offset=45147702"
  #   # "mem_sleep_default=s2idle"
  # ];

  # systemd.services.systemd-suspend.environment = {
  #   SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
  # };

  # # suspend-then-hibernate
  # systemd.sleep.extraConfig = ''
  #   HibernateDelaySec=30m
  #   SuspendState=mem
  # '';
  powerManagement.enable = true;

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