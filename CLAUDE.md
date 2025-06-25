# NixOS Configuration - Iterative Modularization

## Project Status
Currently transitioning from a monolithic `/etc/nixos` configuration to a modular, flake-based structure.

## Architecture Guide: When to Use What

### NixOS System Modules vs Home Manager

#### Use NixOS System Modules for:
- **System services and daemons** (SSH, Docker, systemd services)
- **Hardware configuration** (graphics drivers, kernel modules, firmware)
- **System-wide software** that needs root access or must work for all users
- **Security settings** (firewall, sudo rules, PAM configuration)
- **Boot configuration** (bootloader, kernel parameters, LUKS)
- **Networking** (NetworkManager, wireguard, system DNS)
- **Desktop environments** (GNOME, KDE, display managers)

#### Use Home Manager for:
- **User applications** (browsers, editors, terminal emulators)
- **Dotfiles and user configs** (.bashrc, .gitconfig, app settings)
- **Development environments** (language-specific tools, IDEs)
- **User shell configuration** (fish, zsh, starship)
- **Desktop customizations** (themes, fonts, user keybindings)
- **User systemd services** (that don't need root)

#### Key Principle:
If it needs root, affects all users, or is a system service → **NixOS module**
If it's user-specific, a dotfile, or a user application → **Home Manager**

### Flakes Role in Architecture

Flakes provide:
1. **Reproducible builds** - Lock file ensures consistent versions
2. **Clear dependencies** - Explicit inputs declaration
3. **Better composition** - Easy to combine multiple configurations
4. **Standard structure** - Predictable entry points

### Directory Structure Best Practices

```
.
├── flake.nix          # Entry point - defines inputs and outputs
├── flake.lock         # Locked dependencies
├── hosts/             # Machine-specific configurations
│   └── hostname/
│       ├── configuration.nix  # Host-specific settings
│       ├── hardware.nix       # Hardware configuration
│       └── networking.nix     # Host networking
├── modules/           # Reusable NixOS system modules
│   ├── audio/         # Audio subsystem (PipeWire, ALSA)
│   ├── desktop/       # Desktop environments
│   ├── hardware/      # Hardware support modules
│   ├── security/      # Security configurations
│   └── services/      # System services
├── home-modules/      # Reusable Home Manager modules
│   ├── shell/         # Shell configurations
│   ├── programs/      # User applications
│   └── development/   # Dev environments
├── home.nix           # Base home-manager configuration
└── configuration.nix  # Common system configuration
```

## Current Configuration Analysis

### Files Present
- `configuration.nix` - Main system configuration (154 lines)
- `hardware-configuration.nix` - Hardware-specific settings
- `flake.nix` - Flake definition with home-manager integration
- `home.nix` - User-specific home-manager configuration

### Key Configuration Elements

#### System Configuration (`configuration.nix`)
- **Boot**: systemd-boot with LUKS encryption
- **Desktop**: GNOME with GDM
- **Audio**: PipeWire (replacing PulseAudio)
- **Networking**: NetworkManager
- **Services**: OpenSSH, Docker
- **Hardware**: ZSA keyboard support
- **Users**: Single user 'jason' with various packages

#### Home Configuration (`home.nix`)
- Development tools (neovim, vscode, git)
- System utilities (ripgrep, fzf, eza, etc.)
- Networking tools
- Shell configuration (bash, fish, starship)

## Modularization Plan

### Phase 1: Basic Structure Setup
1. Create directory structure for modules
2. Move hardware-specific configurations
3. Separate system services

### Phase 2: System Modules
1. Boot and kernel configuration
2. Desktop environment (GNOME)
3. Audio (PipeWire)
4. Networking
5. Security and SSH

### Phase 3: User/Home Modules
1. Development environments
2. Shell configurations
3. User packages
4. Git configuration

### Phase 4: Machine-Specific Configurations
1. Create host-specific directories
2. Move machine-specific settings
3. Update flake for multi-machine support

## Design Decisions to Make

1. **Module Granularity**: How fine-grained should modules be?
2. **Directory Structure**: Follow NixOS conventions or custom organization?
3. **Option Definitions**: Which configurations should be parameterized?
4. **Default Values**: What defaults make sense for reusability?
5. **Dependencies**: How to handle inter-module dependencies?

## Module Design Guidelines

### Creating Reusable Modules

1. **Make modules configurable** with options when appropriate
2. **Use `mkDefault`** for overrideable defaults
3. **Document options** with descriptions
4. **Consider dependencies** between modules
5. **Test modules** independently when possible

### Example Module Pattern

```nix
{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.services.myservice;
in {
  options.services.myservice = {
    enable = mkEnableOption "my service";
    
    port = mkOption {
      type = types.port;
      default = 8080;
      description = "Port for my service";
    };
  };
  
  config = mkIf cfg.enable {
    # Implementation
  };
}
```

## Common Patterns

### Mixed Approach
- Keep system modules for system-wide needs
- Use Home Manager as a NixOS module (not standalone)
- Set `home-manager.useGlobalPkgs = true` for consistency
- Share package set between system and home configurations

### Security Benefits
- Minimize system-level software installation
- User-space applications reduce attack surface
- Better isolation between users in multi-user systems

## Next Steps

Continue modularizing by category:
1. Extract remaining system services (SSH, Docker, printing)
2. Create security modules
3. Develop more granular home-manager modules
4. Add machine-specific hardware modules

## Notes
- Using NixOS MCP tools for searching packages and options
- Iterative approach allows for testing at each step
- Maintaining working configuration throughout the process
- Following community best practices for maintainability