
#For Ubuntu 12.04
# move buttons to the right
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'

# move buttons to the left
gsettings set org.gnome.desktop.wm.preferences button-layout 'minimize,maximize,close:'


lap_screen_off() {
     #Dont Distrub HDMI / VGA
     echo "first check with xrandr option"
     echo "xrandr --output LVDS1 --off"
 }
 
 all_screen_off() {
      echo "xset dpms force off"
 }


limit_internet_speed() {

     echo "option 1 (per interface)"
     echo "to install"
     echo "sudo apt-get install wondershaper"
     echo "eg: check with ifconfig # downspeed is 1024 kb/s, up is 256 kb/s"
     echo "sudo wondershaper eth1 1024 256"
     echo "to reset 'sudo wondershaper clear eth1' "

     echo "option 2 (automatically choose any interface(wifi/eth/usb/etc) that using internet)"
     echo "to install"
     echo "sudo apt-get install trickle"
     echo "sudo trickle -d 120 -u 32 ie down 120 KB/s down 32 KB/s" 

     echo "For any more info: man wondershaper or man trickle"
}


