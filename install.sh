#!/usr/bin/env bash
set -eu

if [ "$(uname -s)" != "Darwin" ] || [ "$(uname -m)" != "arm64" ]; then
  echo "This installer supports macOS on Apple Silicon only." >&2
  exit 1
fi

repo_ref=${DOTFILES_REF:-main}
download() {
  if [ -n "${GITHUB_TOKEN:-}" ]; then
    curl -fsSL -H "Authorization: Bearer $GITHUB_TOKEN" "$1"
  else
    curl -fsSL "$1"
  fi
}

if [ -f "$0" ]; then
  repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
else
  download_dir=$(mktemp -d)
  trap 'rm -rf "$download_dir"' EXIT
  echo "Downloading dotfiles..."
  download "https://github.com/ppconde/dotfiles/archive/refs/heads/$repo_ref.tar.gz" \
    | tar -xzf - -C "$download_dir"
  downloaded_dir="$download_dir/dotfiles-$repo_ref"
  repo_dir="$HOME/.dotfiles"
  mkdir -p "$repo_dir"
  cp "$downloaded_dir/.zshrc" "$downloaded_dir/starship.toml" "$downloaded_dir/config.ghostty" "$repo_dir/"
fi

if [ ! -f "$repo_dir/.zshrc" ] || [ ! -f "$repo_dir/starship.toml" ] || [ ! -f "$repo_dir/config.ghostty" ]; then
  echo "Dotfiles could not be downloaded." >&2
  exit 1
fi

if [ -x /opt/homebrew/bin/brew ]; then
  BREW=/opt/homebrew/bin/brew
elif command -v brew >/dev/null 2>&1; then
  BREW=$(command -v brew)
else
  echo "Homebrew is not installed; installing it now."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  BREW=/opt/homebrew/bin/brew
fi

if [ ! -x "$BREW" ]; then
  echo "Homebrew was not found after installation." >&2
  exit 1
fi

"$BREW" install nvm starship
"$BREW" install --cask ghostty
mkdir -p "$HOME/.nvm"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is not installed; installing it now."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

backup_suffix=$(date +%Y%m%d%H%M%S)

link_config() {
  source=$1
  target=$2
  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ]; then
    rm "$target"
  elif [ -e "$target" ]; then
    backup="$target.backup.$backup_suffix"
    mv "$target" "$backup"
    echo "Backed up $target to $backup"
  fi

  ln -s "$source" "$target"
  echo "Linked $target"
}

link_config "$repo_dir/.zshrc" "$HOME/.zshrc"
link_config "$repo_dir/starship.toml" "$HOME/.config/starship.toml"
link_config "$repo_dir/config.ghostty" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"

echo "Done. Restart your terminal or run: exec zsh"
