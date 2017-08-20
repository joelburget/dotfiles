# warning: this doesn't work well with multi-line prompts:
# https://github.com/pborenstein/iterm2-fish-integration
#
# source ~/.iterm2_shell_integration.fish

# must set this before sourcing OMF
set -g Z_SCRIPT_PATH (brew --prefix)/etc/profile.d/z.sh

set -x OMF_PATH "/Users/joel/.local/share/omf"
set -x GOPATH /Users/joel/go
source $OMF_PATH/init.fish

set -x PATH \
  $HOME/.cargo/bin \
  $HOME/.installed-ghc/ghc-8.2.1-hq/bin \
  $HOME/.installed-ghc/bin \
  $HOME/code/kframework/k/k-distribution/target/release/k/bin \
  $HOME/.local/bin \
  $HOME/.cabal/bin \
  $GOPATH/bin \
  (yarn global bin) \
  /Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin \
  /usr/local/sbin \
  /usr/local/opt/llvm/bin \
  /usr/local/bin \
  /usr/bin \
  /bin \
  /usr/sbin \
  /sbin
set -x PAGER less
set -x MANPAGER "nvim -c 'set ft=man' -"
set -x EDITOR /usr/local/bin/nvim

# omf theme agnoster

alias gg "git grep"
alias ggi "git grep -i"
alias diff "git diff --no-index"
alias e "emacsclient -n"
alias clone "hub clone"
alias vim nvim
alias v nvim

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

# OPAM configuration
# . /Users/joel/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true
