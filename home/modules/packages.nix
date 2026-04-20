{pkgs, inputs, ...}:

{
    home.packages = with pkgs; [
    # Terminal & shell tools
    kitty
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
    steam
    stremio-linux-shell
     inputs.zed.packages.${pkgs.system}.default

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
  ];

}
