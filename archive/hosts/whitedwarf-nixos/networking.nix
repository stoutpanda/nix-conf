{ config, lib, pkgs, ... }:

{
  networking.hostName = "whitedwarf-nixos";
  
  # Enable NetworkManager
  networking.networkmanager.enable = true;
  # Enable the dhcp.  
  networking.useDHCP = lib.mkDefault true;
   networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
