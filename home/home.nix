{ config, lib,  pkgs, ... }:

{
  imports = [
    ./modules/git.nix
    ./modules/packages.nix
    ./modules/symlink.nix
    ./modules/zsh.nix
    ./modules/ssh.nix
  ];

  home.username = "xander";
  home.homeDirectory = "/home/xander";

  programs.home-manager.enable = true;

  home.stateVersion = "25.11"; # must match system stateVersion
}
