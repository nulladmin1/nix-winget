{
  lib,
  config,
  ...
}: let
  # Custom Nix-winget lib
  wingetLib = import ./lib.nix;

  inherit (lib) mkEnableOption mkOption types;

  inherit (wingetLib.types) wingetPackage;
in {
  options.winget = {
    enable = mkEnableOption "Enable winget management";

    packages = mkOption {
      type = types.listOf wingetPackage;
      description = "Packages to install using winget";
      default = [];
    };

    update-with-nixos =
      mkEnableOption "Automatically update packages during a nixos-rebuild"
      // {
        default = true;
      };

    # TODO - implement this
    unmanaged-packages-behavior = mkOption {
      type = types.enum ["ignore" "uninstall"];
      default = "ignore";
      example = "uninstall";
      description = ''
        How to handle Winget packages not installed using Nix.
        Setting this option to "ignore" ignores those packages
        Setting this option to "uninstall" uninstalls those packages
      '';
    };

    # TODO - implement this w/ Winget configuration files
    configuration = mkEnableOption "Use a Winget configuration file to build the system.";
  };

  config.winget = let
    cfg = config.winget;
  in
    lib.mkIf cfg.enable {
      system.activationScripts.nix-winget = "";
    };
}
