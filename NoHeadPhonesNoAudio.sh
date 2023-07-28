#!/bin/bash
#
# Author: Arian A.
# Co-Author: ChatGPT
# Headphone Detection Script: Pico(Macadmins Slack)
# Script: NoHeadphonesNoAudio.sh
# Version: 1.0
# Date: June 27, 2023
# Description: A simple shell script that reduces the volume of a Macintosh computer if no headphones are detected.
# Use case: Libraries











# Check if headphones are plugged in
headphones_connected="$(
  /usr/bin/osascript -l 'JavaScript' -e '
    ObjC.import("objc");
    ObjC.import("AVFoundation");
    $.objc_getClass("AVAudioSession").sharedInstance.currentRoute.outputs.js.map(thisPortDescription => thisPortDescription.portType.js).includes($.AVAudioSessionPortHeadphones.js);
  '
)"

if [ "${headphones_connected}" = 'true' ]; then
    echo 'Headphones ARE plugged in, Volume untouched!'
else
    # Headphones not detected, check and adjust volume
    volume=$(osascript -e 'output volume of (get volume settings)')

    if [[ "$volume" -gt 3 ]]; then
        osascript -e 'set volume output volume 0'
        echo "Volume set to 0."
    else
        echo "Volume is already low."
    fi
fi
