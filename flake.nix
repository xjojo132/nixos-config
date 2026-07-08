{
  description = "Xander's NixOS + Home Manager config";

  inputs = {
    # Pin nixpkgs to a specific channel — "nixos-unstable" for latest packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager — must follow the same nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    # Build a nixpkgs set for a given system, with unfree packages allowed.
    pkgsFor = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    # Passed to every Home Manager module so they can reach flake inputs.
    extraSpecialArgs = {inherit inputs;};
  in {
    # ── Full NixOS system (Linux) ────────────────────────────────
    # Everything: the shared base + GUI apps + Hyprland/desktop stack.
    nixosConfigurations.xander = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/xander/configuration.nix

        # Wire Home Manager into the NixOS build
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = extraSpecialArgs;
          home-manager.users.xander = import ./home/system.nix;
        }
      ];
    };

    # ── Standalone Home Manager — "home-manager" profile ─────────
    # Shell + dev tooling only (no GUI apps). Apply with:
    #   home-manager switch --flake '.#xander@mac'      (this Mac)
    #   home-manager switch --flake '.#xander@linux'    (non-NixOS Linux)

    # macOS (Apple Silicon)
    homeConfigurations."xander@mac" = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor "aarch64-darwin";
      inherit extraSpecialArgs;
      modules = [
        ./home/home-manager.nix
        {home.homeDirectory = "/Users/xander";}
      ];
    };

    # non-NixOS Linux (x86_64)
    homeConfigurations."xander@linux" = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor "x86_64-linux";
      inherit extraSpecialArgs;
      modules = [
        ./home/home-manager.nix
        {home.homeDirectory = "/home/xander";}
      ];
    };
  };
}
