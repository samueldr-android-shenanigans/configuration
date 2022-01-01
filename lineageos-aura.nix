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
        ./patches/android_device_razer_aura/0001-aura-RazerParts-Initial-bringup.patch
        ./patches/android_device_razer_aura/0002-aura-remove-unused-config.patch
        ./patches/android_device_razer_aura/0003-aura-RazerParts-fix-switch-not-work.patch
        ./patches/android_device_razer_aura/0004-aura-RazerParts-disable-refreshRate-control.patch
        ./patches/android_device_razer_aura/0005-aura-RazerParts-comment-modified-interface-call.patch
        ./patches/android_device_razer_aura/0006-aura-RazerParts-remove-PREFERRED_REFRESH_RATE-refere.patch
        ./patches/android_device_razer_aura/0007-aura-RazerParts-enable-refresh-rate-control.patch
        ./patches/android_device_razer_aura/0008-aura-RazerParts-change-some-description.patch
        ./patches/android_device_razer_aura/0009-aura-RazerParts-set-DeviceSettingsActivity-category-.patch
        ./patches/android_device_razer_aura/0010-aura-RazerParts-add-launcher-icon.patch
        ./patches/android_device_razer_aura/0011-aura-RazerParts-fix-wrong-android-exported-setting.patch
        ./patches/android_device_razer_aura/0012-aura-RazerParts-add-missing-attr-android-export-to-f.patch
        ./patches/android_device_razer_aura/0013-aura-Uprev-audio-to-6.0.patch
        ./patches/android_device_razer_aura/0014-aura-add-Dolby-from-SMR7.patch
        ./patches/android_device_razer_aura/0015-aura-sepolicy-add-missing-policy-for-snap-camera.patch
        ./patches/android_device_razer_aura/0016-aura-sepolicy-remove-premission-for-system_app-to-ac.patch
        ./patches/android_device_razer_aura/0017-aura-sepolicy-add-razerparts_app-domain.patch
        ./patches/android_device_razer_aura/0018-aura-sepolicy-remove-hint-service-policy.patch
        ./patches/android_device_razer_aura/0019-aura-permissions-add-missing-qti-permission.patch
        ./patches/android_device_razer_aura/0020-aura-overlay-remove-unsupported-color-mode.patch
        ./patches/android_device_razer_aura/0021-aura-overlay-enable-WCG-mode.patch
        ./patches/android_device_razer_aura/0022-aura-build-Updates.patch
        ./patches/android_device_razer_aura/0023-aura-Remove-stray-sepolicy.patch
        ./patches/android_device_razer_aura/0024-my-aura-Remove-Snap-app.patch

      ];
    };
  };
}
