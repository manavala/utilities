
#For Ubuntu 12.04
# move buttons to the right
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'

# move buttons to the left
gsettings set org.gnome.desktop.wm.preferences button-layout 'minimize,maximize,close:'


lap_screen_off() {
     echo "first check with xrandr option"
     echo "xrandr --output LVDS1 --off"
 }
