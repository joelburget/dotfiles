source ~/dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git

# Guess what to install when running an unknown command.
antigen bundle command-not-found

# ZSH port of Fish shell's history search feature.
antigen bundle zsh-users/zsh-history-substring-search

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme robbyrussell

VISUAL='vim'
EDITOR='vim'

path+=/Users/joel/.local/bin

alias gg='git grep'

# we don't want history shared among different terminals
setopt no_share_history

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
