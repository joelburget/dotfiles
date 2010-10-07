# bashrc
# Copyright  : (c) Joel Burget 2010
#
# I stole most of this stuff from here: 
# http://blog.infinitered.com/entries/show/4

# Check for an interactive session
[ -z "$PS1" ] && return

# Colors ----------------------------------------------------------
#export TERM=xterm-color

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export PATH=$PATH:~/.gem/ruby/1.9.1/bin:~/.cabal/bin:~/.bin:~/startup/depot_tools
export shots_dir=~/shots
export NACL_ROOT=~/startup/nativeclient

# Misc -------------------------------------------------------------
export HISTCONTROL=ignoredups

# After each command, checks the windows size and changes lines and columns
shopt -s checkwinsize 

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

# Misc
# Lists folders and files sizes in the current folder
alias ducks='du -cksh * | sort -rn|head -11' 

alias ls='ls --color=auto'

# Shows most used commands, cool script I got this from: 
# http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

# Editors ----------------------------------------------------------
export EDITOR='vim'  #Command line

# COLOR_BROWN='\e[0;33m'
# COLOR_GRAY='\e[0;30m'
# COLOR_NONE='\e[0;0m'
# echo -e "Kernel Information: " `uname -smr`
# echo -e "${COLOR_BROWN}`bash --version`"
# echo -ne "${COLOR_NONE}Uptime: "; uptime
# echo -ne "Server time is: "; date
