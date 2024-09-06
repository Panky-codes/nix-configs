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
      "/mnt/tank/firefly/db" = {
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
      "/mnt/tank/paperless" = {
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
      "/mnt/tank/scrutiny" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
      "/mnt/tank/immich" = {
        d = {
          group = "users";
          mode = "0755";
          user = "panky";
        };
      };
    };
};
}

