{
  lib,
  config,
  ...
}: let
  # Custom Nix-winget lib
  wingetLib = import ./lib.nix;

  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) listOf;

  inherit (wingetLib.types) wingetPackage;
in {
  options.winget = {
    enable = mkEnableOption "Enable winget management";

    packages = mkOption {
      type = listOf wingetPackage;
      description = "Packages to install using winget";
      default = [];
    };
  };

  config.winget = let
    cfg = config.winget;

    name = "nix-winget";
  in
    lib.mkIf cfg.enable {
      systemd.services.${name} = {
        inherit name;
        description = "Manage Winget using Nix";
      };
    };
}
