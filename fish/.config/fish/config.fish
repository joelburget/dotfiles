set -x GOPATH $HOME/go
set -x HOLDIR $HOME/code/HOL

set -x PATH $PATH \
  $HOME/.cabal/bin \
  $HOME/.local/bin
  # $HOME/.cargo/bin \
  # $HOME/.installed-ghc/ghc-8.2.1-hq/bin \
  # $HOME/.installed-ghc/bin \
  # $HOME/code/kframework/k/k-distribution/target/release/k/bin \
  # $HOLDIR/bin \
  # $GOPATH/bin

set -x PAGER less
set -x MANPAGER "nvim -c 'set ft=man' -"
set -x EDITOR nvim
set -x TERM xterm-256color

alias gg "git grep"
alias ggi "git grep -i"
alias df "git diff --no-index"
alias e emacs
alias clone "hub clone"
alias vim nvim
alias v nvim
alias conf "nvim ~/.config/fish/config.fish"
alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias ghci-core 'ghci -ddump-simpl -dsuppress-idinfo \
  -dsuppress-coercions -dsuppress-type-applications \
  -dsuppress-uniques -dsuppress-module-prefixes'

function stack-ghcid --wraps ghcid --description 'ghcid + stack'
  ghcid --command='stack ghci --test $(basename $(pwd))'
end

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
