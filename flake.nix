{
  description = "flakes";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    agenix.url = "github:ryantm/agenix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      agenix,
      nixos-hardware,
      ...
    }:
    {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {

        blixen = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./blixen/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.panky = import ./blixen/home.nix;
            }
          ];
        };

        trinity = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./trinity/configuration.nix
            ./trinity/file.nix
          ];
        };

        quentin = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            agenix.nixosModules.default
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
            ./quentin/configuration.nix
            ./quentin/age.nix
            ./quentin/wireguard.nix
            ./quentin/external-disk.nix
            { environment.systemPackages = [ agenix.packages.x86_64-linux.default ]; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.panky = import ./quentin/home.nix;
            }

          ];
        };

        trinityiso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              { pkgs, modulesPath, ... }:
              {
                imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
                environment.systemPackages = [
                  pkgs.vim
                  pkgs.git
                ];
                users.users.nixos = {
                  openssh.authorizedKeys.keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKwykgce0ra9fqDt2fsi5f/5TDOjTL7LS2wiBXU6Y4Yl dev@pankajraghav.com"
                  ];
                };
              }
            )
          ];
        };

      };
    };
}
