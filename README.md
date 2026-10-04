# dotfiles

Personal macOS Apple Silicon configuration files for zsh, Starship, nvm, and Ghostty.

## Install

On a fresh M1/M2/M3 Mac:

```sh
git clone https://github.com/ppconde/dotfiles.git
cd dotfiles
./install.sh
```

The installer:

- installs Homebrew if needed, then installs nvm, Starship, and Ghostty;
- installs Oh My Zsh if it is not already present; and
- symlinks the tracked configs into their expected locations.

Existing regular config files are moved to a timestamped `.backup.*` file before they are replaced. Restart the terminal after installation, or run `exec zsh`.

The installer intentionally targets macOS on Apple Silicon, where Homebrew uses `/opt/homebrew`.
