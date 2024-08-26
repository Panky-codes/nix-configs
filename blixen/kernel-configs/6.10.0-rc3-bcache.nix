{ pkgs, ... }: {
  version = "6.10.0-rc3-bcache";
  modDirVersion = "6.10.0-rc3";
  configfile = ./config_6_10_rc3;
  src = pkgs.fetchurl {
    url = "https://git.kernel.org/torvalds/t/linux-6.10-rc3.tar.gz";
    hash = "sha256-z5Z89iBz9YojSC3RpXlEPjqXhXCt1AIxqlK7DL9lnkg=";
  };
  kernelPatches = [{
    name = "bcachefs";
    patch = ./bcachefs.patch;
  }];
}
