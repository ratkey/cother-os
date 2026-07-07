{ config, pkgs, lib, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # --- Monitor Layout ---
      # External Monitor (Left display)
      monitor = [
        "HDMI-A-1, 1920x1080@60, 0x0, 1"
        "eDP-1, 2240x1400@60, 1920x0, 1"
      ];

      # --- Dynamic Workspace Allocation ---
      # Pins 1 through 8 strictly to the external monitor if it is connected.
      # Workspace 9 stays on the laptop monitor.
      workspace = [
        "1, monitor:HDMI-A-1, default:true"
        "2, monitor:HDMI-A-1"
        "3, monitor:HDMI-A-1"
        "4, monitor:HDMI-A-1"
        "5, monitor:HDMI-A-1"
        "6, monitor:HDMI-A-1"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "9, monitor:eDP-1, default:true"
      ];

      # Programs
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$browser" = "firefox";
      "$menu" = "rofi -show drun";
      "$reload_hyprland" = "hyprctl reload";
      "$mainMod" = "SUPER";

      # Autostart
      exec-once = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "$terminal"
        "qs &"
        "swww-daemon &"
        "sleep 0.5 && swww img -o HDMI-A-1 ~/walls/bw01.jpg && swww img -o eDP-1 ~/walls/bw01.jpg"
        # Focus workspace 1 on launch (forces focus to the external monitor if present)
        "hyprctl dispatch workspace 1"
      ];

      # Environment variables
      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,24"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
      ];

      # General
      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 1;
        "col.active_border" = "rgba(ffffffee) rgba(000000ee) 45deg";
        "col.inactive_border" = "rgba(000000ee)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 0;
        rounding_power = 1;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          vibrancy = 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = true;
        bezier = [
          "subtleCurve, 0.25, 1, 0.5, 1"
          "panelEase, 0.05, 0.9, 0.1, 1.0"
        ];
        animation = [
          "windows, 1, 4, subtleCurve"
          "windowsOut, 1, 3, subtleCurve, popin 93%" 
          "border, 1, 5, default"
          "borderangle, 1, 5, default"
          "fade, 1, 4, default"
          "workspaces, 1, 4, subtleCurve, slide" 
          "layers, 1, 4, panelEase, slide top"
        ];
      };

      # Layouts
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      # Misc
      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
      };

      # Input
      input = {
        kb_layout = "us";
        kb_variant = "intl";
        follow_mouse = 1;
        sensitivity = 0;
        repeat_rate = 35;
        repeat_delay = 200;

        touchpad = {
          natural_scroll = true;
        };
      };

      cursor = {
        inactive_timeout = 30;
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = "-0.5";
      };

      # Keybindings
      bind = [
        # Screenshots
        ", Print, exec, grim -g \"$(slurp)\" /tmp/screenshot.png && wl-copy < /tmp/screenshot.png && notify-send -i /tmp/screenshot.png \"Screenshot\" \"Region copied to clipboard\""
        "CTRL, Print, exec, grim /tmp/screenshot.png && wl-copy < /tmp/screenshot.png && notify-send -i /tmp/screenshot.png \"Screenshot\" \"Fullscreen copied to clipboard\""
        "SUPER, Print, exec, FILE=~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S.png'); grim $FILE && notify-send -i $FILE \"Screenshot\" \"Saved to $FILE\""

        # Applications
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, Q, exec, rofi-power"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, W, exec, $browser"
        "$mainMod SHIFT, W, exec, date +%s%N > /tmp/qs-wallpaper-toggle"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod SHIFT, R, exec, $reload_hyprland"

        # Corrected Focus movement (Vim style: h=left, l=right)
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Corrected Window movement (Vim style: h=left, l=right)
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        # Workspaces Navigation
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move windows to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Lock screen
        "$mainMod ALT, L, exec, hyprlock"
      ];

      # Repeat bindings
      bindle = [
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      # Locked bindings
      bindl = [
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioMicMute, exec, pamixer --default-source -t"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Window rules
      windowrulev2 = [
        "maximize, class:^(Godot)$, title:^(Godot)"
        "float, class:^(Godot)$, title:^(?!Godot)"
        "suppressevent maximize, class:.*"
      ];

      # Layer rules
      layerrule = [
        "blur, quickshell"
        "blur, rofi"
        "ignorezero, rofi"
        "animation fade, rofi"
        "animation fade, quickshell"
      ];
    };
  };
}
