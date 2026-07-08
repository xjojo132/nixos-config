{pkgs, ...}: {
  # Hyprland / Wayland desktop stack and system tray utilities — Linux/NixOS only.
  home.packages = with pkgs; [
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
    hyprls

    # System / desktop utilities
    brightnessctl
    networkmanager
    networkmanagerapplet
    gnome-keyring
    gparted
    pavucontrol
  ];
}
