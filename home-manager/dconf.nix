{ config, pkgs, lib, ... }:

{
  dconf.settings = {
    # "org/gnome/desktop/input-sources" = {
    #   xkb-options = [ "ctrl:swapcaps" ];
    # };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      icon-theme = "MoreWaita";
      font-antialiasing = "rgba";
      font-hinting = "slight";
      enable-animations = true;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = lib.mkBefore (map (n: "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${toString n}/") (lib.range 0 6));
    };
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    #   name = "Chrome";
    #   command = "google-chrome-stable";
    #   binding = "<Super>b";
    # };

    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q" "<Alt>F4"];
    };
    "org/gnome/shell" = {
      disabled-extensions = [];
      disable-user-extensions = false;
      enabled-extensions = [
        "CoverflowAltTab@palatis.blogspot.com"
        "Vitals@CoreCoding.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "compiz-windows-effect@hermes83.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "gsconnect@andyholmes.github.io"
        "mediacontrols@cliffniff.github.com"
        "pip-on-top@rafostar.github.com"
        "space-bar@luchrioh"
        # "system-monitor@gnome-shell-extensions.gcampax.github.com"
        "tilingshell@ferrarodomenico.com"

      ];
      favorite-apps = [
        "google-chrome.desktop"
        "codium.desktop"
        "org.gnome.Console.desktop"
        "nautilus.desktop"
      ];
    };
    # "org/gnome/shell/extensions/openbar" = {
    #   autotheme-dark = "Dark";
    #   autotheme-light = "Dark";
    #   bartype = "Islands";
    #   dashdock-style = "Bar";
    #   autotheme-refresh = true;
    #   trigger-autotheme = true;
    #   margin = 1.0;
    #   height = 35.0;
    #   bradius = 5.0;
    #   dbradius = 5.0;
    #   isalpha = 0.71999999999999997;
    # };
    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = ["_processor_usage_" "_memory_usage_"];
      position-in-panel = 0;
      use-higher-precision = false;
      alphabetize = true;
      hide-zeros = false;
    };
    # "org/gnome/shell/extensions/blur-my-shell/applications" = {
    #   blur = true;
    #   brightness = 0.90;
    #   sigma = 2;
    #   opacity = 240;
    #   enable-all = true;
    #   blacklist = ["Plank" "com.desktop.ding" "Conky" "kitty" "dconf-editor"];
    # };
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
    };
    "org/gnome/shell/extensions/tilingshell" = {
      inner-gaps = 12;
      outer-gaps = 10;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
  };
}
