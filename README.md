# dotfiles

Personal macOS Apple Silicon configuration files for zsh, Starship, nvm, and Ghostty.

## Install

On a fresh M1/M2/M3 Mac, download and run the installer:

```sh
curl -fsSL https://raw.githubusercontent.com/ppconde/dotfiles/main/install.sh | bash
```

The installer installs Homebrew if needed, then:

1. installs GitHub CLI and runs `gh auth login`;
2. downloads the current configs into `~/.dotfiles`;
3. installs nvm, Starship, and Ghostty;
4. installs Oh My Zsh if it is not already present; and
5. symlinks the tracked configs into their expected locations.

Existing regular config files are moved to a timestamped `.backup.*` file before they are replaced. Restart the terminal after installation, or run `exec zsh`.

The installer intentionally targets macOS on Apple Silicon, where Homebrew uses `/opt/homebrew`. To run it from a local checkout instead, use `./install.sh`.
