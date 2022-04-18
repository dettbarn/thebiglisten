#!/bin/bash

playlists=`dirname "$0"`/../lists/*.csv

function playlists_with_numbers {
	awk '{ print FILENAME "," $0 }' $playlists | sed 's/[^,]*ld\([0-9]*\)\.csv\(,.*\)/\1\2/g'
}

function remixers_as_artists {
	sed 's/\([0-9]*,[^,]*\),.*(\(.*\) Remix)/\1 feat. \2,/g' $1
}

function keep_only_artists {
	awk -F ',' '{print $1,$2}'
}

# TODO: find a nice solution that always works
# quick hack: replacing 5 times should be enough for the moment
function parse_all_collaborations {
	parse_collaborations $1 | parse_collaborations | parse_collaborations | parse_collaborations | parse_collaborations
}

function parse_collaborations {
	sed 's/\([0-9]* \)\(.*\)\( feat. \| & \| vs \| mit \)\(.*\)/\1\2\n\1\4/g' $1
}

function sort_by_most_recent {
	sort -k 1n -t ',' $1 | sort -k 2r -k 1nr | uniq -f 1 | sort -k 1n
}

playlists_with_numbers | remixers_as_artists | keep_only_artists | parse_all_collaborations | sort_by_most_recent
