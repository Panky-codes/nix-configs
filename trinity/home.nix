{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "dev@pankajraghav.com";
    userName = "Pankaj Raghav";
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      s = "status";
    };
    delta = {
      enable = true;
      options = {
        side-by-side = "true";
      };
    };
    extraConfig = {
      rerere = {
        enable = "true";
      };
      advice = {
        statusAheadBehind = "false";
      };
      maintenance = {
        repo = "/home/panky/SW/linux/lbs";
      };
      pretty = {
        fixes = "Fixes: %h (\"%s\")";
        changelog = "commit %h (\"%s\")";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  programs.keychain = {
    enable = true;
    agents = [
      "gpg"
      "ssh"
    ];
    keys = [
      "opnsense-ftp"
    ];
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "confirm";
    forwardAgent = true;
    matchBlocks = {
      "opnsftp" = {
        hostname = "192.168.8.1";
        user = "ftp";
        identityFile = "/home/panky/.ssh/opnsense-ftp";
      };
    };
  };

  home.file = {
    ".autorestic.yml".text = ''
      set auto-load safe-path /
    '';
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "24.05";
}
