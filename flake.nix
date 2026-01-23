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
    rustGtkShell = pkgs-unstable.mkShell {
        name = "rust-gtk-adwaita-dev";

        packages = with pkgs-unstable; [
          # Rust toolchain
          cargo
          rustc
          rustfmt
          clippy
          rust-analyzer
          cargo-watch     # optional: cargo watch -x run

          # Core GTK/libadwaita dependencies
          gtk4
          libadwaita
          glib
          gio
          gobject-introspection
          gdk-pixbuf
          pango
          cairo
          graphene
          harfbuzz

          # GStreamer (if using gst crate ~0.21)
          gst_all_1.gstreamer
          gst_all_1.gst-plugins-base
          gst_all_1.gst-plugins-good
          gst_all_1.gst-plugins-bad

          # Wayland/X11 support (important for GTK4 apps)
          wayland
          wayland-protocols
          libxkbcommon
          libdecor

          # Tools frequently needed during development
          pkg-config
          gettext
          desktop-file-utils
          appstream-glib
          binutils        # for objdump, etc. if needed
        ];

        # ──────────────────────────────────────────────────────────────
        # Environment variables — critical for gtk-rs / gio / glib-sys
        # ──────────────────────────────────────────────────────────────
        shellHook = ''
          echo
          echo "Rust + GTK4 + libadwaita + GStreamer development environment"
          echo "──────────────────────────────────────────────────────────────"
          echo "Versions:"
          echo "  GTK4:        $(pkg-config --modversion gtk4 2>/dev/null || echo 'not found')"
          echo "  libadwaita:  $(pkg-config --modversion libadwaita-1 2>/dev/null || echo 'not found')"
          echo "  GStreamer:   $(pkg-config --modversion gstreamer-1.0 2>/dev/null || echo 'not found')"
          echo
          echo "Useful commands:"
          echo "  cargo build"
          echo "  cargo run"
          echo "  cargo watch -x run"
          echo "  cargo fmt"
          echo "  cargo clippy"
          echo

          # Make pkg-config find all required .pc files
          export PKG_CONFIG_PATH="${with pkgs-unstable; lib.makeSearchPathOutput "lib/pkgconfig" [
            gtk4 libadwaita glib gobject-introspection gdk-pixbuf pango cairo graphene harfbuzz
            gst_all_1.gstreamer wayland libxkbcommon
          ]}''${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"

          # Runtime library lookup (helps when running the binary directly)
          export LD_LIBRARY_PATH="${with pkgs-unstable; lib.makeLibraryPath [
            gtk4 libadwaita glib gdk-pixbuf pango cairo graphene harfbuzz
            gst_all_1.gstreamer wayland libxkbcommon libdecor
          ]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

          # GSettings / icons / schemas lookup
          export XDG_DATA_DIRS="${with pkgs-unstable; lib.makeSearchPath "share" [
            gtk4 libadwaita glib gdk-pixbuf
          ]}''${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
        '';
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
    devShells.${system} = {
      # Your existing GTK4 C/C++ shell
      gtk4-dev = pkgs-unstable.mkShell {
        name = "gtk4-dev";

        packages = with pkgs-unstable; [
          gtk4
          libadwaita
          glib
          pango
          gdk-pixbuf
          graphene
          cairo
          harfbuzz
          atk

          pkg-config
          glib.bin
          gettext
          itstool
          desktop-file-utils
          appstream-glib

          valgrind
          gdb
          clang-tools
        ];

        shellHook = ''
          echo "GTK4 / libadwaita C/C++ development environment loaded"
          echo "Compile example: gcc main.c -o app \$(pkg-config --cflags --libs gtk4 libadwaita-1)"

          export PKG_CONFIG_PATH="${pkgs-unstable.gtk4.dev}/lib/pkgconfig:${pkgs-unstable.libadwaita}/lib/pkgconfig''${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
          export LD_LIBRARY_PATH="${pkgs-unstable.gtk4}/lib:${pkgs-unstable.libadwaita}/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
          export XDG_DATA_DIRS="${pkgs-unstable.gtk4}/share:${pkgs-unstable.libadwaita}/share''${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
        '';
      };

      # New: Rust + GTK4 + libadwaita shell (recommended for your project)
      rust-gtk = rustGtkShell;

      # Optional: make rust-gtk the default shell when you run just `nix develop`
      # default = rustGtkShell;
    };
  };
}
