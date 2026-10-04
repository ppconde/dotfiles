# dotfiles

Personal macOS Apple Silicon configuration files for zsh, Starship, nvm, and Ghostty.

## Install

On a fresh M1/M2/M3 Mac, authenticate GitHub CLI, then download and run the installer:

```sh
brew install gh
gh auth login
curl -fsSL -H "Authorization: Bearer $(gh auth token)" https://raw.githubusercontent.com/ppconde/dotfiles/main/install.sh | bash
```

The installer installs GitHub CLI if needed, obtains its token through `gh auth`, and downloads the current configs into `~/.dotfiles`, then:

- installs Homebrew if needed, then installs nvm, Starship, and Ghostty;
- installs Oh My Zsh if it is not already present; and
- symlinks the tracked configs into their expected locations.

Existing regular config files are moved to a timestamped `.backup.*` file before they are replaced. Restart the terminal after installation, or run `exec zsh`.

The installer intentionally targets macOS on Apple Silicon, where Homebrew uses `/opt/homebrew`. To run it from a local checkout instead, use `./install.sh`.
