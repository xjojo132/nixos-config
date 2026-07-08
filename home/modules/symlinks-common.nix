{
  config,
  lib,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/nixos-config/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";

  # Cross-platform dotfiles — symlinked on every machine (part of the base).
  xdgLinks = {
    "ghostty" = "ghostty";
    "helix" = "helix";
    "starship.toml" = "starship/starship.toml";
  };
in {
  xdg.configFile = lib.mapAttrs (_: path: {source = link path;}) xdgLinks;
}
