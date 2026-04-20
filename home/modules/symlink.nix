{config, lib, ...}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-config/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";

  xdgLinks = {
    "hypr"          = "hypr";
    "kitty"         = "kitty";
    "waybar"        = "waybar";
    "zed"           = "zed";
    "starship.toml" = "starship/starship.toml";
    "rofi" = "rofi";
    "helix" = "helix";
  };

  # homeLinks = {
  #   ".zshrc"  = "zsh/.zshrc";
  #   ".zshenv" = "zsh/.zshenv";
  # };
in
{
  xdg.configFile = lib.mapAttrs (_: path: { source = link path; }) xdgLinks;
  # home.file      = lib.mapAttrs (_: path: { source = link path; }) homeLinks;

}
