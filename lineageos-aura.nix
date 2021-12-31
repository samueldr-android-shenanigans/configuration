{ pkgs, ... }:

let
  inherit (pkgs)
    fetchFromGitHub
  ;
in
{
  imports = [
    ./base
  ];

  # These are required options, but commented out here since I set it programmatically for my devices elsewhere
  device = "aura";
  flavor = "lineageos";
  androidVersion = 11; # Pin to lineageos-18.1 for now

  source.dirs = {
    # Fixes some issues with LineageOS build.
    "kernel/razer/sdm845" = {
      src = fetchFromGitHub {
        owner = "Alcatraz323";
        repo = "android_kernel_razer_sdm845";
        rev = "46b268c7db4cff3184ec40440a19559fe08947a3"; # branch: 12
        sha256 = "sha256-yApALQkAGZWMhP6Gs3GXNalV9uVgMYbw3vua26mET/4=";
      };
    };
    "device/razer/aura" = {
      patches = [
        # Fixes from Pixel Experience
        #  - RazerParts (resolution / refresh rate control)
        ./patches/android_device_razer_aura/0001-fixes-from-pe.patch
      ];
    };
  };
}
