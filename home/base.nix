{...}: {
  # Shared Home Manager config used by EVERY machine:
  # the full NixOS profile (home/nixos.nix) and the lean
  # standalone profile (home/lean.nix) both import this.
  #
  # Only put cross-platform things here — anything added here is
  # installed on macOS and non-NixOS Linux too.
  imports = [
    ./modules/cli.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/ssh.nix
    ./modules/symlinks-common.nix
  ];

  home.username = "xander";
  home.stateVersion = "25.11"; # must match system stateVersion

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  programs.home-manager.enable = true;

  # NOTE: home.homeDirectory is intentionally NOT set here — it differs
  # per machine and is set by home/nixos.nix (/home/xander) or injected
  # per-output in flake.nix for the standalone lean profiles.
}
