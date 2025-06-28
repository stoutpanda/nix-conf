{
  inputs,
  ...
}:
let
  # Package declaration
  # ---------------------

  pkgs = import inputs.hydenix.inputs.hydenix-nixpkgs {
    inherit (inputs.hydenix.lib) system;
    config.allowUnfree = true;
    overlays = [
      inputs.hydenix.lib.overlays
      (final: prev: {
        userPkgs = import inputs.nixpkgs {
          inherit (inputs.hydenix.lib) system;
          config.allowUnfree = true;
        };
      })
    ];
  };
in
{

  # Set pkgs for hydenix globally, any file that imports pkgs will use this
  nixpkgs.pkgs = pkgs;

  imports = [
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    # Hardware configuration is now loaded from host-specific directory via flake.nix
    inputs.hydenix.lib.nixOsModules
    ./modules/system

    # === Common hardware modules ===
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc-ssd
    
    # Host-specific hardware modules are loaded in hosts/${hostname}/configuration.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    #! EDIT THIS USER (must match users defined below)
    users."jason" =
      { ... }:
      {
        imports = [
          inputs.hydenix.lib.homeModules
          # Nix-index-database - for comma and command-not-found
          inputs.nix-index-database.hmModules.nix-index
          ./modules/hm
        ];
      };
  };

  # IMPORTANT: Customize the following values to match your preferences
  hydenix = {
    enable = true; # Enable the Hydenix module

    # Hostname is now set per-host in hosts/${hostname}/configuration.nix
    timezone = "America/Chicago"; # Change to your timezone
    locale = "en_US.UTF-8"; # Change to your preferred locale

    # Enable all Hydenix modules with custom settings
    audio.enable = true; # enable audio module
    boot = {
      enable = true; # enable boot module
      useSystemdBoot = true; # use systemd-boot (configured per-host)
      kernelPackages = pkgs.linuxPackages_zen; # zen kernel for better desktop performance
    };
    gaming.enable = false; # disable gaming module for now
    hardware.enable = true; # enable hardware module
    network.enable = true; # enable network module (includes NetworkManager)
    nix.enable = true; # enable nix module
    sddm = {
      enable = true; # enable sddm module
      theme = "Candy"; # or "Corners"
    };
    system.enable = true; # enable system module
  };

  users.users.jason = {
    isNormalUser = true; # Regular user account
    initialPassword = "jason"; # Default password (CHANGE THIS after first login with passwd)
    extraGroups = [
      "wheel" # For sudo access
      "networkmanager" # For network management
      "video" # For display/graphics access
      "audio" # For audio access
      "input" # For input devices
      # Add other groups as needed
    ];
    shell = pkgs.userPkgs.fish; # Using fish as default shell
  };

  #system.stateVersion = "25.11";
}
