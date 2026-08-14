{
  pkgs,
  lib,
  ...
}: {
  # "home-manager" profile — shell + dev tooling only, no GUI apps.
  # This is the standalone Home Manager config for machines that are NOT
  # NixOS: macOS and non-NixOS Linux. Applying it won't duplicate GUI apps
  # the OS already provides.
  #
  # home.homeDirectory is injected per-output in flake.nix
  # (/Users/xander on macOS, /home/xander on non-NixOS Linux).
  imports = [
    ./base.nix
  ];

  # The Nix installer writes its shell hook into /etc/zshrc, and macOS updates
  # restore that file to Apple's stock version — silently taking `nix`,
  # ~/.nix-profile/bin and NIX_PROFILES off the PATH. (Happened here on
  # 2026-08-02.) Sourcing the hook from the Home Manager owned ~/.zshenv
  # instead survives OS updates. ~/.zshenv is read before ~/.zshrc, so
  # NIX_PROFILES is set in time for the completions loop the generated zshrc
  # runs; and nix-daemon.sh self-guards with __ETC_PROFILE_NIX_SOURCED, so if
  # /etc/zshrc ever regains its hook this does not duplicate PATH entries.
  #
  # Lives in this profile rather than modules/zsh.nix because NixOS sets all
  # of this up itself and must not source the installer's script.
  programs.zsh.envExtra = ''
    if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fi
  '';

  # Sourcing the hook from ~/.zshenv (above) gets Nix onto PATH, but not at the
  # front: ~/.zshenv is read before /etc/zprofile, and /etc/zprofile runs macOS
  # `path_helper`, which REBUILDS PATH from /etc/paths — starting with
  # /usr/local/bin — and appends the pre-existing entries after it. That demotes
  # the Nix profiles to the bottom, so a /usr/local or Homebrew binary shadows
  # the Nix one (node, git, hx, lazygit, pnpm...). The installer's original hook
  # in /etc/zshrc avoided this only because /etc/zshrc runs after /etc/zprofile.
  #
  # ~/.zprofile is read after /etc/zprofile, so re-assert precedence here.
  # `typeset -U` keeps the first occurrence of each entry, making this a reorder
  # rather than a duplication. mkAfter orders this after the `brew shellenv`
  # line in modules/zsh.nix, so Nix also takes precedence over Homebrew.
  programs.zsh.profileExtra = lib.mkAfter ''
    typeset -U path PATH
    path=("$HOME/.nix-profile/bin" /nix/var/nix/profiles/default/bin $path)
  '';

  # Rebuild aliases for the standalone profile: `nixos-rebuild` does not exist
  # on these machines, and the flake target is the per-machine
  # homeConfigurations output rather than nixosConfigurations.xander.
  programs.zsh.shellAliases = let
    switch = "home-manager switch --flake '.#${
      if pkgs.stdenv.isDarwin
      then "xander@mac"
      else "xander@linux"
    }'";
  in {
    nix-switch = switch;
    nix-update = ''
      cd ~/nixos-config && \
      nix flake update && \
      ${switch} && \
      git add flake.lock && \
      git commit -m "chore: bump flake inputs" && \
      git push
    '';
  };
}
