{ config, pkgs, ... }:

{
  # GTK Configs
  gtk.enable = true;

  gtk = {
    cursorTheme = {
      package = pkgs.google-cursor;
      name = "GoogleDot-Blue";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "Adw-gtk-dark";
    };
    iconTheme = {
      package = pkgs.morewaita-icon-theme;
      name = "MoreWaita";
    };
  };

  # QT Configs
  qt.enable = true;

  qt = {
    platformTheme = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}