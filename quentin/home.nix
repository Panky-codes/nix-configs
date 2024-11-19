{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    mosh
    btop
    wget
    stow
    git-publish
    gcc
    clang-tools
    nodePackages.bash-language-server
    ltex-ls
    ripgrep
    codespell
    modprobed-db
    duf
    tldr
    enpass
    discord
    obsidian
    restic
    autorestic
    thunderbird
    xclip
    element-desktop
    brave
    todoist-electron
    public-inbox
    notmuch
    neomutt
    zoom-us
  ];
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    grabKeyboardAndMouse = true;
    defaultCacheTtl = 7200;
    maxCacheTtl = 28800;
    extraConfig = ''
      pinentry-program ${pkgs.pinentry.curses}/bin/pinentry-curses
    '';
  };

  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    agents = [
      "gpg"
      "ssh"
    ];
    keys = [
      "github"
      "blixen"
      "trinity-nix"
      "trinity"
      "opnsense-ftp"
      "kdev_bigtwin"
      "hetz-arm"
      "id_ed25519"
      "hetz-amd-initrd"
      "hetz-amd-panky"
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "cp"
      ];
      theme = "robbyrussell";
    };
    initExtra = ''
      RPROMPT="%F{blue}%B%~%b%f:[%F{yellow}%?%f]:[%F{green}%M%f]:%F{red}%B%*%b%f"
      alias b1="cd .."
      alias b2="cd ../.."
      alias b3="cd ../../.."
      alias cat="bat"
      alias ls="lsd"
      alias df="duf"
      alias shnow="shutdown -h now"
      export MCFLY_FUZZY=2
      alias nt="neomutt -F ~/.config/neomutt/neomuttrc.lei"
    '';
    history.ignoreAllDups = true;
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };
    "org/gnome/system/location" = {
      enabled = true;
    };
  };
  programs.fzf = {
    enable = true;
    #    enableZshIntegration = true;
  };

  programs.bat.enable = true;
  programs.lsd.enable = true;

  programs.mcfly = {
    enable = true;
    enableZshIntegration = true;
    #keyScheme = "vim";
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Default";
    };
  };
  # with mosh I need something like tmux with term
  # color set to screen-256color
  programs.tmux = {
    enable = true;
    historyLimit = 10000;
    terminal = "screen-256color";
    prefix = "C-q";
    keyMode = "vi";
    #mouse = true;
    tmuxp.enable = true;
    extraConfig = ''
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
      bind r source-file ~/.config/tmux/tmux.conf
    '';
  };

  programs.git = {
    enable = true;
    userEmail = "p.raghav@samsung.com";
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
      sendemail."mailbox" = {
        envelopeSender = "Pankaj Raghav (Samsung) <kernel@pankajraghav.com>";
      };

    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true; # see note on other shells below
    #    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "confirm";
    forwardAgent = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "/home/panky/.ssh/github";
      };
      "blixen" = {
        hostname = "10.20.40.150";
        user = "panky";
        identityFile = "/home/panky/.ssh/blixen";
      };
      "trinity" = {
        hostname = "trinity.home.pankajraghav.com";
        user = "panky";
        identityFile = "/home/panky/.ssh/trinity-nix";
      };
      "sftp" = {
        hostname = "192.168.8.1";
        user = "ftp";
        identityFile = "/home/panky/.ssh/opnsense-ftp";
      };
      "bigtwin" = {
        hostname = "149.97.161.244";
        user = "panky";
        identityFile = "/home/panky/.ssh/kdev_bigtwin";
        port = 9004;
      };
      "hetz-arm" = {
        hostname = "65.21.243.112";
        user = "panky";
        identityFile = "/home/panky/.ssh/hetz-arm";
      };
      "hetz-amd-initrd" = {
        hostname = "135.181.231.96";
        user = "root";
        identityFile = "/home/panky/.ssh/hetz-amd-initrd";
      };
      "hetz-amd-panky" = {
        hostname = "135.181.231.96";
        user = "panky";
        identityFile = "/home/panky/.ssh/hetz-amd-panky";
	port = 718;
      };
      "nix-vm" = {
        hostname = "192.168.122.94";
        user = "root";
        identityFile = "/home/panky/.ssh/id_ed25519";
      };
      "bt04" = {
        hostname = "bgt140507bm04.dtc.local";
        user = "panky";
        identityFile = "/home/panky/.ssh/kdev_bigtwin";
        proxyJump = "bigtwin";
      };
      "resticindia" = {
        hostname = "resticindia.home.pankajraghav.com";
        user = "panky";
        identityFile = "/home/panky/.ssh/restserver";
      };
      "*" = {
	identitiesOnly = true;
      };
    };
  };

  home.file = {
    ".config/gdb/gdbinit".text = ''
      set auto-load safe-path /
    '';
  };

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.password-store.enable = true;

  accounts.email = {
    accounts.mailbox = {
      address = "kernel@pankajraghav.com";
      msmtp = {
        enable = true;
        extraConfig = {
          auth = "plain";
        };
      };
      realName = "Pankaj Raghav (Samsung)";
      primary = true;
      smtp = {
        host = "smtp.mailbox.org";
        tls.useStartTls = true;
        tls.enable = true;
        port = 587;
      };
      userName = "me@pankajraghav.com";
      passwordCommand = "pass mailbox/mail";
    };
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "24.05";
}
