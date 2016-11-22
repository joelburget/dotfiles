# must set this before sourcing OMF
set -g Z_SCRIPT_PATH (brew --prefix)/etc/profile.d/z.sh

set -x OMF_PATH "/Users/joel/.local/share/omf"
set -x GOPATH /Users/joel/go
source $OMF_PATH/init.fish

set -x PATH "$HOME/.local/bin" $HOME/.yarn/bin $GOPATH/bin $PATH
set -x PAGER most
set -x EDITOR /usr/local/bin/vim

# omf theme agnoster

alias gg "git grep"
alias ggi "git grep -i"
alias diff "git diff --no-index"
alias e "emacsclient -n"

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
