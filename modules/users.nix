{ config, pkgs, ... }:

let
  
  username = "miocasa";
in
{
  users = {
    users = {
      ${username} = {
        isNormalUser = true;
        description = "Miocasa";
        extraGroups = [ "wheel" "audio" "video" "networkmanager" ];
        openssh.authorizedKeys.keys = [];
        shell = pkgs.zsh;
        
      };
    };
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
}