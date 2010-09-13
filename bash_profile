# bash_profile
# Copyright  : (c) Joel Burget 2010
#
# I stole this stuff from Todd Werth here:
# http://blog.infinitered.com/entries/show/4

# Path ------------------------------------------------------------
# add the directories you want included in the path
if [ -d ~/bin ]; then
	export PATH=:~/bin:$PATH 
fi
if [ -d ~/.bin ]; then
	export PATH=:~/.bin:$PATH  
fi

source $HOME/.bashrc

# Hello Messsage --------------------------------------------------
echo -e "Kernel Information: " `uname -smr`
echo -e "${COLOR_BROWN}`bash --version`"
echo -ne "${COLOR_GRAY}Uptime: "; uptime
echo -ne "${COLOR_GRAY}Server time is: "; date

# Notes: ----------------------------------------------------------
# When you start an interactive shell (log in, open terminal or iTerm in OS X,
# or create a new tab in iTerm) the following files are read and run, in this
# order:
#     profile
#     bashrc
#     .bash_profile
#     .bashrc (only because this file is run (sourced) in .bash_profile)
#
# When an interactive shell, that is not a login shell, is started (when you
# run "bash" from inside a shell, or when you start a shell in xwindows
# [xterm/gnome-terminal/etc] ) the following files are read and executed, 
# in this order:
#     bashrc
#     .bashrc
