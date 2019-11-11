#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Added for Anaconda
. /home/renato/anaconda3/etc/profile.d/conda.sh

# Stock command
stock() {
	python ~/Documents/Projects/stock_command/stock.py $1
}

web() {
	python ~/Documents/Projects/stock_command/web.py $1 $2
}

#Code commands
find_code() {
	grep -n $1 * /dev/null
}
