
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

install_clock() {
     #There’s a PPA contains the packages for this app, available for Ubuntu 12.04, Ubuntu 14.04, Ubuntu 15.04.
     echo "sudo add-apt-repository ppa:apandada1/up-clock"
     echo "sudo apt-get update"
     echo "sudo apt-get install up-clock"
     #after installed use command "up-clock" 
}

ubuntu_cpu_cool() {
#suppress unwanted gpe at startup
#ref: http://askubuntu.com/questions/176565/why-does-kworker-cpu-usage-get-so-high
Instead I think this CPU usage is not normal and is related to the well-known kworker bug: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/887793

The solution for me and for many others was, first of all, find out the "gpe" that is causing the bad stuff with something like:

grep . -r /sys/firmware/acpi/interrupts/
and check for an high value (mine was gpe13 - with a value like 200K - so, you have to change it accordingly, if differs). After that:

~ cp /sys/firmware/acpi/interrupts/gpe13 /pathtobackup
~ crontab -e
Add this line, so it will be executed every startup/reboot:

@reboot echo "disable" > /sys/firmware/acpi/interrupts/gpe13
Save/exit. Then, to make it work also after wakeup from suspend:

~ touch /etc/pm/sleep.d/30_disable_gpe13
~ chmod +x /etc/pm/sleep.d/30_disable_gpe13
~ vim /etc/pm/sleep.d/30_disable_gpe13
Add this stuff:

#!/bin/bash
case "$1" in
    thaw|resume)
        echo disable > /sys/firmware/acpi/interrupts/gpe13 2>/dev/null
        ;;
    *)
        ;;
esac
exit $?
Save/exit, done.

-- Ubuntu 12.10 on Samsung Chronos 7 series - Model no. NP700Z7C --
}
