{
  description = "trinity";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs:
  {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      trinity = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
        modules = [./trinity/configuration.nix];
      };
    };
  };
}
