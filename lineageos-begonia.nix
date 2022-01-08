{ pkgs, ... }:

let
  inherit (pkgs)
    fetchFromGitHub
    fetchFromGitLab
    fetchpatch
  ;

  fetchFromShenanigans = { repo, rev, sha256 }: fetchFromGitHub {
    owner = "samueldr-android-shenanigans";
    inherit rev repo sha256;
  };

  fetchFromPixelExperience = { repo, rev, sha256 }: fetchFromGitHub {
    owner = "PixelExperience";
    inherit rev repo sha256;
  };
in
{
  imports = [
    ./base
  ];

  device = "begonia";
  flavor = "lineageos";
  variant = "userdebug";
  androidVersion = 11; # Pin to lineageos-18.1 for now

  source.dirs = {
    #
    # Minimal set of added repositories
    #

    "device/xiaomi/begonia" = {
      src = fetchFromShenanigans {
        repo = "device_xiaomi_begonia";
        rev = "8b77f240ef61bc3b286dc67da7d48e0e201e4eeb"; # lineage-18.1
        sha256 = "sha256-Xe2mXYpDrdVN9XuL7EvmM75/NP3PiA3oXLRW9tefpyY=";
      };
    };

    "kernel/xiaomi/begonia" = {
      src = fetchFromShenanigans {
        repo = "linux";
        rev = "541418c3d7b6f020ded28bd9b293fc54de4c4e71"; # kernel_xiaomi_begonia/lineage-18.1
        sha256 = "sha256-hIWkwJaTi56Kz2Q7vQJzXzai6CugevZw/UxrS85SRZM=";
      };
    };

    "device/mediatek/common" = {
      src = fetchFromPixelExperience {
        repo = "device_mediatek_common";
        rev = "0bf0ba92511bef214692ae5ed335421ad224a43b"; # eleven
        sha256 = "sha256-P4qisIvHAxpVMQPV2l5WUFgYCd9ebISG0Lw/ppsOK7I=";
      };
    };
    "device/mediatek/sepolicy_vndr" = {
      src = fetchFromPixelExperience {
        repo = "device_mediatek_sepolicy_vndr";
        rev = "02ffd17bd948ca72927f9d0c81cb4a01c952fe13"; # eleven
        sha256 = "sha256-lGw+qjsemIWUD4p8glRej5SFKIGCeyTa8gZtC/6sQj8=";
      };
    };

    "vendor/xiaomi/begonia" = {
      src = fetchFromGitLab {
        domain = "gitlab.pixelexperience.org";
        owner = "android/vendor-blobs";
        repo = "vendor_xiaomi_begonia";
        rev = "2f636e7efe0a3d21cf4ab78925b609c76e693057"; # eleven
        sha256 = "sha256-8IsTuFa+eRHwmBWT3MiXnhO9MPqM2GY6X/HtWxGmI3Y=";
      };
    };
    "vendor/xiaomi-firmware" = {
      src = fetchFromGitLab {
        domain = "gitlab.pixelexperience.org";
        owner = "android/vendor-blobs";
        repo = "vendor_xiaomi-firmware";
        rev = "253604882df2e5e1cdb200b5b908694b7ccd4b80"; # eleven
        sha256 = "sha256-AJ/LKYTyGhXmf5TrAzihCAWSkwzk5XXvBcuESBBrHCs=";
      };
    };

    "vendor/mediatek/opensource" = {
      src = fetchFromPixelExperience {
        repo = "vendor_mediatek-opensource";
        rev = "1347039bd8c18de02aad78a58de658e1c74da848"; # eleven
        sha256 = "sha256-bhytHkH21BevB4aXbkRIISEeWvKbZtgLXKhRR5lsfZY=";
      };
    };
    "vendor/mediatek/ims" = {
      src = fetchFromPixelExperience {
        repo = "vendor_mediatek_ims";
        rev = "8eb5f7742cdc7c9f9e0722a256618ed686830b48"; # eleven
        sha256 = "sha256-ZyDpzqvmAsR72ZK/LWb3Gz8EiajSTeGVEyMkQ/fITuw=";
      };
    };
    "vendor/mediatek/interfaces" = {
      src = fetchFromPixelExperience {
        repo = "vendor_mediatek_interfaces";
        rev = "153b21ccfd30240838a408a1a8ac7ea6749599f8"; # eleven
        sha256 = "sha256-trrtxogd6F3Eqs/866sYrKbuk75O4yk4VDVWR6zSoqs=";
      };
    };

    # Fixes required

    "frameworks/av" = {
      patches = [
        # vendor_mediatek-opensource @ 9dd57250c30dfe7ce07f7020cd631915a4a232fb
        (fetchpatch {
          url = "https://github.com/PixelExperience/frameworks_av/commit/e68c71d2c1a77b2d7402386c79ae2580be29acf7.patch";
          sha256 = "sha256-uTbFDZeWGNIpf2sVGyqpdTwC85Z7yXmpLFxPUTVMPEU=";
        })
        # vendor_mediatek-opensource @ 9dd57250c30dfe7ce07f7020cd631915a4a232fb
        (fetchpatch {
          url = "https://github.com/PixelExperience/frameworks_av/commit/156e79e763b424a96b6166bf2de1eee1b74e1ecc.patch";
          sha256 = "sha256-1b43EZdT59v3nNZkVG95ChKYZXCPTpFe4L/Tdk9eWcc=";
        })
      ];
    };
  };
}
