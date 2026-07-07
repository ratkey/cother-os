{ config, pkgs, lib, inputs, ... }: 
let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  programs.quickshell = {
    enable = true;
    package = unstable-pkgs.quickshell;
    activeConfig = null;
    configs."shell.qml" = ../config/quickshell/shell.qml;
    configs."SysMonitor.qml" = ../config/quickshell/SysMonitor.qml;
  };
}
