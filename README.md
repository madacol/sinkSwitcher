
This repo is comprised of 2 scripts
1. [sinkSwitcher](#sinkSwitcher.sh)
2. [sinkDefaultSwitcher](#sinkDefaultSwitcher.sh)

Each script is independent from each other.

## Quick setup
- Download whichever you want.
- Install dependencies. `sudo apt-get install pulseaudio xprop`
- Make it executable. `chmod +x sinkSwitcher.sh`.
- Add a symbolic link to your PATH. `ln -s sinkSwitcher.sh ~/.local/bin/sinkSwitcher`
- Add a keyboard shortcut to execute each script.

---

## sinkSwitcher.sh

This scripts detects the application that is on focus, find all audios coming from it and switch them to play on the next audio device.

*Intended to run with a shortcut.*

### Dependencies:

    sudo apt-get install pulseaudio xprop


### Usage:
Focus the application you want it to play in another sink(audio device) and run `sinkSwitcher.sh` with a shortcut

### For example:
You're listening music with your Headphones, and you want to play a movie for your kids through a TV connected with HDMI,
but the movie's audio is instead playing on your headphones.

All you have to do is focus the movie player (VLC, Smplayer, or whatever) and run `sinkSwitcher.sh` using a shortcut, always keeping the movie on focus. The script will automatically detect all audios coming from the movie player and play them through another device.

---

## sinkDefaultSwitcher.sh:
This script will just change the default sink(audio device), after this you will be able to control the volume of other sinks.

### Dependencies:

    sudo apt-get install pulseaudio

### For example:
Each time you want to change the volume of another sink, run this script first and then change volume.

# TO-DOs:
Add notification to each changes
