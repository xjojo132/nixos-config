{pkgs, ...}: {
  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
      nix-update = ''
        cd ~/nixos-config && \
        nix flake update && \
        sudo nixos-rebuild switch --flake '.#xander' && \
        git add flake.lock && \
        git commit -m "chore: bump flake inputs" && \
        git push
      '';
    };

    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
    ];
    initContent = builtins.readFile ./manjaro-zsh-config;
  };
}
