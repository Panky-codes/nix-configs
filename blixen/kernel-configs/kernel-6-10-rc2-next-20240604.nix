{ pkgs, ... }:
{
  version = "6.10.0-rc2-04_06_24-next";
  modDirVersion = "6.10.0-rc2-next-20240604";
  configfile = ./config_6_10_rc3;
  src = pkgs.fetchurl {
    url = "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/snapshot/linux-next-next-20240604.tar.gz";
    hash = "sha256-a+7BJeUj7K/fp6kj2iXP80mFF80vlVw9WbKxgAIJnoI=";
  };
  kernelPatches = [ ];
}
