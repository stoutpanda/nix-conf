{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    
    interactiveShellInit = ''
      # Disable greeting
      set -g fish_greeting
    '';
  };

  # Set up bash to exec fish for interactive non-login shells
  programs.bash = {
    enable = true;
    
    # This runs for interactive non-login shells (like opening a terminal)
    bashrcExtra = ''
      # Launch fish for interactive sessions
      if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        exec ${pkgs.fish}/bin/fish
      fi
    '';
  };
}