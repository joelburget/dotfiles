# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="candy"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github vi-mode)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=:/home/joel/bin:/bin:/usr/bin:/sbin:/usr/sbin:/opt/java/bin:/opt/java/jre/bin:/usr/lib/perl5/site_perl/bin:/usr/bin/perlbin/vendor:/usr/lib/perl5/core_perl/bin:/home/joel/.gem/ruby/1.9.1/bin:/home/joel/.cabal/bin:/home/joel/.gem/ruby/1.9.1/bin
export PYTHONPATH=/opt/google_appengine:/opt/google_appengine/lib
export SERVER_SOFTWARE=Development

export VISUAL='vim'
export EDITOR="$VISUAL"
export GREP_OPTIONS='--color=auto --exclude=*.pyc --exclude-dir=.git'

setopt AUTO_CD
setopt AUTO_PUSHD

alias -s pdf=evince
alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc'

function server() {
    local port="${1:-8000}"
    mimeopen "http://localhost:${port}/" && python -m SimpleHTTPServer "$port"
}
