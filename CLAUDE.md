# Claude Configuration Rules for NixOS Project

## Core Principles
- **KEEP IT SIMPLE** - This is for 3-4 personal machines, not a fleet. Avoid over-modularization.

## MCP Tool Usage Rules

### NixOS MCP Server
Always verify NixOS options and packages before writing code:

1. **Search for options first:**
   ```
   mcp__mcp-nixos__nixos_search "option_name" search_type="options"
   ```

2. **Get detailed information:**
   ```
   mcp__mcp-nixos__nixos_info "exact.option.path"
   ```

3. **For Home Manager options:**
   ```
   mcp__mcp-nixos__home_manager_search "option_name"
   mcp__mcp-nixos__home_manager_info "programs.firefox.enable"
   ```

4. **Verify package names:**
   ```
   mcp__mcp-nixos__nixos_search "package_name" search_type="packages"
   ```

### Context7 Documentation
Use Context7 for library documentation when available:
1. First resolve library ID: `mcp__context7__resolve-library-id "library_name"`
2. Then get docs: `mcp__context7__get-library-docs "/org/project" topic="relevant_topic"`

## Code Verification Workflow
Before writing ANY Nix configuration:
1. Verify the option exists using MCP search
2. Check the exact option type and accepted values
3. Confirm if it's a system option or home-manager option
4. Use the exact paths returned by MCP tools

## Testing Commands
Always test before applying:
```bash
# Check flake validity
nix flake check

# Build without switching
nixos-rebuild build --flake .#hostname

# Apply changes
sudo nixos-rebuild switch --flake .#hostname
```

## Project Structure Reference
See `plan.md` for the agreed-upon directory structure and implementation plan.