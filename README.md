# sinkSwitcher.sh

This scripts detects the application that is on focus, then find all belonging sink-inputs and switch them to next sink.

*Intended to run with a shortcut.*

#### For example:
You're listening music with your Headphones, but you want to play a movie for your kids through a TV connected with HDMI,
but the movie's audio is playing on your headphones

All you have to do is focus the movie player (VLC, Smplayer, or whatever) and run `sinkSwitcher.sh` using a shortcut, always keeping the movie on focus. 
The script will automatically detect all audios coming from the movie player and play them through another device.

## Dependencies:
`sudo apt-get install pulseaudio xprop`
#### Recommended:
`sudo apt-get install compizconfig-settings-manager`.
To configure this script with a keyboard shortcut on Ubuntu.

## Usage:
Focus the application you want to change its sink and run `sinkSwitcher.sh` with a shortcut

# sinkDefaultSwitcher.sh:
This script will just change the default sink, after this you will be able to control the volume of other sinks.

#### For example:
Each time you want to change the volume of another device, run this script first and then change volume.

# TO-DOs:
Add notification to each changes
