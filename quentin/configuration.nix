# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "quentin"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.fwupd.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  hardware.opengl.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # syncthing
  services = {
    syncthing = {
      enable = true;
      user = "panky";
      dataDir = "/home/panky/Documents/syncthing"; # Default folder for new synced folders
      configDir = "/home/panky/Documents/syncthing/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
  };
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.panky = {
    isNormalUser = true;
    home = "/home/panky";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    description = "Pankaj ";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
    ];
  };

  fonts.packages = with pkgs; [ nerdfonts ];
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    btop
    git
    nfs-utils
    citrix_workspace
    python3
    gnomeExtensions.paperwm
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # 2049 for NFS
  networking.firewall.allowedTCPPorts = [
    2049
    8384
    22000
  ];
  networking.firewall.allowedUDPPorts = [
    22000
    21027
    51820
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  services.btrbk = {
    instances."vault" = {
      onCalendar = "Mon..Fri, 15:30";
      settings = {
        snapshot_preserve = "14d";
        snapshot_preserve_min = "2d";
        target_preserve = "7d 4w *m";
        stream_compress = "lz4";
        volume."/btr_pool" = {
          target = "/mnt/vault/quentin-home";
          subvolume = "home";
          snapshot_create = "always";
        };
      };
    };
  };

  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "Fri *-*-* 12:30:00";
    options = "--delete-older-than 7d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "Fri *-*-* 13:30:00" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
