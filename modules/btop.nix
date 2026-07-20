{ config, pkgs, ... }:
{
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "greyscale";
      theme_background = false;
      vim_keys = true;
    };
  };
}
