{ config, pkgs, ... }:

let
  
  username = "deck";
in
{
  users = {
    users = {
      ${username} = {
        isNormalUser = true;
        description = "deck";
        extraGroups = [ "wheel" "audio" "video" "networkmanager" ];
        openssh.authorizedKeys.keys = [];
        shell = pkgs.zsh;
        
      };
    };
  };
  

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;
}