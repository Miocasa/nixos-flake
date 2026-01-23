{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      # theme = "powerlevel10k";
      plugins = [
        "git"
        # "archlinux"
        "docker"
        "kubectl"
      ];
    };
    # plugins = [
    #   {
    #     name = "powerlevel10k";
    #     src = pkgs.zsh-powerlevel10k;
    #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #   }
    # ];
    
    initContent = lib.mkBefore ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top.
      # if [[ -r "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      #   source "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
      # fi

      # Powerlevel10k — подгружаем свой конфиг
      # [[ ! -f ${config.xdg.configHome}/p10k.zsh ]] || source ${config.xdg.configHome}/p10k.zsh

      # Ваши полезные переменные
      export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
      export MANPATH="/nix/var/nix/profiles/default/share/man:$MANPATH"

      # git global config
      git config --global user.email "narimanabdualiev06@gmail.com"
      git config --global user.name "Miocasa"

      # Ваши алиасы
      alias q='qs -c ii'

      export TERM=xterm-256color

      # Rust cache
      export RUSTC_WRAPPER=sccache
    '';

    
    shellAliases = {
      pamcan = "pacman";
      ls = "eza --icons";
       clear = "printf '\\e[2J\\e[3J\\e[1;1H'";
    };
    
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
  # home.file.".config/p10k.zsh".source = ./accets/.p10k.zsh;
  
}