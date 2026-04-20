{ config, lib,  pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos-config/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";

  xdgLinks = {
    "hypr"          = "hyprland";
    "kitty"         = "kitty";
    "waybar"        = "waybar";
    "zed"           = "zed";
    "starship.toml" = "starship/starship.toml";
  };

  # homeLinks = {
  #   ".zshrc"  = "zsh/.zshrc";
  #   ".zshenv" = "zsh/.zshenv";
  # };
in
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
    
    firefox
    vesktop
    discord
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

  xdg.configFile = lib.mapAttrs (_: path: { source = link path; }) xdgLinks;
  # home.file      = lib.mapAttrs (_: path: { source = link path; }) homeLinks;
  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
  
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
  
  
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
    ];
    initExtra = builtins.readFile ./manjaro-zsh-config;
  };

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
