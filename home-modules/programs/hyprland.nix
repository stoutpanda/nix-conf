{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.hyprland-config;
in
{
  options.programs.hyprland-config = {
    enable = mkEnableOption "Hyprland window manager configuration";
    
    monitors = mkOption {
      type = types.listOf types.str;
      default = [ ",preferred,auto,auto" ];
      description = "Monitor configuration settings";
      example = [ 
        "DP-5, 6016x3384@60.00, auto, 2"
        "eDP-1, 2880x1920@120.00, auto, 2"
      ];
    };
    
    terminal = mkOption {
      type = types.str;
      default = "ghostty";
      description = "Default terminal emulator";
    };
    
    browser = mkOption {
      type = types.str;
      default = "google-chrome-stable --new-window --ozone-platform=wayland";
      description = "Default web browser with launch options";
    };
    
    webApps = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable web application shortcuts";
      };
    };
  };

  config = mkIf cfg.enable {
    # Enable Hyprland
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      
      settings = {
        # Monitor configuration
        monitor = cfg.monitors;
        
        # Variables for default applications
        "$terminal" = cfg.terminal;
        "$fileManager" = "nautilus --new-window";
        "$browser" = cfg.browser;
        "$music" = "spotify";
        "$passwordManager" = "bitwarden";
        "$messenger" = "signal-desktop";
        "$webapp" = "$browser --app";
        
        # Key bindings for web applications
        bind = mkIf cfg.webApps.enable [
          "SUPER, A, exec, $webapp=\"https://chatgpt.com\""
        ];
        
        # Basic window management keybindings
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
        
        # General settings
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(205,214,244,1.0)";
          "col.inactive_border" = "rgba(88,91,112,1.0)";
          layout = "dwindle";
          resize_on_border = true;
        };
        
        # Decoration settings
        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            new_optimizations = true;
          };
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };
        
        # Animations
        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };
        
        # Input configuration
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
          };
          sensitivity = 0;
        };
        
        # Dwindle layout settings
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        
        # Master layout settings
        master = {
          new_is_master = true;
        };
        
        # Gestures
        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 3;
        };
        
        # Misc settings
        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };
      };
      
      # Additional config that references external sources
      extraConfig = ''
        # Source Omarchy default configurations if they exist
        source = ~/.local/share/omarchy/default/hypr/autostart.conf
        source = ~/.local/share/omarchy/default/hypr/bindings.conf
        source = ~/.local/share/omarchy/default/hypr/envs.conf
        source = ~/.local/share/omarchy/default/hypr/looknfeel.conf
        source = ~/.local/share/omarchy/default/hypr/input.conf
        source = ~/.local/share/omarchy/default/hypr/windows.conf
        source = ~/.config/omarchy/current/theme/hyprland.conf
        
        # Optional autostart applications (uncomment as needed)
      '';
    };
    
    # Hypridle configuration
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        
        listener = [
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl sleep";
          }
        ];
      };
    };
    
    # Hyprlock configuration
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
          grace = 300;
          no_fade_in = true;
          no_fade_out = true;
        };
        
        background = [
          {
            monitor = "";
            color = "rgba(26, 27, 38, 1.0)";
          }
        ];
        
        input-field = [
          {
            monitor = "";
            size = "600, 100";
            outline_thickness = 2;
            dots_size = 0.2;
            dots_spacing = 0.15;
            dots_center = true;
            dots_rounding = -1;
            outer_color = "rgba(205, 214, 244, 1.0)";
            inner_color = "rgba(26, 27, 38, 0.8)";
            font_color = "rgba(205, 214, 244, 1.0)";
            fade_on_empty = false;
            fade_timeout = 1000;
            placeholder_text = "Enter Password";
            hide_input = false;
            rounding = 0;
            check_color = "rgba(166, 209, 137, 1.0)";
            fail_color = "rgba(237, 135, 150, 1.0)";
            fail_text = "Wrong";
            fail_transition = 300;
            capslock_color = -1;
            numlock_color = -1;
            bothlock_color = -1;
            invert_numlock = false;
            swap_font_color = false;
            font_family = "CaskaydiaMono Nerd Font";
            font_size = 32;
            
            position = "0, -20";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
    
  };
}
