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
}
