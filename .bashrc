#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Export Variables

export BROWSER="qutebrowser"
export TERMINAL="urxvt"
export TERM=xterm-256color  # for python
export EDITOR="nvim"
export GOPATH=~/.go
export PATH=$GOPATH/bin:$HOME/.cargo/bin:$PATH

# Stock command
stock() {
	python ~/Documents/Projects/stock_command/stock.py $1 &
}

web() {
	python ~/Documents/Projects/stock_command/web.py $1 $2 &
}

#Code commands
find_code() {
	grep -n $1 * /dev/null
}

#Duplicate current terminal
dp() { urxvt -cd `pwd` & } 

#Greed game
alias greed="~/Programs/greed/greed"

#Turn screen
v_mode() {
    xrandr --output LVDS1 --rotate left
}

h_mode() {
    xrandr --output LVDS1 --rotate normal
}

#Make startup
desktop () {
    if [ $1 == "i3" ]
    then
        cp ~/.i3start ~/.xinitrc
    elif [ $1 == "dwm" ]
    then
        cp ~/.dwmstart ~/.xinitrc
    else
        echo invalid option
    fi

    exec startx
}

#Various
alias ls='ls --color=auto'
alias du='du -sh'
alias okular="nohup okular > ~/.nohup"
alias browsh="termite -e browsh"
# alias vim=nvim

# Set up miniconda for tihs user
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
