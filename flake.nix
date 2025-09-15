{
  description = "NixOS system flake with GNOME, GDM, Steam, Flatpak, NV/AMD drivers and dev tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  home-manager.enable = true;
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
        # ./modules/home-manager.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.your-username = import ./modules/home-manager.nix;
        }

        # Import Home Manager as a NixOS module here:
        home-manager.nixosModules.home-manager

        # ./modules/home-manager.nix
      ];
    };
  };
}
