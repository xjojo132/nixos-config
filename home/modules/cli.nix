{pkgs, ...}: {
  # Cross-platform CLI / developer tooling.
  # Everything here must build on macOS (aarch64-darwin) as well as Linux,
  # because this module is part of the shared base (home/base.nix).
  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.jetbrains-mono

    # Terminal & shell tools
    starship
    fzf
    bat
    helix
    btop
    fastfetch
    yazi
    lazygit

    # Dev toolchains
    nodejs
    pnpm
    uv
    python3
    python3Packages.pip
    postgresql

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

    # Formatters
    alejandra
    prettier
  ];
}
