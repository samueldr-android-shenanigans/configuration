let
  sha256 = "sha256:176id0zrrv63hhd67y2rcbmd69l0vpw5j2lbvp5gs4hjgxsiy2ba";
  rev = "e366833050370243de35615add846a8d72cd8c91";
in
builtins.trace "(Using pinned Robotnix at ${rev})"
import (fetchTarball {
  url = "https://github.com/danielfullmer/robotnix/archive/${rev}.tar.gz";
  inherit sha256;
})
