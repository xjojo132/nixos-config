{...}: {
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
}
