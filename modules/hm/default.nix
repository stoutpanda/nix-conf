{ pkgs, ... }:

{
  imports = [
    # ./example.nix - add your modules here
    # ./fish.nix - Disabled: Using hydenix's fish configuration instead
  ];

  # home-manager options go here
  home.packages = with pkgs.userPkgs; [
    # Terminal and file management
    nnn
    mc
    ghostty
    
    # Development tools
    lazygit
    jq
    yq-go
    eza
    ripgrep
    
    # System monitoring
    btop
    iotop
    iftop
    strace
    ltrace
    lsof
    sysstat
    # lm_sensors  # Removed - installed at system level via hydenix hardware module
    ethtool
    pciutils
    usbutils
    
    # Network tools
    mtr
    iperf3
    dnsutils
    ldns
    nmap
    ipcalc
    
    # Applications
    obsidian
    bitwarden-desktop
    signal-desktop
    google-chrome
    teamspeak5_client
    
    # Utilities
    glow
    brightnessctl
    claude-code
    nix-output-monitor
    fzf    
    # Archive tools
    zip
    xz
    unzip
    p7zip
    
    # Basic utilities
    cowsay
    # file  # Removed - already provided by system
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    whoami
  ];

  # Custom PATH configuration
  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];

  # hydenix home-manager options go here
  hydenix.hm = {
    enable = true;
    
    # Use Hydenix defaults with customizations
    comma.enable = true;
    dolphin.enable = true; # Using dolphin instead of nautilus
    
    editors = {
      enable = true;
      neovim = true;
      vscode = {
        enable = true;
        wallbash = true;
      };
      default = "code";
    };
    
    fastfetch.enable = true;
    firefox.enable = true; # Firefox as default browser
    
    git = {
      enable = true;
      name = "stoutpanda";
      email = "stoutpanda@protonmail.com";
    };
    
    hyde.enable = true;
    
    hyprland = {
      enable = true;
      extraConfig = "";
    };
    
    lockscreen = {
      enable = true;
      hyprlock = true;
      swaylock = false;
    };
    
    notifications.enable = true;
    qt.enable = true;
    rofi.enable = true;
    
    screenshots = {
      enable = true;
      grim.enable = true;
      slurp.enable = true;
      satty.enable = false;
      swappy.enable = true;
    };
    
    shell = {
      enable = true;
      zsh = {
        enable = false; # Disable zsh since we're using fish
        plugins = [ "sudo" ];
        configText = "";
      };
      bash.enable = true; # Keep bash as fallback
      fish.enable = true; # Enable fish as primary shell
      pokego.enable = true;
      p10k.enable = false;
      starship.enable = true; # Starship prompt
    };
    
    # Fix for missing hyde_config.fish file
    home.file.".config/fish/hyde_config.fish".source =
      "${pkgs.hyde-modified}/Configs/.config/fish/hyde_config.fish";
    social = {
      enable = true;
      discord.enable = true;
      webcord.enable = false;
      vesktop.enable = false;
    };
    
    spotify.enable = false;
    swww.enable = true;
    
    terminals = {
      enable = true;
      kitty = {
        enable = true; # Kitty as default terminal
        configText = "";
      };
    };
    
    theme = {
      enable = true;
      active = "Catppuccin Mocha";
      themes = [
        "Catppuccin Mocha"
        "Catppuccin Latte"
      ];
    };
    
    waybar = {
      enable = true;
      userStyle = "";
    };
    
    wlogout.enable = true;
    xdg.enable = true;
  };
  
  # GitHub CLI configuration
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enabled";
    };
  };
}
