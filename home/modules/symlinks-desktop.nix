{
  config,
  lib,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/nixos-config/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";

  # Desktop-only dotfiles — Linux/NixOS (Hyprland) profile only.
  xdgLinks = {
    "hypr" = "hypr";
    "kitty" = "kitty";
    "waybar" = "waybar";
    "zed" = "zed";
    "rofi" = "rofi";
  };
in {
  xdg.configFile = lib.mapAttrs (_: path: {source = link path;}) xdgLinks;
}
