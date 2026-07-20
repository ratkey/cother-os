{ config, pkgs, ... }:

let
  logo = pkgs.writeText "fastfetch-logo" ''
    ⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷
    ⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇
    ⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽
    ⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕
    ⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕
    ⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕
    ⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄
    ⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕
    ⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿
    ⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟
    ⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠
    ⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙
    ⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣
  '';
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "${logo}";
        type = "file";
        color = {
          "1" = "white";
        };
        padding = {
          right = 1;
        };
      };
      display = {
        color = "white";
        separator = "  ";
      };
      modules = [
        {
          type = "title";
          color = {
            user = "white";
            at = "white";
            host = "white";
          };
        }
        "separator"
        {
          type = "os";
          key = " OS";
          keyColor = "white";
        }
        {
          type = "host";
          key = "󰌢 Host";
          keyColor = "white";
        }
        {
          type = "kernel";
          key = "󰌽 Kernel";
          keyColor = "white";
        }
        {
          type = "uptime";
          key = "󰅐 Uptime";
          keyColor = "white";
        }
        {
          type = "packages";
          key = "󰏗 Packages";
          keyColor = "white";
        }
        {
          type = "shell";
          key = "󰞷 Shell";
          keyColor = "white";
        }
        {
          type = "display";
          key = "󰍹 Display";
          keyColor = "white";
        }
        {
          type = "de";
          key = "󰧨 DE";
          keyColor = "white";
        }
        {
          type = "wm";
          key = "󱂬 WM";
          keyColor = "white";
        }
        {
          type = "wmtheme";
          key = "󰉦 Theme";
          keyColor = "white";
        }
        {
          type = "terminal";
          key = "󰆍 Terminal";
          keyColor = "white";
        }
        {
          type = "cpu";
          key = "󰻠 CPU";
          keyColor = "white";
        }
        {
          type = "gpu";
          key = "󰍹 GPU";
          keyColor = "white";
        }
        {
          type = "memory";
          key = "󰑭 Memory";
          keyColor = "white";
        }
        {
          type = "disk";
          key = "󰋊 Disk";
          keyColor = "white";
        }
        "break"
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };
}
