{
  description = "NixOS system flake with GNOME, GDM, Steam, Flatpak, NV/AMD drivers and dev tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.my-host = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/hardware.nix
        ./modules/desktop.nix
        ./modules/users.nix
        ./modules/packages.nix
        ./modules/shell.nix
        ./configuration.nix

        # Import Home Manager as a NixOS module:
        # home-manager.nixosModules.home-manager

        # Home Manager configuration:
        # {
          # home-manager.useGlobalPkgs = true;
          # home-manager.useUserPackages = true;
          # home-manager.users.miocasa = import ./modules/home-manager.nix;
        # }
      ];
    };
  };
}
