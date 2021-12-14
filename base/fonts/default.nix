{ pkgs, ... }:

{
  source.dirs = {
    "frameworks/base" = {
      # Make Roboto Condensed the default sans serif font
      patches = [
        ./0001-fonts-Make-Roboto-Condensed-the-default-sans-serif-f.patch
      ];
    };
    "external/noto-fonts" = {
      # Let's bake blobmojis in-place of boring Noto emojis!
      postPatch =
        let
          blobmoji = pkgs.fetchurl {
            url = "https://github.com/C1710/blobmoji/releases/download/v14.0.1/Blobmoji.ttf";
            sha256 = "sha256-w9s7uF6E6nomdDmeKB4ATcGB/5A4sTwDvwHT3YGXz8g=";
          };
        in
      ''
        rm -rf emoji-compat # Prevent from accidental use
        cp -vf ${blobmoji} emoji/NotoColorEmoji.ttf
      '';
    };
  };
}
