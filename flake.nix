{
  description = "NixOS system flake with GNOME, GDM, Steam, Flatpak, NV/AMD drivers and dev tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
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

        # Import Home Manager as a NixOS module here:
        home-manager.nixosModules.home-manager

        # ./modules/home-manager.nix
      ];
    };
  };
}
