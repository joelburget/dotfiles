set -x GOPATH $HOME/go
set -x PATH $PATH $HOME/.local/bin $HOME/.cabal/bin
set -x PAGER less
set -x EDITOR nvim
set -x TERM xterm-256color

alias df "git diff --no-index"
alias vim nvim
alias v nvim
alias conf "nvim ~/.config/fish/config.fish"

# silence "gpg-agent: a gpg-agent is already running - not starting a new one"
gpg-agent --daemon 2>/dev/null

function fish_user_key_bindings
    # alt-left / alt-right
    # * with an empty line, navigates through directory history
    # * with a non-empty line, navigates through the line
    bind \033f nextd-or-forward-word
    bind \033b prevd-or-backward-word
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

if command -v opam > /dev/null
    eval (opam env)
end

zoxide init fish | source

set -gx MCFLY_LIGHT TRUE
set -gx MCFLY_FUZZY true
set -gx MCFLY_RESULTS 50
mcfly init fish | source
