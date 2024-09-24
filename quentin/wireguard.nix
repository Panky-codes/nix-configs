{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      ips = [ "10.30.60.18/32" ];
      listenPort = 51820;

      privateKeyFile = config.age.secrets.sohowgkey.path;

      peers = [
        # For a client configuration, one peer entry for the server will suffice.

        {
          publicKey = "Id2ph5GOA6lPBIB3YpQkEEIlp6/8nQDKPVcyxKSlQEA=";

          allowedIPs = [
            "10.20.40.0/24"
            "10.30.60.0/24"
          ];

          endpoint = "194.62.216.251:51820";

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };

  networking.wg-quick.interfaces = {
    windscribe = {
      address = [ "100.113.179.91/32" ];
      dns = [ "10.255.255.3" ];
      privateKeyFile = config.age.secrets.windcphpriv.path;
      autostart = false;

      peers = [
        {
          publicKey = "QgQ3dPssF5IGZczLNP1KKbkohpIu/GCYBdi6ecuoqwU=";
          presharedKeyFile = config.age.secrets.windcphpreshared.path;
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          endpoint = "cph-153-wg.whiskergalaxy.com:65142";
        }
      ];
    };

    wghome = {
      address = [ "10.50.50.2/32" ];
      dns = [ "192.168.8.1" ];
      privateKeyFile = config.age.secrets.wghomepriv.path;
      autostart = false;

      peers = [
        {
          publicKey = "gv1M0PUZGdAXjP22mIT0jDDHDjVVq3S8kRE26esjIzw=";
          presharedKeyFile = config.age.secrets.wghomepreshared.path;
          allowedIPs = [
            "192.168.8.1/24"
          ];
          endpoint = "wghome.pankajraghav.com:50819";
        }
      ];
    };
  };
}
