{
  systemd.tmpfiles.settings = {
    "docker" = {
      "/home/panky/docker-data" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
    };
    "tank" = {
      "/mnt/tank/firefly/upload" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/immich" = {
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
    };

    "db" = {
      "/mnt/tank/db/firefly/db" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/db/nextcloud/db" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/db/paperless/pgdata" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/db/paperless/redisdata" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/db/scrutiny/config" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/db/scrutiny/influxdb" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/db/immich" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/db/hoarder/data" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
      "/mnt/tank/db/hoarder/meilidata" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
# Noticed some issues with permissions
      "/mnt/tank/db/syncthing" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/tank/db/uptimekuma" = {
        d = {
          group = "root";
          mode = "0755";
          user = "root";
        };
      };
    };
  };
}
