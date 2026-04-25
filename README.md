# nixos-config

My personal NixOS configuration using flakes and Home Manager.

## Structure

```
nixos-config/
├── flake.nix
├── home/
│   ├── home.nix
│   └── modules/        # git, zsh, ssh, packages, symlinks
├── hosts/
│   └── xander/
│       ├── configuration.nix
│       └── hardware-configuration.nix
└── dotfiles/           # symlinked into ~/.config
```

## New System Setup

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

or to just copy if you have a existing `hardware-configuration.nix`

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

Generate a key and add it to your GitHub account:

```bash
ssh-keygen -t ed25519 -C "xj.remmelink@gmail.com"
cat ~/.ssh/id_ed25519.pub
```

Copy the output and add it at: https://github.com/settings/keys

Test it:

```bash
ssh -T git@github.com
```

and after if pulled via https switch the config repo to ssh 

```bash
git remote set-url origin git@github.com:xjojo132/nixos-config.git
```
---

## Home Manager (standalone, non-NixOS)

If you want to use just the Home Manager config on a non-NixOS system (e.g. Manjaro):

```bash
# Install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# Enable flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Clone the repo
git clone https://github.com/xjojo132/nixos-config ~/nixos-config
cd ~/nixos-config

# Apply home manager config
nix run home-manager -- switch --flake '.#xander'
```

> Note: system-level options in `configuration.nix` (like NVIDIA drivers, bootloader, etc.) won't apply — those are NixOS-only.

---

## Updating

The `nix-update` alias handles a full flake update + rebuild + commit in one step:

```bash
nix-update
```

This will:
1. `cd ~/nixos-config`
2. Run `nix flake update` to bump all inputs (nixpkgs, home-manager)
3. Rebuild and switch with `sudo nixos-rebuild switch --flake '.#xander'`
4. Commit the updated `flake.lock` and push to GitHub

---

## Adding new config 

For new config, add a row here in `home.nix` (note the entire dir gets symlinked):

```bash

xdgLinks = {
    "hypr" = "hypr";
    "kitty" = "kitty";
    "DIR_NAME_FROM_DOTFILES_DIR" = "DIR_NAME_THAT_WILL_BE_IN_~/.config";
  };  
```
