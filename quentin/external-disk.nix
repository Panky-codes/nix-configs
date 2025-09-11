{ config, pkgs, ... }:
{
  environment.etc.crypttab.text = ''
    backup UUID=03d495af-d106-44c2-a177-eed6e9471ad8 /root/mykeyfile.key noauto
  '';

  # The above crypttab creates a systemd cryptsetup vault service, which the below udev rule depends on
  services.udev.extraRules = ''
    SUBSYSTEM=="block" ENV{ID_SERIAL}=="Samsung_SSD_990_PRO_1TB_S6Z1NU0X263352V_1", ENV{SYSTEMD_WANTS}="systemd-cryptsetup@backup.service"
  '';

  fileSystems."/mnt/backup" = {
    device = "/dev/disk/by-uuid/f82132a3-78f4-40d4-ba17-1bcc6c3d04c0";
    fsType = "btrfs";
    options = [
      "defaults"
      "noatime"
      "x-systemd.automount"
      "x-systemd.device-timeout=5"
      "noauto"
    ];
  };

  systemd.services.backupvault = {
    enable = true;
    requires = [ "mnt-backup.mount" ];
    after = [ "mnt-backup.mount" ];
    wantedBy = [ "mnt-backup.mount" ];
    serviceConfig = {
      ExecStart = "${pkgs.systemd}/bin/systemctl start btrbk-backup.service";
    };
  };

  services.btrbk = {
    instances."backup" = {
      settings = {
        snapshot_preserve = "14d";
        snapshot_preserve_min = "2d";
        target_preserve = "7d 4w *m";
        stream_compress = "lz4";
        volume."/btr_pool" = {
          target = "/mnt/backup/quentin-home";
          subvolume = "home";
          snapshot_create = "always";
        };
      };
    };
  };

}
