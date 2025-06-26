{ config, lib, pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./bash.nix
    ./nushell.nix
    ./starship.nix
  ];
}
