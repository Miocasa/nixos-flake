# DotFlakes

- **NixOS**: Declarative system configuration
- **Home Manager**: User environment management
- **GNOME**: Polished desktop environment with thoughtful customizations
- **Flakes**: Modern, reproducible Nix workflow

## Setup
1. Fork or clone this repository
2. Build your hardware configuration `nixos-generate-config`
3. Copy your hardware configuration to `nixos/device/<device>/hardware-configuration.nix`
4. Commit the changes to your repository
5. Build your system configuration `sudo nixos-rebuild switch --flake .#<device>` 

Further details in the [INSTALL.md](./INSTALL.md) file.


## Structure

```
.
├── flake.nix         - Main flake configuration
├── home-manager/     - User configuration
├── nixos/            - System configuration
└── README.md         - This file
```
```
.
├── flake.nix                              - Main flake configuration
├── home-manager                           - User configuration
│   └── device                             
│       └── $Device                        
|           ├── dconf.nix                  - Main flake configuration
│           ├── default.nix
│           ├── gtk.nix
│           └── home.nix
├── nixos
│   ├── device
│   │   └── $Device
│   │       ├── configuration.nix
│   │       ├── default.nix
│   │       ├── hardware-configuration.nix
│   │       ├── hardware.nix
│   │       └── users.nix
│   ├── default.nix
│   ├── packages.nix
│   └── shell.nix
├── INSTALL.md
└── README.md
```

## Usage

Desktop UI is being handled by GDM + GNOME Shell for simplicity.

Steam ui + Gnome as desktop.



#### Favorite apps in dash

| App | Description |
| --- | --- |
| Gnome-console | Terminal emulator |
| Google Chrome | Web browser |
| Nautilus | File manager |
| YouTube Music | Music player |
| Telegram | Chat client |
| Element | Matrix chat manager |



#### Keybindings

| Keybinding | Action |
| --- | --- |
| `<Super>q` `<Alt>F4` | Close window |


#### Extensions


| Extension | Description |
| --- | --- |
| Media Controls | Adds media controls to the top of the screen |
| Vitals | Adds a widget to the top of the screen |
| AppIndicator | Handles tray icons |
| Blur My Shell | Adds blur to multiple places |
| Tiling Shell | Tiling manager |




#### Programs

| Program | Description |
| --- | --- |
| git | Version control system |
| zsh | Shell |


#### Pre-installed fonts

| Font | Description |
| --- | --- |
| Caskaydia Cove | Nerd font |
| Fira Code | Nerd font |

## Screenshots
