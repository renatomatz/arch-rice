#!/bin/bash

urxvt -geometry 1280x72 -e cmatrix &
sleep 0.5

i3-msg fullscreen

i3lock -n 
i3-msg kill
