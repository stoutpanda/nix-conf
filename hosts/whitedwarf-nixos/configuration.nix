{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ../../modules/desktop/gnome.nix
    ../../modules/audio/pipewire.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # LUKS encryption
  boot.initrd.luks.devices."luks-3e8010e8-8e35-45f0-8063-6f49fda6c09d".device = "/dev/disk/by-uuid/3e8010e8-8e35-45f0-8063-6f49fda6c09d";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "25.11";
}