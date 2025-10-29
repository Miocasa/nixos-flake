{ config, pkgs, lib, ... }:

{
  programs.spicetify.theme = {
  # Name of the theme (duh)
  name = "";
  # The source of the theme
  # make sure you're using the correct branch
  # It could also be a sub-directory of the repo
  src = pkgs.fetchFromGitHub {
    owner = "";
    repo = "";
    rev = "";
    hash = "";
  };
  
  # Additional theme options all set to defaults
  # the docs of the theme should say which of these 
  # if any you have to change
  injectCss = true;
  injectThemeJs = true;
  replaceColors = true;
  homeConfig = true;
  overwriteAssets = false;
  additonalCss = "";
}
}
