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

cat $playlists | remixers_as_artists | keep_only_artists | parse_collaborations | sort | uniq -ci | sort
