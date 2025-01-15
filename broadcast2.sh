#!/bin/bash
echo "streaming at ${icecast-server}/${slug}"
function cleanup {
	pkill -f radio.mp3
}

trap cleanup EXIT
while :
do	
pkill -f radio.mp3
ffmpeg -re -i http://localhost:8000/radio.mp3 -acodec libmp3lame -content_type audio/mpeg -f mp3 icecast://${username}:${password}@${icecast-server}:${port}/${mountpoint}

sleep 1
done
