{...}: {
  # LEAN profile — shell + dev tooling only, no GUI apps.
  # Safe to `home-manager switch` on macOS and non-NixOS Linux
  # without duplicating apps the OS already provides.
  #
  # home.homeDirectory is injected per-output in flake.nix
  # (/Users/xander on macOS, /home/xander on non-NixOS Linux).
  imports = [
    ./base.nix
  ];
}
