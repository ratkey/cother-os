{ config, pkgs, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # Visuals
        font = "JetBrainsMono Nerd Font 10";
        width = 300;
        height = 100;
        origin = "top-right";
        offset = "5x5";
        frame_width = 1;
        corner_radius = 2;

        # Grayscale Accents
        frame_color = "#8A8A8A"; # Mid-grey structural border
        separator_color = "frame";

        # Enable icons/images on the left side
        icon_position = "left";

        # Optional: Limit size so huge screenshots don't cover the screen
        max_icon_size = 128;
      };

      urgency_low = {
        background = "#1E1E1E"; # Deep dark charcoal
        foreground = "#8A8A8A"; # Muted grey text
        timeout = 3;
      };

      urgency_normal = {
        background = "#2A2A2A"; # Dark gray background matching prompt
        foreground = "#EEEEEE"; # Crisp off-white text
        timeout = 5;            # Disappears after 5 seconds
      };

      urgency_critical = {
        background = "#EEEEEE"; # High-contrast inverted white background
        foreground = "#111111"; # Deep black text
        frame_color = "#FFFFFF"; # Pure white border highlight
        timeout = 0;            # Stays until you click it
      };
    };
  };
}
