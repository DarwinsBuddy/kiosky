cmd=$1
OUTPUT="HDMI-1"

if [ "$cmd" -eq "on" ];
then
    export DISPLAY=:0.0 && xrandr --output "$OUTPUT" --auto
elif [ "$cmd" -eq "off" ];
then
    export DISPLAY=:0.0 && xrandr --output "$OUTPUT" --off
fi