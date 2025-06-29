# NixOS Modular Configuration Project Plan

## Project Overview
Create a simple, modular NixOS configuration using flakes and home-manager for 3-4 personal machines, with per-user desktop environment selection.

## Directory Structure
```
nix-conf/
├── flake.nix                 # Main entry point with inputs and system definitions
├── flake.lock               # Lock file for reproducible builds
├── configuration.nix        # Shared system configuration for all machines
├── hosts/                   # Machine-specific hardware configurations
│   ├── desktop/
│   │   └── hardware-configuration.nix
│   ├── laptop/
│   │   └── hardware-configuration.nix
│   └── workstation/
│       └── hardware-configuration.nix
├── de/                      # Desktop environment modules
│   ├── gnome.nix           # GNOME desktop configuration
│   ├── plasma.nix          # KDE Plasma configuration
│   └── hyprland.nix        # Hyprland window manager configuration
└── home/                    # User-specific configurations
    ├── jason.nix           # Jason's home-manager configuration
    └── guest.nix           # Guest user configuration
```

## Implementation Rules

### 1. Code Verification Process
**Before writing any Nix code:**
- Use `mcp__mcp-nixos__nixos_search` to verify option names and types
- Use `mcp__mcp-nixos__home_manager_search` for home-manager options
- Check `mcp__mcp-nixos__nixos_info` for detailed package information
- Consult Context7 documentation when available

**Example workflow:**
```
1. Search for option: mcp__mcp-nixos__nixos_search "services.xserver.desktopManager"
2. Get details: mcp__mcp-nixos__nixos_info "services.xserver.desktopManager.gnome.enable"
3. Verify package: mcp__mcp-nixos__nixos_search "gnome" search_type="packages"
```

### 2. File Creation Order
1. **flake.nix** - Define inputs and nixosSystem configurations
2. **configuration.nix** - Base system setup
3. **hosts/*/hardware-configuration.nix** - Copy from existing or generate
4. **de/*.nix** - Desktop environment modules
5. **home/*.nix** - User configurations

### 3. Coding Standards
- **Always verify options exist** before using them
- **Use the exact option paths** returned by MCP tools
- **Test incrementally** with `nixos-rebuild build` before `switch`
- **Document non-obvious choices** with comments
- **Keep it simple** - avoid over-abstraction

### 4. Desktop Environment Module Structure
Each DE module should include:
```nix
{ config, pkgs, lib, ... }: {
  # Core DE packages
  home.packages = with pkgs; [ ... ];
  
  # DE-specific settings
  dconf.settings = { ... };  # For GNOME
  programs.plasma = { ... };  # For KDE
  wayland.windowManager.hyprland = { ... };  # For Hyprland
  
  # Common applications for the DE
  # Theme settings
}
```

### 5. Testing Protocol
1. Run `nix flake check` to validate flake
2. Build without switching: `nixos-rebuild build --flake .#hostname`
3. Review changes: `nixos-rebuild build --flake .#hostname --show-trace`
4. Apply changes: `sudo nixos-rebuild switch --flake .#hostname`

## Plan Updates
This plan should be updated when:
- New machines are added
- New desktop environments are configured
- Major structural changes are made
- New users are added

## Verification Checklist
Before implementing each component:
- [ ] Search for the NixOS option using MCP
- [ ] Verify option type and accepted values
- [ ] Check if option is for system or home-manager
- [ ] Look up package names for correctness
- [ ] Test syntax with `nix flake check`

## Next Steps
1. Back up current configuration
2. Create directory structure
3. Begin implementation following verification rules
4. Test each component incrementally
5. Document any deviations from this plan