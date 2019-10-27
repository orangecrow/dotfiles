bspc node -t floating
bspc node -z left 300 0
bspc node -z top 0 250
bspc node -v 552 275 
bspc node -g sticky
clear
while [ 1=1 ]
do
    #upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E "percentage|state|to\ full"|sed s/\ //g
    upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E "percentage|to\ full"|sed s/\ //g
    date
    sleep 60
    clear
done
