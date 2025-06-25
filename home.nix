{ config, pkgs, ... }:

{
  imports = [
    ./home-modules/shell
    ./home-modules/programs/git.nix
  ];

  home.username = "jason";
  home.homeDirectory = "/home/jason";

  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
    # Terminal file managers
    nnn
    mc

    # Terminals
    ghostty

    # Editors
    vscode
    neovim

    # Archives
    zip
    xz
    unzip
    p7zip

    # Utils
    ripgrep
    jq
    yq-go
    eza
    fzf

    # Networking tools
    mtr
    iperf3
    dnsutils
    ldns
    nmap
    ipcalc

    # Misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    whoami

    # Nix related
    nix-output-monitor

    # Productivity
    glow
    obsidian

    # System monitoring
    btop
    iotop
    iftop

    # System call monitoring
    strace
    ltrace
    lsof

    # System tools
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils

    # Claude
    claude-code
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with
  home.stateVersion = "25.11";
}