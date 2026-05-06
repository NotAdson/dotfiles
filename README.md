# Lubuntu Rice Setup

This repository contains my personal dotfiles and an automated Ansible playbook to set up a complete rice on a minimal Lubuntu 24 installation.

## What's included?
- **Window Manager:** i3-wm with modern gaps and a clean aesthetic.
- **Terminal:** Alacritty (built from source for performance).
- **Editor:** Neovim (AppImage v0.12.2) with a full LSP and plugin suite.
- **Shell:** Bash with custom aliases and `pywal` integration.
- **Status Bar:** Polybar with system monitors and media controls.
- **Fetch:** Fastfetch (via PPA).
- **File Manager:** Ranger.
- **Colors:** Automatic palette generation via `pywal` (Haishoku algorithm).
- **System Protection:** Timeshift with auto-snapshots before updates and GRUB integration.
- **Extras:** Firefox (no-snap), Flameshot (Flatpak), btop, and Gemini CLI.

## Installation Instructions

Follow these steps on a fresh, minimal Lubuntu 24 installation to reproduce the environment.

### 1. Install Ansible & Requirements
First, update your system and install Ansible and the required collections.

```bash
sudo apt update
sudo apt install -y ansible git
ansible-galaxy collection install community.general
```

### 2. Clone the Repository
Clone this repository to your local machine:

```bash
git clone https://github.com/NotAdson/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 3. Run the Setup Playbook
The `rice-setup.yml` playbook will handle everything: installing packages, building Alacritty, configuring GRUB, and symlinking the dotfiles.

```bash
ansible-playbook -K rice-setup.yml
```

> **Note:** The `-K` flag will prompt you for your `sudo` password, which is necessary for installing system packages and configuring GRUB.

### 4. Finalize the Setup
- **Logout and Login:** After the playbook finishes, log out and select **i3** as your session from the login screen.
- **Neovim Plugins:** Open Neovim (`nvim`). The playbook has pre-installed `packer.nvim`. Run `:PackerSync` inside Neovim to install all plugins.
- **Firefox:** Launch Firefox to verify the PPA version is installed.

## GRUB Customization
The playbook automatically:
- Sets the GRUB timeout to **2 seconds**.
- Removes the default Lubuntu theme for a minimal look.
- Installs `grub-btrfs` for Timeshift snapshot integration.

## Key Bindings
- `Mod4 + Return`: Open Alacritty
- `Mod4 + d`: Open Rofi (App Launcher)
- `Mod4 + Shift + q`: Kill Focused Window
- `Print`: Open Flameshot (Screenshot)
- `Mod4 + r`: Enter Resize Mode
- `Mod4 + Shift + e`: Exit i3
