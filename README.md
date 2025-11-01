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
5. Build your system configuration `sudo nixos-rebuild switch --flake ~/nixos-flake#<device>` 

Further details in the [INSTALL.md](./INSTALL.md) file.


## Structure

```
.
├── flake.nix                              - Main flake configuration
├── home-manager                           - User configuration
│   └── device                             - Device specific home configuraion
│       └── $Device                        - Device name
├── nixos                                  - System configuration
│   ├── device                             - Device name
│   │   └── $Device                        - Device specific system configuraion
├── INSTALL.md                             - Installation instruction
└── README.md                              - This page
```

## Usage
### For laptop/pc
Desktop UI is being handled by GDM + GNOME Shell for simplicity.
### For steam deck
Steam os like, Gaming mode (Steam Bigscreen session) + Gnome as desktop session.

#### Favorite apps in dash

| App | Description |
| --- | --- |
| Gnome-console | Terminal emulator |
| Google Chrome | Web browser |
| Vscodium | Code editor |
| Nautilus | File manager |




#### Keybindings

| Keybinding | Action |
| --- | --- |
| `<Super>q` `<Alt>F4` | Close window |

> Key binds can be defined in dconf.nix in device home-manager folder

#### Extensions


| Extension | Description |
| --- | --- |
| Spotify control | Adds media controls to the top of the screen |
| Astra monitor | Adds a widget with system usage information to the top of the screen |
| AppIndicator | Handles tray icons |
| Blur My Shell | Adds blur to multiple places |
| Tiling Shell | Tiling manager |
| *** | More description will be added later |




#### Programs

| Program | Description |
| --- | --- |
| git | Version control system |
| zsh | Shell |


#### Pre-installed fonts

| Font | Description |
| --- | --- |
| Now not installed | *** |
| *** | *** |

## Screenshots
> Will be added later