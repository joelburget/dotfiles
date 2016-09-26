set -gx OMF_PATH "/Users/joel/.local/share/omf"
set -gx GOPATH /Users/joel/go

set -x PATH "$HOME/.local/bin" $GOPATH/bin $PATH
set -x PAGER most
set -x EDITOR /usr/local/bin/vim

# Load oh-my-fish configuration.
# source $OMF_PATH/init.fish

# omf theme agnoster

alias gg "git grep"
alias wifion "networksetup -setairportpower en0 on"
alias wifioff "networksetup -setairportpower en0 off"
alias sleep "pmset sleepnow"
alias diff "git diff --no-index"
alias e "emacsclient -n"

# OPAM configuration
source /Users/joel/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# silence "gpg-agent: a gpg-agent is already running - not starting a new one"
gpg-agent --daemon 2> /dev/null

function fish_user_key_bindings
    # alt-left / alt-right
    # * with an empty line, navigates through directory history
    # * with a non-empty line, navigates through the line
    bind \033f nextd-or-forward-word
    bind \033b prevd-or-backward-word

    bind \cr peco_select_history
end

function fish_title
    if [ $_ = 'fish' ]
        echo (prompt_pwd)
    else
        echo $_
    end
end
