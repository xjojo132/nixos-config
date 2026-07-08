{pkgs, ...}: {
  # GUI applications — Linux/NixOS only.
  # Kept out of the lean profile so standalone Home Manager on macOS or
  # non-NixOS Linux doesn't install duplicates of apps the OS already has.
  home.packages = with pkgs; [
    # Terminals & editors
    kitty
    ghostty
    zed-editor

    # Apps
    firefox
    vesktop
    discord
    spotify
    docker
    libreoffice
    prismlauncher
    postman
    stremio-linux-shell
    onedrive
    onedrivegui
  ];
}
