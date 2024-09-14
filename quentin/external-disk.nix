{
  environment.etc.crypttab.text = ''
    vault UUID=1342cc60-7514-4d70-8d1b-303b009cea34 /root/mykeyfile.key noauto
  '';

  # The above crypttab creates a systemd cryptsetup vault service, which the below udev rule depends on
  services.udev.extraRules = ''
    SUBSYSTEM=="block" ENV{ID_WWN}=="nvme.144d-533432304e50305234303030383659-53616d73756e6720506f727461626c6520535344205835-00000001", ENV{SYSTEMD_WANTS}="systemd-cryptsetup@vault.service"
  '';

  fileSystems."/mnt/vault" = {
    device = "/dev/disk/by-uuid/e04b44ad-1beb-4902-9b91-e5e6ed43e51c";
    fsType = "btrfs";
    options = [ "defaults" "noatime" "x-systemd.automount" "x-systemd.device-timeout=5" "noauto" ];
  };
}
