{pkgs, ...}: {
  home.packages = with pkgs; [
    #fonts
    nerd-fonts.jetbrains-mono

    # Terminal & shell tools
    kitty
    ghostty
    starship
    fzf
    bat
    helix
    brightnessctl
    btop
    networkmanager
    fastfetch
    gnome-keyring
    gparted
    nodejs
    onedrive
    pavucontrol
    postgresql
    yazi
    lazygit
    pnpm

    # Apps
    firefox
    vesktop
    discord
    spotify
    bitwarden-desktop
    docker
    libreoffice
    prismlauncher
    networkmanagerapplet
    onedrivegui
    postman
    stremio-linux-shell
    zed-editor

    # Hyprland ecosystem
    waybar
    rofi
    hyprpaper
    swaynotificationcenter
    wl-clipboard
    cliphist
    grim
    slurp
    quickshell

    # LSPs
    nixd
    typescript-language-server
    typescript
    rust-analyzer
    python3Packages.python-lsp-server
    vscode-langservers-extracted
    bash-language-server
    marksman
    taplo
    hyprls

    # Formatters
    alejandra
    prettier

    # Python
    python3
    python3Packages.pip
    uv
  ];
}
