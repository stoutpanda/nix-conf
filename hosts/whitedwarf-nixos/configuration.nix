{ config, pkgs, inputs, hostname, ... }:

{
  imports = [
    # Import ASUS Zephyrus GA402X hardware optimizations
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402x-nvidia
  ];

  # Hostname configuration
  networking.hostName = "whitedwarf-nixos";
  hydenix.hostname = "whitedwarf-nixos";

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ASUS laptop control daemon for hardware management
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  # Enable AMD microcode updates
  hardware.cpu.amd.updateMicrocode = true;

  # NVIDIA GPU configuration (already handled by nixos-hardware module)
  # Additional GPU settings can be added here if needed

  # Audio configuration with PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

}
