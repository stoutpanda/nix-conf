{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ../../modules/desktop/gnome.nix
    ../../modules/audio/pipewire.nix
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402x-nvidia
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # LUKS encryption
  boot.initrd.luks.devices."luks-3e8010e8-8e35-45f0-8063-6f49fda6c09d".device = "/dev/disk/by-uuid/3e8010e8-8e35-45f0-8063-6f49fda6c09d";

  # ASUS laptop control daemon
  services.asusd = {
    enable = true;
    enableUserService = true;
    asusdConfig = {
      bat_charge_limit = 80;  # Set battery charge limit to 80%
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "25.11";
}
