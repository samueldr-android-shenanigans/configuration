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

  device = "surfna";
  flavor = "lineageos";
  androidVersion = 11; # Pin to lineageos-18.1
  #variant = "eng"; # Useful to debug failure to boot...

  source.dirs = {
    "device/motorola/surfna" = {
      #src = builtins.fetchGit ./motorola-surfna/android_device_motorola_surfna;
      src = fetchFromGitHub {
        owner = "samueldr-android-shenanigans";
        repo = "device_motorola_surfna";
        rev = "ad278be432b7648b168cb17372cce7bfcee272a3";
        sha256 = "sha256-wYS2F9Dw8JKs+5hTnhzXuSGB/99b2mVy464UlsFtyVQ=";
      };
    };

    # Repos from lineage.dependencies in android_device_motorola_surfna

    "vendor/motorola/surfna" = {
      src = fetchFromGitHub {
        owner = "los-modded";
        repo = "android_vendor_motorola_surfna";
        rev = "4af8a6a24351aa1ad1c168f4b1b4319668403d1a"; # lineage-18.1
        sha256 = "sha256-Qp5uIf8g0TaL9mlpjRjPw+zGQqqEpG+ouxKT9/fBX54=";
      };
    };
    "kernel/motorola/surfna" = {
      src = fetchFromGitHub {
        owner = "electimon";
        repo = "VoidKramel";
        rev = "4717e02b805de4ddc88dfe22c4f3369024b90176"; # Void-moto-4.9-redo
        sha256 = "sha256-pZfylQscLigB2umCHlIWho8+sIMdeHMB/rgMLwaban4=";
      };
    };

    # FIXME: for the following, implicitly use those from the lineage-18.1.json lock file?

    "external/bson" = {
      src = fetchFromGitHub {
        owner = "LineageOS";
        repo = "android_external_bson";
        rev = "ec09ff2859b4f2b1d5591b2e595d3b586c391f59"; # lineage-18.1
        sha256 = "sha256-NcDbaUNd67FFOhh5nV7cjcPz6isMleVhaHxCFKucttA=";
      };
    };
    "hardware/motorola" = {
      src = fetchFromGitHub {
        owner = "LineageOS";
        repo = "android_hardware_motorola";
        rev = "648cb2b0b3ec46e74625ad44689c2db3d7c5d865"; # lineage-18.1
        sha256 = "sha256-0/elVSpifRzBzYuaSWcV4aMCLGqEvOgBaqTqtL1hLfo=";
      };
    };
    "system/qcom" = {
      src = fetchFromGitHub {
        owner = "LineageOS";
        repo = "android_system_qcom";
        rev = "4e4088e990ddab7dabfdf6c8eefb425e07f7e26b"; # lineage-18.1
        sha256 = "sha256-hWJttrsuXizefj2M71LD/cBbyU/XPULKJ4dJEWhdvCk=";
      };
    };
  };
}
