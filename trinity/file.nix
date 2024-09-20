{
  systemd.tmpfiles.settings = {
    "tank" = {
      "/mnt/tank/firefly/upload" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/nextcloud/data" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/paperless/data" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/paperless/media" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/paperless/export" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/paperless/consume" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
# Notices some issues with permissions
      "/mnt/tank/syncthing" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
    };

    "db" = {
      "/mnt/db/firefly/db" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/db/nextcloud/db" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/db/paperless/pgdata" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/db/paperless/redisdata" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/db/scrutiny/config" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/db/scrutiny/influxdb" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
    };
  };
}
