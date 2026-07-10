{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  quickshellConfigDir = ../config/quickshell;

  allConfigs = lib.attrsets.mapAttrs' (
    name: value: lib.attrsets.nameValuePair name (quickshellConfigDir + "/${name}")
  ) (builtins.readDir quickshellConfigDir);
in
{
  programs.quickshell = {
    enable = true;
    package = unstable-pkgs.quickshell;
    activeConfig = null;
    configs = allConfigs;
  };
}
