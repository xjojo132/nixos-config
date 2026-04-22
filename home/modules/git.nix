{...}: {
  programs.git = {
    enable = true;
    settings.user.name = "xjojo132";
    settings.user.email = "xj.remmelink@gmail.com";

    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = false;
      core.editor = "hx";
    };

    # Your aliases
    settings.aliases = {
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
