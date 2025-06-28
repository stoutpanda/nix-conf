{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system (required for some apps even with Wayland)
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.displayManager.gdm = {
    enable = true;
    wayland = true; # This is the default, but being explicit
  };
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager)
  # services.xserver.libinput.enable = true;

  # Some GNOME-specific packages that might be useful
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.appindicator
    # Wayland-specific tools
    wl-clipboard
    wayland-utils
  ];

  # Exclude some default GNOME applications if desired
  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
  ];

  # QT theme integration with GNOME
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };
}
