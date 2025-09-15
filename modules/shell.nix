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
}