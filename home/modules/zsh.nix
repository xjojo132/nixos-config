{pkgs, ...}:

{
  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
  
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
