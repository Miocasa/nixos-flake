# NixOS flake (example)

Files included:
- flake.nix
- modules/hardware.nix
- modules/desktop.nix
- modules/users.nix
- modules/packages.nix
- modules/home-manager.nix

How to use:
1. Put the files in a git repo (or a local folder).
2. Run `sudo nixos-rebuild switch --flake .#my-host`.

Notes:
- Adjust `username`, `hosts` and any extra options.
- Clone AstroNvim manually into `~/.config/nvim` for the user.
- NVIDIA drivers require allowUnfree.
