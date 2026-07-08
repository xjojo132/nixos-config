{...}: {
  # FULL profile — the shared base plus everything that only makes
  # sense on the NixOS desktop: GUI apps and the Hyprland/Wayland stack.
  # Used by nixosConfigurations.xander in flake.nix.
  imports = [
    ./base.nix
    ./modules/apps.nix
    ./modules/desktop.nix
    ./modules/symlinks-desktop.nix
  ];

  home.homeDirectory = "/home/xander";
}
