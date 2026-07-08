# nixos-config

My personal NixOS + Home Manager configuration using flakes.

One shared config drives two profiles:

- **`system`** — the full NixOS desktop: shared base **+** GUI apps **+** the
  Hyprland/Wayland stack. Applied with `nixos-rebuild` on my NixOS machine.
- **`home-manager`** — a lean, standalone Home Manager config (shell + dev
  tooling only, no GUI apps) for machines that are **not** NixOS: macOS and
  non-NixOS Linux. Applied with `home-manager switch`.

Both import `home/base.nix`, so shared settings live in one place.

## Structure

```
nixos-config/
├── flake.nix
├── home/
│   ├── base.nix            # shared by every machine (cli, git, zsh, ssh, common symlinks)
│   ├── system.nix          # full NixOS profile  = base + apps + desktop + hypr symlinks
│   ├── home-manager.nix    # lean standalone profile = base only
│   └── modules/
│       ├── cli.nix             # cross-platform CLI/dev packages
│       ├── apps.nix            # GUI apps (NixOS only)
│       ├── desktop.nix         # Hyprland/Wayland stack (NixOS only)
│       ├── git.nix / zsh.nix / ssh.nix
│       ├── symlinks-common.nix   # app configs linked everywhere (ghostty, helix, starship, kitty, zed)
│       └── symlinks-desktop.nix  # Hyprland desktop configs (NixOS only: hypr, waybar, rofi)
├── hosts/
│   └── xander/
│       ├── configuration.nix
│       └── hardware-configuration.nix
└── dotfiles/               # out-of-store symlinked into ~/.config
```

## Flake outputs

| Output | System | Profile | Apply with |
|---|---|---|---|
| `nixosConfigurations.xander` | `x86_64-linux` | `system` (full) | `sudo nixos-rebuild switch --flake '.#xander'` |
| `homeConfigurations."xander@mac"` | `aarch64-darwin` | `home-manager` (lean) | `home-manager switch --flake '.#xander@mac'` |
| `homeConfigurations."xander@linux"` | `x86_64-linux` | `home-manager` (lean) | `home-manager switch --flake '.#xander@linux'` |

---

## New NixOS system setup

### 1. Install NixOS

Boot from the NixOS graphical/minimal ISO and run the installer. Once you're in a shell:

### 2. Clone this repo

```bash
git clone https://github.com/xjojo132/nixos-config ~/nixos-config
cd ~/nixos-config
```

### 3. Generate hardware config

The `hardware-configuration.nix` in this repo is specific to my machine. Replace it with one generated for your hardware:

```bash
nixos-generate-config --show-hardware-config > hosts/xander/hardware-configuration.nix
```

or copy an existing one:

```bash
cp /etc/nixos/hardware-configuration.nix ~/nixos-config/hosts/xander/hardware-configuration.nix
```

> Review the output and make sure the disk UUIDs and kernel modules look correct before continuing.

### 4. Apply the config

```bash
sudo nixos-rebuild switch --flake '.#xander'
```

### 5. Set your password

```bash
passwd xander
```

### 6. Set up GitHub SSH key

```bash
ssh-keygen -t ed25519 -C "xj.remmelink@gmail.com"
cat ~/.ssh/id_ed25519.pub
```

Add the output at https://github.com/settings/keys, then test:

```bash
ssh -T git@github.com
```

If you cloned over HTTPS, switch the remote to SSH:

```bash
git remote set-url origin git@github.com:xjojo132/nixos-config.git
```

---

## Home Manager on a non-NixOS machine (macOS / other Linux)

Uses the lean `home-manager` profile — shell + dev tooling only, no GUI apps
(so it won't duplicate apps installed via Homebrew, the App Store, or a native
package manager).

```bash
# Install nix (macOS or Linux)
sh <(curl -L https://nixos.org/nix/install) --daemon

# Enable flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Clone the repo (keep it at ~/nixos-config — the dotfile symlinks point here)
git clone https://github.com/xjojo132/nixos-config ~/nixos-config
cd ~/nixos-config

# Apply — pick the target for this machine:
nix run home-manager -- switch --flake '.#xander@mac'     # macOS (Apple Silicon)
nix run home-manager -- switch --flake '.#xander@linux'   # non-NixOS Linux (x86_64)
```

After the first activation the `home-manager` command is available directly, so
later runs are just `home-manager switch --flake '.#xander@mac'`.

> Tip: if existing dotfiles block the first switch ("would be clobbered"), add
> `-b backup` to rename them to `*.backup` instead of failing.

> Note: system-level options in `configuration.nix` (NVIDIA drivers, bootloader,
> desktop environment, etc.) are NixOS-only and do not apply here.

---

## Updating

The `nix-update` alias does a full flake update + rebuild + commit in one step
(NixOS):

```bash
nix-update
```

1. `cd ~/nixos-config`
2. `nix flake update` — bump all inputs (nixpkgs, home-manager)
3. `sudo nixos-rebuild switch --flake '.#xander'`
4. Commit the updated `flake.lock` and push

---

## Adding config

### Packages

- Cross-platform CLI/dev tool → `home/modules/cli.nix` (installed everywhere).
- GUI app / Hyprland tool → `home/modules/apps.nix` or `home/modules/desktop.nix`
  (NixOS `system` profile only).

### Dotfiles (symlinked from `dotfiles/`)

- Cross-platform app config (linked on every machine) → add a line to
  `home/modules/symlinks-common.nix`.
- Linux desktop / Hyprland config (NixOS only) → add it to
  `home/modules/symlinks-desktop.nix`.

```nix
xdgLinks = {
  # link a whole ~/.config/<name> folder:
  "kitty" = "kitty";                  # "<name in ~/.config>" = "<path in dotfiles/>"
  # or link just one file, leaving the rest of the folder as local files:
  "zed/settings.json" = "zed/settings.json";
};
```
