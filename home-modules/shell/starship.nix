{ config, lib, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    
    # Enable for all supported shells
    enableBashIntegration = true;
    enableFishIntegration = true;
    
    # Basic configuration
    settings = {
      # You can customize the prompt here if needed
      # For now, using defaults
    };
  };
}