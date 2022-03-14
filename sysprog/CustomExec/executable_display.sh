#!/bin/bash

xrandr --output LVDS1 --primary
xrandr --output HDMI1 --auto --left-of LVDS1
feh --bg-fill '/home/chandan/Images/plane.png' '/home/chandan/Images/dark_place.jpeg'
