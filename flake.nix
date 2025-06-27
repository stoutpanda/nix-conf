	{
  description = "NixOS System Configuration";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Nixos Hyprland
    inputs.hyprland.url = "github:hyprwm/Hyprland";  
    # Home Manager for user configuration management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Hardware-specific configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    # Systems definitions
    systems.url = "github:nix-systems/default";
    
  };
  
  outputs = { self, nixpkgs, home-manager, nixos-hardware, flake-utils, systems, ... }@inputs: 
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
