{ config, pkgs, lib, ... }:

{
  home.username = "deck";
  home.homeDirectory = "/home/deck";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  dconf.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # GUI Applications
    gnome-tweaks
    dconf-editor
    google-chrome
    zoom-us
    telegram-desktop
    youtube-music
    yt-dlp
    google-cursor
    neovim
    starship
    spotify
    luarocks
    tmux
    lazygit
    lazydocker
    eza
    cava
    kitty
    fum
    # aider-chat
    dconf-editor
    adw-gtk3

    pciutils
    usbutils

    # steam/protone
    winetricks
    r2modman

    # qmk/vial
    qmk
    qmk_hid
    qmk-udev-rules
    # qmk.nvim
    keymapviz
    vial

    resources
    mission-center
    # GNOME Extensions
    gnomeExtensions.auto-accent-colour
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.edit-desktop-files
    gnomeExtensions.media-controls
    gnomeExtensions.vitals
    gnomeExtensions.appindicator
    gnomeExtensions.tiling-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.pip-on-top
    gnomeExtensions.caffeine
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.gsconnect
    gnomeExtensions.coverflow-alt-tab
    gnomeExtensions.compiz-windows-effect
    gnomeExtensions.reboottouefi
    # gnomeExtensions.system-monitor

    # Icons and Themes
    morewaita-icon-theme
  ];
  
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      inhibit-gnome
      mpris
      uosc
    ];
  };

  

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    # BROWSER = "google-chrome-stable";
    # GEM_HOME = "$HOME/.local/share/gem/ruby/3.4.0";
    # GEM_PATH = "$HOME/.local/share/gem/ruby/3.4.0";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
