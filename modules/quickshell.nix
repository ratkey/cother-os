{ config, pkgs, lib, ... }: {
  programs.quickshell = {
    enable = true;
    activeConfig = null;
    configs."shell.qml" = ../config/quickshell/shell.qml;
  };
}
