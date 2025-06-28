{ config, pkgs, ... }:

{
  imports = [
    # ./example.nix - add your modules here
  ];

  environment.systemPackages = with pkgs.userPkgs; [
    # System packages that should be available to all users
    bitwarden-desktop # Also installing at system level
  ];

  # Enable ZSA keyboard support
  hardware.keyboard.zsa.enable = true;

  # Enable fish shell system-wide
  programs.fish.enable = true;

}
