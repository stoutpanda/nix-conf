{ config, lib, pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./bash.nix
    ./starship.nix
  ];
}