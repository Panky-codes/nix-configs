{
  description = "flakes";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@ { nixpkgs, home-manager, ... }:
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
        modules = [./trinity/configuration.nix ./trinity/file.nix ];
      };

      trinityiso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ pkgs, modulesPath, ... }: {
            imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
            environment.systemPackages = [ pkgs.vim pkgs.git];
            users.users.nixos = {
              openssh.authorizedKeys.keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKwykgce0ra9fqDt2fsi5f/5TDOjTL7LS2wiBXU6Y4Yl dev@pankajraghav.com"
              ];
            };
          })
        ];
      };

    };
  };
}
