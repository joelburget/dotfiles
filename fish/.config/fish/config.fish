set -x GOPATH $HOME/go
set -x PATH $PATH $HOME/.local/bin
set -x PAGER less
set -x MANPAGER "/bin/sh -c \"col -b | vim --noplugin -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
set -x EDITOR vim
set -x TERM xterm-256color

alias gg "git grep"
alias ggi "git grep -i"
alias df "git diff --no-index"
alias e emacs
alias clone "hub clone"
alias v vim
alias conf "vim ~/.config/fish/config.fish"
alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

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
