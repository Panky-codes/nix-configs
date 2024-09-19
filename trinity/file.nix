{
  systemd.tmpfiles.settings = {
    "tank" = {
      "/mnt/tank" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/db/firefly/db" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/tank/firefly/upload" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/tank/nextcloud" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/db/nextcloud/db" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/tank/nextcloud/data" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/tank/paperless" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/db/paperless/pgdata" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/db/paperless/redisdata" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/tank/paperless/data" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/tank/paperless/media" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/tank/paperless/export" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/tank/paperless/consume" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/tank/syncthing" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/db/scrutiny/config" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/db/scrutiny/influxdb" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
    };
  };
}
