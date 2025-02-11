#!/bin/zsh

# .zshenv - file to configure zsh environment variables

export ZDOTDIR=${XDG_CONFIG_HOME:=~/.config}/zsh

export LIBSEAT_BACKEND=logind
export MOZ_ENABLE_WAYLAND=1

# Default programs
export EDITOR="lvim"
export TERMINAL="foot"
export BROWSER="librewolf"
export XDG_CURRENT_DESKTOP="river"

export TERM="xterm-256color"
# Fix games minimising when switching out.
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0 

# Home cleanup
# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

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

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/config.toml"

export DOTFILES="$XDG_DATA_HOME/dotfiles"

# Path
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
[[ -d "$CARGO_HOME/bin" ]] && export PATH="$CARGO_HOME/bin:$PATH"

export PATH="$HOME/.local/bin:$CARGO_HOME/bin:$PYENV_ROOT/bin:$PATH"
