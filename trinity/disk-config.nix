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
              end = "-1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
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

      tank = {
        device = "/dev/vda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            tank = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/mnt/tank";
		mountOptions = [ "default" "compress=zstd" "noatime" "autodefrag"];
              };
            };
          };
        };
      };
    };
  };
}

