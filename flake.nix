{
  description = "NixOS + Hyprland dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-old = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-old";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    Jovian-NixOS = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-old,
    nixpkgs-unstable,
    home-manager,
    home-manager-old,
    home-manager-unstable,
    Jovian-NixOS,
    ...
  } @inputs: let
        inherit (self) outputs;
        system = "x86_64-linux";
  in {
    nixosConfigurations = {
      laptop = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          ./nixos
          ./nixos/device/laptop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.miocasa = import ./home-manager/device/laptop;
          }
        ];
      };
      steamdeck = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          ./nixos
          ./nixos/device/steamdeck
          Jovian-NixOS.nixosModules.default
          home-manager-unstable.nixosModules.home-manager
          {
            # home-manager-unstable.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.deck = import ./home-manager/device/steamdeck;
          }
        ];
      };
      # "steamdeck2" = nixpkgs-unstable.lib.nixosSystem {
      #   inherit system;
      #   specialArgs = defaultSpecialArgs;
      #   modules = [
      #     home-manager-unstable.nixosModules.default
      #     ./steamdeck
      #     Jovian-NixOS.nixosModules.default
      #   ] ++ defaultModules;
      # };
    };
  };
}
