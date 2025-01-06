{lib, ...}: let
  inherit (lib) mkOptionType isString;
in {
  types = {
    wingetPackage = let
      inherit (lib.strings) contains;
    in
      mkOptionType {
        name = "wingetPackage";
        description = "A package definition in Winget";
        descriptionClass = "noun";
        check = pkg: isString pkg && contains ".";
      };
  };
}
