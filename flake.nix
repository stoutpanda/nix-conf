	{
  description = "NixOS System Configuration";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Home Manager for user configuration management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Flake utilities for better system support
    flake-utils.url = "github:numtide/flake-utils";
    
    # Systems definitions
    systems.url = "github:nix-systems/default";
    
    # Optional: Helix editor (uncomment if needed)
    # helix = {
    #   url = "github:helix-editor/helix/master";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  
  # Binary cache configuration
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  outputs = { self, nixpkgs, home-manager, flake-utils, systems, ... }@inputs: 
    let
      # Helper function to create system configurations
      mkSystem = system: hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            # Common configuration for all hosts
            ./configuration.nix
            
            # Host-specific configuration
            ./hosts/${hostname}/configuration.nix
            
            # Home-manager NixOS module
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                
                # User configurations
                users.jason = import ./home.nix;
              };
            }
          ];
        };
    in
    {
      # NixOS configurations
      nixosConfigurations = {
        whitedwarf-nixos = mkSystem "x86_64-linux" "whitedwarf-nixos";
      };
    };
}
