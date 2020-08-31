#~/.xinitrc

exec nitrogen --restore &
exec compton -b 0 & 
exec compton --config ~/.config/compton.conf &

while true ; do 

    load=$(cat /proc/loadavg |cut -d " " -f 3 )
    memstat=$(free -h | awk '(NR==2){ print $7 }')
    statcpu0=$(sensors | awk '(NR==13){ print $3 }' | cut -b 2-3)
    statcpu1=$(sensors | awk '(NR==14){ print $3 }' | cut -b 2-3)
    lanstat=$(cat /sys/class/net/enp3s0/operstate)
    volstat=$(pamixer --get-volume-human)
    load_stats="| LOAD: ${load} | MEM: ${memstat} | CPU: ${statcpu0}°C/${statcpu1}°C | ETH: ${lanstat} | VOL: ${volstat}"

    xsetroot -name " `date '+%a %m-%d-%Y %r' ` $load_stats "; sleep 1; 
done &

nvidia-settings --assign CurrentMetaMode="1600x900 +0+0 { ForceCompositionPipeline=On, ForceFullCompositionPipeline=On }" &
xrandr --output HDMI-0 --mode 1600x900 &
exec start-pulseaudio-x11 &

exec dwm

