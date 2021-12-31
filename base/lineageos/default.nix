{ config, lib, ... }:

let
  inherit (lib)
    mkIf
  ;
in
{
  config = mkIf (config.flavor == "linageos") {
    source.dirs = {
      # Basically some fluff
      "vendor/lineage" = {
        patches = [
          ../../patches/android_vendor_lineage/0001-my-Remove-unused-apps.patch
        ];
      };
    };
  };
}
