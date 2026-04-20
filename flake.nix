{
  description = "Xander's NixOS config";

  inputs = {
    # Pin nixpkgs to a specific channel — "nixos-unstable" for latest packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager — must follow the same nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # Your NixOS system config
    homeConfigurations.xander = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = ["./home/home.nix"];
    };
    nixosConfigurations.xander = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/xander/configuration.nix

        # Wire Home Manager into the NixOS build
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.xander = import ./home/home.nix;
        }
      ];
    };
  };
}
