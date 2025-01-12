# xdg directories
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"

set -gx TERM xterm-256color

# default programs
set -gx EDITOR lvim
set -gx BROWSER librewolf
#set -gx XDG_CURRENT_DESKTOP river

# fix fullscreen applications minimising when switching
set -gx SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS 0

# home cleanup
set -gx CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"
set -gx STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/config.toml"
# language tools
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx JAVA_TOOL_OPTIONS "-Djavafx.cachedir=$XDG_CACHE_HOME/openjfx"
set -gx _JAVA_OPTIONS "-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java"
set -gx GRADLE_USER_HOME "$XDG_DATA_HOME/gradle"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -gx PYTHON_HISTORY "$XDG_STATE_HOME/python/history"
set -gx PYTHONPYCACHEPREFIX "$XDG_CACHE_HOME/python"
set -gx PYTHONUSERBASE "$XDG_DATA_HOME/python"
set -gx JUPYTER_PLATFORM_DIRS 1
set -gx PYENV_ROOT "$XDG_DATA_HOME/pyenv"
set -gx TEXMFHOME "$XDG_DATA_HOME/texmf"
set -gx TEXMFVAR "$XDG_CACHE_HOME/texlive/texmf-var"
set -gx TEXMFCONFIG $XDG_CONFIG_HOME/texlive/texmf-config

set -gx DOTFILES "$XDG_DATA_HOME/dotfiles"

# path
fish_add_path -p $HOME/.local/bin $CARGO_HOME/bin $PYENV_ROOT/bin
