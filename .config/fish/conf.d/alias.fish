# Equivalent to fish alias function, but more verbose and works better with variables
function nvidia-settings --wraps nvidia-settings
    command nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings" $argv
end
