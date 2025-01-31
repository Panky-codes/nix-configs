# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./file.nix
  ];

  boot.loader.systemd-boot.enable = true; # (for UEFI systems only)

  networking.hostName = "trinity"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  virtualisation.docker = {
    enable = true;
  };

  users.users.panky = {
    isNormalUser = true;
    home = "/home/panky";
    extraGroups = [
      "wheel"
      "docker"
    ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKwykgce0ra9fqDt2fsi5f/5TDOjTL7LS2wiBXU6Y4Yl dev@pankajraghav.com"
    ];
    hashedPassword = "";
    packages = [ pkgs.btop ];
    #systemd user units will start at boot rather than starting at login and stopping at logout
    linger = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    zsh
    docker
    docker-compose
    btrfs-progs
    autorestic
    restic
    tmux
  ];

  # List services that you want to enable:
  systemd.timers."autorestic" = {
  wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Unit = "autorestic.service";
    };
};

systemd.services."autorestic" = {
path = [pkgs.openssh pkgs.curl];
  script = ''
${pkgs.docker-compose}/bin/docker-compose -f /home/panky/homeserver-automation/firefly/docker-compose.yaml stop
${pkgs.docker-compose}/bin/docker-compose -f /home/panky/homeserver-automation/nextcloud/docker-compose.yaml stop
${pkgs.docker-compose}/bin/docker-compose -f /home/panky/homeserver-automation/paperless-ngx/docker-compose.yaml stop
${pkgs.docker-compose}/bin/docker-compose -f /home/panky/homeserver-automation/scrutiny/docker-compose.yaml stop
${pkgs.docker-compose}/bin/docker-compose -f /home/panky/homeserver-automation/syncthing/docker-compose.yaml stop

# Sometimes tc log is creating issues.
# anyway it is not useful https://stackoverflow.com/questions/50158273/mysql-tc-log-file
${pkgs.coreutils}/bin/rm -f /mnt/db/firefly/db/tc.log

if ${pkgs.autorestic}/bin/autorestic -c /home/panky/.autorestic.yml --restic-bin "${pkgs.restic}/bin/restic" backup -a; then
	curl https://uptimekuma.home.pankajraghav.com/api/push/Yc6tma86cA?status=up&msg=OK&ping=
else
	echo "Error doing restic backup. Going to bring back up the services!"
fi

${pkgs.docker-compose}/bin/docker-compose -f /home/panky/homeserver-automation/firefly/docker-compose.yaml start
${pkgs.docker-compose}/bin/docker-compose -f /home/panky/homeserver-automation/nextcloud/docker-compose.yaml start
${pkgs.docker-compose}/bin/docker-compose -f /home/panky/homeserver-automation/paperless-ngx/docker-compose.yaml start
${pkgs.docker-compose}/bin/docker-compose -f /home/panky/homeserver-automation/scrutiny/docker-compose.yaml start
${pkgs.docker-compose}/bin/docker-compose -f /home/panky/homeserver-automation/syncthing/docker-compose.yaml start
  '';
  serviceConfig = {
    Type = "oneshot";
    User = "root";
  };
};

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.extraConfig = ''
  Host opnsftp
  User ftp
  HostName 192.168.8.1
  IdentityFile /home/panky/.ssh/opnsense-ftp
  '';

  # autoscrub once a month
  services.btrfs.autoScrub.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    7190 # paperless
    7192 # firefly
    7193 # firefly importer
    8384 # Web UI syncthing
    8080 # Nextcloud
    8090 # Scrutiny
    8096 # Scrutiny influx
    22000 # TCP file transfers syncthing
  ];
  networking.firewall.allowedUDPPorts = [
    22000 # QUIC file transfers syncthing
    21027 # Receive local discovery broadcasts syncthing
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;
  security.sudo.wheelNeedsPassword = false;

  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
