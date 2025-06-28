{ config, pkgs, ... }:

{
  # Fish shell configuration
  programs.fish = {
    enable = true;
    
    # Disable greeting
    interactiveShellInit = ''
      set -g fish_greeting
    '';
    
    };
    
    # Fish functions
    functions = {
      # Custom functions can be added here
    };
  };
  
  # Configure bash to exec into fish for interactive sessions
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
    # Exec into fish for interactive sessions
    initExtra = ''
      if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.userPkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
