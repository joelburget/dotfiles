# bashrc
# Copyright  : (c) Joel Burget 2010
#
# I stole most of this stuff from here:
# http://blog.infinitered.com/entries/show/4

# Check for an interactive session
[ -z "$PS1" ] && return

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

# Misc -------------------------------------------------------------
export HISTCONTROL=ignoredups

# bash completion settings (actually, these are readline settings)
# note: bind used instead of sticking these in .inputrc
bind "set completion-ignore-case on"
bind "set bell-style none"
bind "set show-all-if-ambiguous On"

# Turn on advanced bash completion if the file exists
#(get it here: http://www.caliban.org/bash/index.shtml#completion)
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export VISUAL='vim'
export EDITOR="$VISUAL"

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\[\033[00m\]\u@\h\[\033[01;34m\] \W \[\033[31m\]\$(parse_git_branch) \[\033[00m\]$\[\033[00m\] "
