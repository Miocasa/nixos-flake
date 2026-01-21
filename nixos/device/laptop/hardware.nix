{ config, pkgs, ... }:

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
  };
  hardware.enableRedistributableFirmware = true;
  
  
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     libfprint = prev.libfprint.overrideAttrs (oldAttrs: {
  #       version = "git";
  #       src = final.fetchFromGitHub {
  #         owner = "ericlinagora";
  #         repo = "libfprint-CS9711";
  #         rev = "c242a40fcc51aec5b57d877bdf3edfe8cb4883fd";
  #         sha256 = "sha256-WFq8sNitwhOOS3eO8V35EMs+FA73pbILRP0JoW/UR80=";
  #       };
  #       nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
  #         final.opencv
  #         final.cmake
  #         final.doctest
  #         final.pkg-config
  #       ];
  #       buildInputs = oldAttrs.buildInputs or [] ++ [
  #         final.nss
  #         # желательно добавить, если meson их ищет как runtime
  #         final.glib
  #         final.gusb
  #         final.pixman
  #         final.cairo
  #       ];
  #     });
  #   })
  # ];
  # services.fprintd.enable = true;

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