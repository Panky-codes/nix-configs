{ pkgs, ... }: {
  version = "6.10.0-rc5-27_06_24-next";
  modDirVersion = "6.10.0-rc5-next-20240626";
  configfile = ./config_6_10_rc3;
  src = pkgs.fetchurl {
    url = "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/snapshot/linux-next-next-20240626.tar.gz";
    hash = "sha256-Ew/izlerbsFNMc+ge5qH1sL8KnZ0m/zdEIKnFJNHyKM=";
  };
  kernelPatches = [ ];
}
