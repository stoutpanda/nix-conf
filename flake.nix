{
  description = "Hydenix with modular hardware configuration";

  inputs = {
    # User's nixpkgs - for user packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Hydenix and its nixpkgs - kept separate to avoid conflicts
    hydenix = {
      # Available inputs:
      # Main: github:richen604/hydenix
      # Dev: github:richen604/hydenix/dev
      # Commit: github:richen604/hydenix/<commit-hash>
      # Version: github:richen604/hydenix/v1.0.0
      url = "github:richen604/hydenix";
    };

    # Hardware-specific configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Nix-index-database - for comma and command-not-found
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { ... }@inputs:
    let
      # Helper function to create system configurations with host support
      mkSystem = hostname:
        inputs.hydenix.inputs.hydenix-nixpkgs.lib.nixosSystem {
          inherit (inputs.hydenix.lib) system;
          specialArgs = {
            inherit inputs hostname;
          };
          modules = [
            # Base Hydenix configuration
            ./configuration.nix
            
            # Host-specific hardware configuration
            ./hosts/${hostname}/hardware-configuration.nix
            
            # Host-specific overrides (if exists)
            ./hosts/${hostname}/configuration.nix
          ];
        };

    in
    {
      nixosConfigurations = {
        # Default configuration for compatibility
        nixos = mkSystem "whitedwarf-nixos";
        
        # Host-specific configurations
        whitedwarf-nixos = mkSystem "whitedwarf-nixos";
      };
    };
}
