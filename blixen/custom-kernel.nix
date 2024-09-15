{ pkgs, ... }:

let
  customPackage =
    {
      version,
      src,
      configfile,
      modDirVersion ? pkgs.lib.versions.pad 3 version,
      kernelPatches ? [ ],
      allowImportFromDerivation ? true,
    }:
    pkgs.lib.recurseIntoAttrs (
      pkgs.linuxPackagesFor (
        pkgs.linuxManualConfig {
          inherit
            version
            src
            configfile
            modDirVersion
            kernelPatches
            allowImportFromDerivation
            ;
        }
      )
    );

  kernel = import ./kernel.nix { inherit pkgs; };
in
customPackage {
  version = kernel.version;
  modDirVersion = kernel.modDirVersion;
  configfile = kernel.configfile;
  src = kernel.src;
  kernelPatches = kernel.kernelPatches;
}
