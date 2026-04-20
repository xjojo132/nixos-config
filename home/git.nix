{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "xjojo132";
    userEmail = "xj.remmelink@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = false;
      core.editor = "hx";
    };

    # Your aliases
    aliases = {
      st = "status";
      lg = "log --oneline --graph --decorate";
      undo = "reset HEAD~1 --mixed";
    };

    # Delta for nicer diffs (optional but great)
    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
      };
    };

    ignores = [
      ".DS_Store"
      "node_modules"
      ".env"
      ".env.local"
    ];
  };
}
