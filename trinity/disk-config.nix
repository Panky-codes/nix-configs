# Example to create a bios compatible gpt partition
{ lib, ... }:
{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "60%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            db = {
              end = "-8G";
              content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/mnt/db";
              };
            };
            plainSwap = {
              size = "100%";
              content = {
                type = "swap";
              };
            };
          };
        };
      };
    };
  };
}
