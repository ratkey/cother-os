{ config, pkgs, lib, inputs, ... }: {
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.system}.default;
    activeConfig = null;
    configs."shell.qml" = ../config/quickshell/shell.qml;
  };
}
