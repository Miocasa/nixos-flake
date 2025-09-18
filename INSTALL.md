# NixOS Installation Guide

## 1. Fresh Install Preparation
```bash
# From installation ISO after partitioning/mounting:
sudo -i
nix-shell -p nixFlakes git
nixos-generate-config --root /mnt  # Generate hardware config
```

## 2. Repository Setup
```bash
mv /mnt/etc/nixos /mnt/etc/nixos.original
git clone https://github.com/Miocasa/nixos-flake /mnt/etc/nixos

# Critical: Replace generated hardware config with yours
cp /mnt/etc/nixos.original/hardware-configuration.nix /mnt/etc/nixos/nixos/
```

## 3. Configuration Validation
Ensure these matches:
```nix
# flake.nix
nixosConfigurations.nixos = ...  # ← This name

# configuration.nix
networking.hostName = "nixos";  # ← Must match

# home.nix
home.username = "Miocasa";  # ← Must match user creation
```

## 4. Build & Activate
```bash
nixos-install --flake /mnt/etc/nixos#nixos --no-root-passwd
```

## Post-Install Essentials
```bash
# Set password for user
passwd miocasa
```

## Key Verification Points
1. Home Manager integration is properly nested under `home-manager.users.miocasa`
2. All GNOME extensions in `home.packages` exist in nixpkgs-unstable
