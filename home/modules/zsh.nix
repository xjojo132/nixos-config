{
  pkgs,
  lib,
  ...
}: {
  programs.starship.enable = true;
  programs.zsh = {
    enable = true;

    # NOTE: the nix-switch / nix-update rebuild aliases are NOT defined here.
    # The command differs per profile (nixos-rebuild vs home-manager switch,
    # and a different flake target per machine), and this module is shared by
    # all of them — so each entry profile defines its own:
    # home/system.nix (NixOS) and home/home-manager.nix (standalone).

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

    # Homebrew (macOS only) — replaces the old ~/.zprofile `brew shellenv` line.
    profileExtra = lib.mkIf pkgs.stdenv.isDarwin ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

  # PATH entries that used to live in ~/.zshrc / ~/.zshenv.
  # cargo and ~/.local/bin are cross-platform; pnpm's dir differs per OS.
  home.sessionPath =
    [
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
    ]
    ++ (
      if pkgs.stdenv.isDarwin
      then ["$HOME/Library/pnpm/bin"]
      else ["$HOME/.local/share/pnpm"]
    );

  home.sessionVariables.PNPM_HOME =
    if pkgs.stdenv.isDarwin
    then "$HOME/Library/pnpm"
    else "$HOME/.local/share/pnpm";
}
