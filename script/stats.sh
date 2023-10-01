#!/bin/bash

playlists=`dirname "$0"`/../lists/*.csv

function remixers_as_artists {
	sed 's/,.*(\(.*\) \(Remix\|Edit\))/ feat. \1,/g' $1
}

function keep_only_artists {
	awk -F ',' '{print $1}'
}

function parse_collaborations {
	sed 's/ feat. \| & \| vs \| mit \| x \| pres. /\n/g' $1
}

cat $playlists | remixers_as_artists | keep_only_artists | parse_collaborations | sort | uniq -ci | sed -e 's/^ *//;s/ /,/' | sort -t ',' -k1,1nr -k2,2 | awk -F ',' '{printf("%s,%s\n", $2, $1)}' > counts.csv

minCount=2

counter=0
artistCount=0
prevArtistCount=0
while read line
do
  counter=$((counter+1))
  if [[ $line =~ (.*),([0-9]+) ]]
  then
    artistCount="${BASH_REMATCH[2]}"  # extract count
	if [[ $artistCount -ne $prevArtistCount ]]
	then
	  place=$counter  # different count for this artist, so new place opens
	fi
	if [[ $artistCount -lt $minCount ]]
	then
	  exit 0  # only print down to minCount, ignore lower counts
	fi
	else
	echo "Error"  # this should not happen
	exit 1
  fi
  echo "$place","$line"
  prevArtistCount=$artistCount
done <counts.csv
