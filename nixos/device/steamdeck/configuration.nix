{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Asia/Almaty";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod.enabled = null;

  services.printing.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.wayland = true;
  # services.displayManager.defaultSession = "gnome";

  services.gnome = {
    tinysparql.enable = false;
    localsearch.enable = false;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-terminal
    gnome-tour
    gnome-keyring
    epiphany
    totem
    simple-scan
    geary
    yelp
  ];

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  networking.networkmanager.enable = true;
  networking.hostName = "steamdeck";
  
  # System-wide packages (core system tools only)
  environment.systemPackages = with pkgs; [
    # Build essentials
    pkg-config
    gnumake
    cmake
    openssl.dev
    libxml2
    libxslt
    zlib
    libgit2
    heimdal
    krb5.dev
    gcc
    lact

    # Core system utilities
    wsdd
    wget
    curl
    unzip
    kitty
    ripgrep
    btop
    neofetch

    # Language Managers
    nodejs_24
    ruby_3_4
    go
    python314
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.fira-code
  ];

  programs.zsh = {
    enable = true;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      input-overlay
      obs-vaapi
      obs-vkcapture
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  virtualisation.docker.enable = true;

  users.defaultUserShell = pkgs.zsh;

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gnome-browser-connector.enable = true;
  nixpkgs.config.google-chrome.enableGnomeExtensions = true; 

  services.flatpak.enable = true;

  
  # services.pipewire.enable = true;

  system.stateVersion = "25.05";
}
