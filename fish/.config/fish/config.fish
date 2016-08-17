# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/joel/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/Users/joel/.config/omf"

set -gx GOPATH /Users/joel/go

set -x PATH $GOPATH/bin $PATH
set -x PAGER most

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

alias gg "git grep"
alias wifion "networksetup -setairportpower en0 on"
alias wifioff "networksetup -setairportpower en0 off"
alias sleep "pmset sleepnow"
alias diff "git diff --no-index"

# OPAM configuration
source /Users/joel/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# silence "gpg-agent: a gpg-agent is already running - not starting a new one"
gpg-agent --daemon 2> /dev/null
