#!/bin/zsh

export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"

unsetopt PROMPT_SP

# Theme
export QT_STYLE_OVERRIDE=Adwaita-dark

# Default programs
export EDITOR="lvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export XDG_CURRENT_DESKTOP="awesome"

# Fix games minimising when switching out.
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0 

# Home cleanup
# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
# Go
export GOPATH="$XDG_DATA_HOME/go"
# Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# Java
export JAVA_TOOL_OPTIONS="-Djavafx.cachedir=$XDG_CACHE_HOME/openjfx" # moves .openjfx
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
# JavaScript
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# Python
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
export JUPYTER_PLATFORM_DIRS="1"
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
# TeX Live
export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config"

export DOTFILES="$XDG_DATA_HOME/dotfiles"

export JAVA_HOME="/usr/lib/jvm/java-17-openjdk/"

# Start x11
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
