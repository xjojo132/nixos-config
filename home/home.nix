{ config, pkgs, ... }:

{
  imports = [
    # ./hyprland.nix
    # ./zsh.nix
     ./git.nix
    # ./zed.nix
  ];

  home.username = "xander";
  home.homeDirectory = "/home/xander";

  # User packages
  home.packages = with pkgs; [
    # Terminal & shell tools
    kitty
    starship
    zoxide
    fzf
    eza
    bat
    ripgrep
    helix
    # Apps
    firefox
    vesktop  # Discord
    spotify

    # Hyprland ecosystem
    waybar
    rofi
    hyprpaper
    swaynotificationcenter
    wl-clipboard
    cliphist
    grim
    slurp
  ];

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  services.ssh-agent.enable = true;
  home.stateVersion = "25.11"; # must match system stateVersion
}
