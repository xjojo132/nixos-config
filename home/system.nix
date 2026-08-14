{...}: {
  # "system" profile — the shared base plus everything that only makes
  # sense on the full NixOS desktop: GUI apps and the Hyprland/Wayland stack.
  # Used by nixosConfigurations.xander in flake.nix.
  imports = [
    ./base.nix
    ./modules/apps.nix
    ./modules/desktop.nix
    ./modules/symlinks-desktop.nix
  ];

  home.homeDirectory = "/home/xander";

  # Rebuild aliases for the full NixOS system. The standalone profile defines
  # its own in home/home-manager.nix — see the note in modules/zsh.nix.
  programs.zsh.shellAliases = {
    nix-switch = "sudo nixos-rebuild switch --flake '.#xander'";
    nix-update = ''
      cd ~/nixos-config && \
      nix flake update && \
      sudo nixos-rebuild switch --flake '.#xander' && \
      git add flake.lock && \
      git commit -m "chore: bump flake inputs" && \
      git push
    '';
  };
}
