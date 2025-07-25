# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "mpt3sas"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
#  boot.crashDump.enable = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/494d5198-efcf-4dd6-ac66-a0ba42e35cdd";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/A1BD-F833";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/mnt/db" =
    { device = "/dev/disk/by-uuid/7ee583b5-7a03-4bd5-9e3a-b48013b5ad6c";
      fsType = "btrfs";
      options = [ "compress=zstd" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/7ec8a374-e5ef-4886-8341-e04b47770299"; }
    ];

  fileSystems = {
    "/mnt/tank" = {
      device = "/dev/disk/by-uuid/3cfa32f4-f6c4-480c-ad0e-478cc555b391";
      fsType = "btrfs";
      options = [ "compress=zstd" ];
    };

    "/mnt/tank/firefly" = {
      device = "/dev/disk/by-uuid/3cfa32f4-f6c4-480c-ad0e-478cc555b391";
      fsType = "btrfs";
      options = [
        "subvol=firefly"
        "compress=zstd"
        "noatime"
      ];
    };

    "/mnt/tank/nextcloud" = {
      device = "/dev/disk/by-uuid/3cfa32f4-f6c4-480c-ad0e-478cc555b391";
      fsType = "btrfs";
      options = [
        "subvol=nextcloud"
        "compress=zstd"
        "noatime"
      ];
    };

    "/mnt/tank/paperless" = {
      device = "/dev/disk/by-uuid/3cfa32f4-f6c4-480c-ad0e-478cc555b391";
      fsType = "btrfs";
      options = [
        "subvol=paperless"
        "compress=zstd"
        "noatime"
      ];
    };

    "/mnt/tank/syncthing" = {
      device = "/dev/disk/by-uuid/3cfa32f4-f6c4-480c-ad0e-478cc555b391";
      fsType = "btrfs";
      options = [
        "subvol=syncthing"
        "compress=zstd"
        "noatime"
      ];
    };

    "/mnt/tank/immich" = {
      device = "/dev/disk/by-uuid/3cfa32f4-f6c4-480c-ad0e-478cc555b391";
      fsType = "btrfs";
      options = [
        "subvol=immich"
        "compress=zstd"
        "noatime"
      ];
    };
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp10s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp10s0f1.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp9s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp9s0f1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
