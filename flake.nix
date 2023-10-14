{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland.url = "github:hyprwm/Hyprland";
    };

    outputs = { nixpkgs, home-manager, hyprland, ... }:
    let
        system = "x86_64-linux";
        modules = [
            ./nixos/configuration.nix
        ];
    in
    {
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                inherit modules system;
            };
        };

        homeConfigurations = {
            server = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.${system};
                modules = [
                    ./home-manager/default.nix
                ];
            };
            
            desktop = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.${system};
                modules = [
                    hyprland.homeManagerModules.default
                    ./home-manager/default.nix
                    ./home-manager/desktop.nix
                    ./home-manager/hyprland
                    ./home-manager/neovim
                ];
            };
        };
    };
}
