{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "stoutpanda";
    userEmail = "stoutpanda@protonmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
  programs.gh = {
   enable = true;
   
	};
}
