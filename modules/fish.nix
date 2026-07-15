{ ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo I use nixos, btw";
      ls = "eza --icons --group-directories-first";
      ll = "eza -lh --icons --git";
      lt = "eza --tree --icons";
      gs = "git status";
      ga = "git add .";
      gcm = "git commit -m";
      cls = "clear";
      nrs = "sudo nixos-rebuild switch";
      calc = "numbat";
      fix-brave = "rm -rf ~/.config/BraveSoftware/Brave-Browser/Singleton* && brave &";
    };
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fish_vi_key_bindings

      function fish_mode_prompt
        switch $fish_bind_mode
          case default
            # Normal Mode: Solid Medium Gray
            set_color --bold --background 767676 1c1c1c
            echo ' N '
            set_color normal
          case insert
            # Insert Mode: Bright White/Light Gray (Highly visible)
            set_color --bold --background e4e4e4 1c1c1c
            echo ' I '
            set_color normal
          case visual
            # Visual Mode: Muted Darker Gray
            set_color --bold --background 4e4e4e ffffff
            echo ' V '
            set_color normal
          case replace_one
            # Replace Mode: Very Dark Charcoal
            set_color --bold --background 303030 ffffff
            echo ' R '
            set_color normal
        end
        echo -n " "
      end
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    configFile = ../config/oh-my-posh/theme.json;
  };
}
