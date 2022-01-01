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

  device = "begonia";
  flavor = "lineageos";
  androidVersion = 11; # Pin to lineageos-18.1 for now

  source.dirs = {
    "device/xiaomi/begonia" = {
      src = fetchFromGitHub {
        owner = "PotatoDevices";
        repo = "device_redmi_begonia-old";
        rev = "7e65d779797a6f45c693403541833269784e057e"; # dumaloo-release
        sha256 = "sha256-p7qnYecm5bhSMztnHhNnX00IHdII2I1tigvMRnHpcTM=";
      };
      patches = [
        ./patches/android_device_xiaomi_begonia/0001-WIP-LineageOS-DT2W.patch
        ./patches/android_device_xiaomi_begonia/0002-WIP-redmi-xiaomi.patch
        ./patches/android_device_xiaomi_begonia/0003-WIP-De-potato-ify.patch
      ];
    };
    "device/mediatek/sepolicy" = {
      #src = builtins.fetchGit ./posp/device_mediatek_sepolicy;
      src = fetchFromGitHub {
        owner = "PotatoProject";
        repo = "device_mediatek_sepolicy";
        rev = "2a8e9816e84cebba6087f1f7acc4ed9fe03513d7"; # dumaloo-release
        sha256 = "sha256-IQTX0bx/z4PJKaPjGTdxKaTEYQfAmy0WZ5xoldHerpw=";
      };
    };
    "kernel/xiaomi/mt6785" = {
      src = fetchFromGitHub {
        owner = "AgentFabulous";
        repo = "begonia";
        rev = "d7a53936ff223fbb7f54946175c96ac78f3526f2"; # android-11.0
        sha256 = "sha256-UnAMe2WD+uI3zz7Gt0JVWK0aCWG+ggfXGQyyyTRYB+Q=";
      };
    };
    "vendor/redmi/begonia" = {
      src = fetchFromGitHub {
        owner = "PotatoDevices";
        repo = "vendor_redmi_begonia";
        rev = "b27040f137eecaca22c5f709823008bf0e4b68b5"; # dumaloo-release
        sha256 = "sha256-HAs+GqATztvC7SvzmjwdLiWDtFFJ4cgGriyh4AzgVx0=";
      };
    };
  };
}
