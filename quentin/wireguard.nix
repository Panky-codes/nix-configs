{
  config,
  lib,
  pkgs,
  ...
}:
{
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

    windscribe_sing = {
      address = [ "100.113.179.91/32" ];
      dns = [ "10.255.255.3" ];
      privateKeyFile = config.age.secrets.windsingpriv.path;
      autostart = false;

      peers = [
        {
          publicKey = "ePfazP+V1DkyyzK2VpSKS1JFiChU2TpO6jyYOmjnRAw=";
          presharedKeyFile = config.age.secrets.windsingpreshared.path;
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          endpoint = "sin-170-wg.whiskergalaxy.com:65142";
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
          allowedIPs = [ "192.168.8.1/24" ];
          endpoint = "wghome.pankajraghav.com:50819";
        }
      ];
    };
  };
}
