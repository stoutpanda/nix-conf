{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "stoutpanda";
    userEmail = "stoutpanda@protonmail.com";
  };
}