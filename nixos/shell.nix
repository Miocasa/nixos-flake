{ pkgs, ... }:
{
  # Install zsh
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "sudo" ];
    custom = "$HOME/.oh-my-zsh/custom/";
    theme = "robbyrussell";
  };

  # environment.systemPackages = with pkgs; [ zsh-powerlevel10k ];
  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   enableBashCompletion = true;
  #   autosuggestions.enable = true;
  #   syntaxHighlighting.enable = true;
  #   histSize = 10000;
  #   shellAliases = {
  #     #...
  #   };
  #   setOptions = [
  #     "AUTO_CD"
  #   ]
  #   prompInit = ''
  #     source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
  #   '';
  #   ohMyZsh = {
  #     enable = true;
  #     plugins = [ "git" "dirhistory" "history" ];
  #   };
  # };
  # users.defaultUserShell = pkgs.zsh;
  # system.userActivationScripts.zshrc = "touch .zshrc";
  # environment.shells = with pkgs; [ zsh ];
}