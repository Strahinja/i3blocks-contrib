#!/usr/bin/env bash

################################
# Shows info about the weather (in Cincinnati) from accuweather.com
################################

full=""
short=""
color=""
status=0

APPID=$(cat ~/src/i3blocks-contrib/weather2/weather2.key)
URL="https://api.openweathermap.org/data/2.5/weather?q=Belgrade&appid=$APPID&lang=sr&units=metric"
DATA=$(php -r "\$json=json_decode(file_get_contents(\"$URL\")); echo \$json->weather[0]->main . \" \" . \$json->main->temp . \"\\n\";") 

weather="$(echo "$DATA" | sed -re 's/^([^ ]+) +([^ ]+)( +.+)*$/\1/')"
temp="$(echo "$DATA" | sed -re 's/^([^ ]+) +([^ ]+)( +.+)*$/\2/')"

#SITE="$(curl -s "$URL")"

#weather="$(echo "$SITE" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $14 }'| head -1)"
#temp="$(echo "$SITE" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $12"°" }'| head -1)"


if [[ $weather == *thunder* || $weather == *Thunder* ]]; then
    icon=""
else
    if [[ $weather == *rain* || $weather == *Rain* ]]; then
        icon=" "
    else
        if [[ $weather == *cloud* || $weather == *Cloud* ]]; then
            icon=" "
        else
            icon=" "
        fi
    fi
fi


full="$icon $temp°"
short="$temp"


echo "$full"
echo $short
echo $color
exit $status
