{
  config,
  lib,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/nixos-config/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";

  # Linux desktop (Hyprland/Wayland) configs — NixOS profile only.
  # These target Linux compositors and have no effect on macOS, so they
  # stay out of the lean profile. Cross-platform app configs go in
  # symlinks-common.nix instead.
  xdgLinks = {
    "hypr" = "hypr";
    "waybar" = "waybar";
    "rofi" = "rofi";
  };
in {
  xdg.configFile = lib.mapAttrs (_: path: {source = link path;}) xdgLinks;
}
