# NixOS Configuration

This repository contains my personal NixOS system configuration.

## Overview

This is a NixOS configuration repository that manages system settings, packages, and services declaratively. The configuration is currently set up for my primary machine and is being structured to support multiple machines in the future.

## Current Setup

The configuration includes:
- System packages and services
- User environment settings
- Hardware-specific configurations for my laptop

## Multi-Machine Support

This repository is evolving towards a modular structure that will support multiple machines with shared base configurations and machine-specific customizations.

## Usage

To rebuild the system with this configuration:

```bash
sudo nixos-rebuild switch --flake .
```
To update:

```bash
sudo nix flake update
sudo nixos-rebuild upgrade
sudo nixos-rebuild switch --flake .
```

** Personal configuration files - use at your own risk.**
