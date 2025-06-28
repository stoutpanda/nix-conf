{ config, pkgs, ... }:

{
  imports = [
    # ./example.nix - add your modules here
  ];

  environment.systemPackages = with pkgs.userPkgs; [
    # System packages that should be available to all users
    bitwarden-desktop # Also installing at system level
  ];

  # Enable Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Add user to docker group
  users.users.jason.extraGroups = [ "docker" ];

  # Enable ZSA keyboard support
  hardware.keyboard.zsa.enable = true;

  # Enable fish shell system-wide
  programs.fish.enable = true;

  # Set fish as default shell for user
  users.users.jason.shell = pkgs.userPkgs.fish;
}
