{ config, lib, ... }:

let
  inherit (lib)
    mkIf
  ;
in
{
  config = mkIf (config.flavor == "linageos") {
    source.dirs = {
    };
  };
}
