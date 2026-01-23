{
  description = "NixOS + Hyprland dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    # spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-old = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-old";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    Jovian-NixOS = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    mac-style-plymouth = {
      url = "github:SergioRibera/s4rchiso-plymouth-theme";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    prism = {
      url = "github:ElyPrismLauncher/ElyPrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-experimental-features = [ "nix-command" "flakes" ];
  };
  
  outputs = {
    self,
    nixpkgs,
    nixpkgs-old,
    nixpkgs-stable,
    home-manager,
    home-manager-old,
    home-manager-unstable,
    Jovian-NixOS,
    nixos-conf-editor,
    mac-style-plymouth,
    prism,
    ...
  } @inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    pkgs-unstable = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs-stable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
    
  in {
    nixosConfigurations = {
      nixpkgs.flake = {
      setFlakeRegistry = false;
      setNixPath = false;
    };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          pkgs-stable = import inputs.nixpkgs-stable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        # > Our main nixos configuration file <
        modules = [
          ./nixos
          ./nixos/device/laptop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.miocasa = import ./home-manager/device/laptop;
          }
        ];
      };
      steamdeck = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          pkgs-stable = import inputs.nixpkgs-stable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
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
      steamos = nixpkgs.lib.nixosSystem {
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
    # default = nixpkgs.lib.nixosSystem {
    #   specialArgs = {inherit inputs outputs;};
    #   # > Our main nixos configuration file <
    #   modules = [
    #     ./nixos
    #     ./nixos/device/laptop
    #     home-manager.nixosModules.home-manager
    #     {
    #       home-manager.useGlobalPkgs = true;
    #       home-manager.useUserPackages = true;
    #       home-manager.users.miocasa = import ./home-manager/device/laptop;
    #     }
    #   ];
    # };
    };
  };
}
