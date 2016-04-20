# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/joel/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/Users/joel/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

alias gg "git grep"
alias wifion "networksetup -setairportpower en0 on"
alias wifioff "networksetup -setairportpower en0 off"
