{
  config,
  lib,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/nixos-config/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";

  # Cross-platform app configs — symlinked on EVERY machine (lean + full).
  #
  # To add another config in the future, add a line:
  #     "<name under ~/.config>" = "<path under dotfiles/>";
  # Use a directory (e.g. "kitty") to link a whole config folder, or a file
  # path (e.g. "zed/settings.json") to link just one file and leave the rest
  # of that app's folder (prompts, themes, ...) as untouched local files.
  # The matching dotfiles/<path> must exist in this repo.
  xdgLinks = {
    "ghostty" = "ghostty";
    "helix" = "helix";
    "starship.toml" = "starship/starship.toml";
    "kitty" = "kitty";
    "zed/settings.json" = "zed/settings.json";
  };
in {
  xdg.configFile = lib.mapAttrs (_: path: {source = link path;}) xdgLinks;
}
