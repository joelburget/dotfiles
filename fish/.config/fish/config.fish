source ~/.iterm2_shell_integration.fish
# must set this before sourcing OMF
set -g Z_SCRIPT_PATH (brew --prefix)/etc/profile.d/z.sh

set -x OMF_PATH "/Users/joel/.local/share/omf"
set -x GOPATH /Users/joel/go
source $OMF_PATH/init.fish

set -x PATH "$HOME/.local/bin" (yarn global bin) $GOPATH/bin $PATH
set -x PAGER less
set -x EDITOR /usr/local/bin/vim

# omf theme agnoster

alias gg "git grep"
alias ggi "git grep -i"
alias diff "git diff --no-index"
alias e "emacsclient -n"
alias clone "hub clone"

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

# TODO: remove duplication between fish_user_paths and PATH
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths


setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end
