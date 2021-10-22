cat `dirname "$0"`/../lists/*.csv | sed 's/,.*(\(.*\) Remix)/ feat. \1,/g' | awk -F ',' '{print $1}' | sed 's/ feat. \| & \| vs /\n/g' | sort | uniq -ci | sort
