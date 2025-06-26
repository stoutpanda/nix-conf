{ config, pkgs, inputs, ... }:

{
  # Set your time zone
  time.timeZone = "America/Chicago";

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Define a user account
  users.users.jason = {
    isNormalUser = true;
    description = "jason";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      thunderbird
      bitwarden-desktop
      ghostty
      claude-code    
      obsidian
      starship
      neovim
      vscode
    ];
  };

  # Enable programs
  programs.fish.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    wget
    htop
    curl
    git
    docker
    vim
    wally
    keymapp
  ];

  # Set vim as default editor
  environment.variables.EDITOR = "vim";

  # Enable flakes and nix command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

  # Enable ZSA keyboard support
  hardware.keyboard.zsa.enable = true;
}
