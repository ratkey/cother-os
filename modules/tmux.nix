{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";

    prefix = "M-s";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
      resurrect
      continuum
    ];

    extraConfig = ''
      # --- Global Options ---
      set-option -g default-shell ${pkgs.fish}/bin/fish
      set-option -g status-position top
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -g renumber-windows on

      # --- Keybindings ---
      # Split panes using | and - (preserving path)
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # Split vertically with prefix + l, horizontally with prefix + j
      bind l split-window -h -c "#{pane_current_path}"
      bind j split-window -v -c "#{pane_current_path}"

      # Alt-hjkl to switch panes (No prefix)
      # bind -n M-h select-pane -L
      # bind -n M-j select-pane -D
      # bind -n M-k select-pane -U
      # bind -n M-l select-pane -R

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # Copy mode like vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Continuum / Resurrect settings
      set -g @resurrect-strategy-vim 'session'
      set -g @resurrect-strategy-nvim 'session'
      set -g @continuum-boot 'on'

      # --- Grayscale Visual Theme ---
      # Palette: Black (#121212), Dark Gray (#303030), Light Gray (#b2b2b2), White (#ffffff)

      # Status bar general
      set -g status-style "bg=#121212,fg=#b2b2b2"
      set -g status-justify left
      set -g status-left-length 30

      # Clear the right status bar completely (no date, clock, or host)
      set -g status-right ""

      # Inactive window tabs (subtle dark gray)
      set -g window-status-format " #I:#W "
      set -g window-status-style "fg=#767676,bg=#121212"

      # Active window tab (solid white background, black text)
      set -g window-status-current-format " #I:#W "
      set -g window-status-current-style "fg=#121212,bg=#ffffff,bold"

      # Pane borders (minimalist line separation)
      set -g pane-border-style "fg=#303030"
      set -g pane-active-border-style "fg=#ffffff"

      # Left Status Bar (Session Name - bold white on dark gray)
      set -g status-left "#[fg=#ffffff,bg=#303030,bold] 󰓩 #S #[bg=default,fg=default] "
    '';
  };
}
