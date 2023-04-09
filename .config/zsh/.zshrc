# A lot borrowed from Luke Smith's voidrice
# https://github.com/LukeSmithxyz/voidrice/

stty stop undef

PS1="[%n@%m %~]$%b "

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000

unsetopt beep

# Aliases
alias dotcfg="git --git-dir=$DOTFILES --work-tree=$HOME"
alias nvidia-settings="nvidia-settings --config='$XDG_CONFIG_HOME'/nvidia/settings"
alias lf=lfub
alias hx=helix
alias steamtinkerlaunch="flatpak run --command=steamtinkerlaunch com.valvesoftware.Steam"
alias protontricks="flatpak run com.github.Matoking.protontricks"
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'

# Completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Vim mode
bindkey -v
export KEYTIMEOUT=1

# Bindings
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey -v '^?' backward-delete-char
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}

zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

LFCD="$HOME/.config/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
  source "$LFCD"
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh 2>/dev/null
