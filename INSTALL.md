# NixOS Installation Guide

### 1. Fresh Install(from liveiso) Preparation
```bash
# From installation ISO after partitioning/mounting:
sudo -i
nix-shell -p nixFlakes git
nixos-generate-config --root /mnt  # Generate hardware config
```

### 2. Repository Setup
```bash
mv /mnt/etc/nixos /mnt/etc/nixos.original
git clone https://github.com/Miocasa/nixos-flake /mnt/etc/nixos # you can use another dir

# Critical: Replace generated hardware config with yours
cp /mnt/etc/nixos.original/hardware-configuration.nix /mnt/etc/nixos/nixos/ 
```

### 3. Configuration
Ensure these matches:
```nix
# flake.nix
nixosConfigurations.laptop = ...  # ← This name

# configuration.nix
networking.hostName = "nixos";  # ← Must match

# home.nix
home.username = "miocasa";  # ← Must match user creation
```

### 4. Build & Activate
```bash
nixos-install --flake /mnt/etc/nixos#steamdeck --no-root-passwd
```

---

## Setup on exist system 

1. Clone repo 
```bash
#stable branch
git clone https://github.com/Miocasa/nixos-flake.git ~/nixos-flake
#newest branch (sometimes can contain errors)
git clone https://github.com/Miocasa/nixos-flake.git ~/nixos-flake --branch=jovian-experiments 
```

### 2. Generate hardware-configuration.nix
```bash
# For steamdeck
nixos-generate-config --dir ~/nix-flake/nixos/device/steamdeck
# For laptop
nixos-generate-config --dir ~/nix-flake/nixos/device/laptop
```
If you have error in generation try sudo or next command
```bash
sudo nixos-generate-config
# For steamdeck 
cp /etc/nixos/hardware-configuration.nix ~/nix-flake/nixos/device/steamdeck
# For laptop
cp /etc/nixos/hardware-configuration.nix ~/nix-flake/nixos/device/laptop
```

3. Rebuild system
```bash
# For steam deck 
sudo nixos-rebuild build --flake ~/nixos-flake#steamdeck
# For laptop with amd and hvidia hybrid graphic 
sudo nixos-rebuild build --flake ~/nixos-flake#laptop
```

## Post-Install Essentials
```bash
# Set user password
passwd user # laptop default user is miocasa
# For steam deck
passwd deck 
```
## Warning
Setup on preinstalled system may be problematic due to dependency errors.

Highly recomended to fresh install.

## Key Verification Points
1. Home Manager integration is properly nested under `home-manager.users.miocasa`
2. All GNOME extensions in `home.packages` exist in nixpkgs-unstable
