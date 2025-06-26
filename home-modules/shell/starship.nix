{ config, lib, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableInteractive = true;
    # Enable for all supported shells
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    
    # Basic configuration
    settings = {
      # You can customize the prompt here if needed
      # For now, using defaults
    };
  };
}
