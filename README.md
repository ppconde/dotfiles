# dotfiles

Personal macOS Apple Silicon configuration files for zsh, Starship, nvm, and Ghostty.

## Install

On a fresh M1/M2/M3 Mac, download and run the installer with a GitHub token that can read this private repository:

```sh
export GITHUB_TOKEN=your_github_token
curl -fsSL -H "Authorization: Bearer $GITHUB_TOKEN" https://raw.githubusercontent.com/ppconde/dotfiles/main/install.sh | bash
```

The installer downloads the current configs into `~/.dotfiles`, then:

- installs Homebrew if needed, then installs nvm, Starship, and Ghostty;
- installs Oh My Zsh if it is not already present; and
- symlinks the tracked configs into their expected locations.

Existing regular config files are moved to a timestamped `.backup.*` file before they are replaced. Restart the terminal after installation, or run `exec zsh`.

The installer intentionally targets macOS on Apple Silicon, where Homebrew uses `/opt/homebrew`. To run it from a local checkout instead, use `./install.sh`.
