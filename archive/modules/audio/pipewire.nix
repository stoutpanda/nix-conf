{ config, lib, pkgs, ... }:

{
  # Disable PulseAudio
  services.pulseaudio.enable = false;
  
  # Enable RealtimeKit for better audio performance
  security.rtkit.enable = true;
  
  # Enable PipeWire
  services.pipewire = {
    enable = true;
    
    # Enable ALSA support
    alsa.enable = true;
    alsa.support32Bit = true;
    
    # Enable PulseAudio compatibility
    pulse.enable = true;
    
    # Uncomment to enable JACK applications support
    # jack.enable = true;
    
    # WirePlumber is enabled by default as the session manager
    wireplumber.enable = true;
  };
}