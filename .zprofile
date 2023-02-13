#!/bin/zsh

export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"

unsetopt PROMPT_SP

# Theme
export QT_STYLE_OVERRIDE=Adwaita-dark

# Default programs
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"

# Home cleanup
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export JAVA_TOOL_OPTIONS="-Djavafx.cachedir=$XDG_CACHE_HOME/openjfx" # moves .openjfx
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'

export DOTFILES="$XDG_DATA_HOME/dotfiles"

# Start x11
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
