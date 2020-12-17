
This repo is comprised of 2 scripts
1. [sinkSwitcher](#sinkSwitcher)
2. [sinkDefaultSwitcher](#sinkDefaultSwitcher)

Each script is independent from each other.

## Quick setup
- Download whichever you want.
- Install dependencies. `sudo apt-get install pulseaudio xprop`
- Make it executable. `chmod +x sinkSwitcher.sh`.
- Add a symbolic link to your PATH. `ln -s $(pwd)/sinkSwitcher.sh ~/.local/bin/sinkSwitcher`
- Add a keyboard shortcut to execute each script.\
Example command: `bash  /home/{user}/.local/bin/sinkSwitcher`

---

## sinkSwitcher

This scripts detects the application that is on focus, find all audios coming from it and switch them to play on the next audio device.

*Intended to run with a shortcut.*

### Dependencies:

    sudo apt-get install pulseaudio xprop


### Usage:
Focus the application you want it to play in another sink(audio device) and run `sinkSwitcher.sh` with a shortcut

### For example:

You have 2 audio devices connected, a headphone and a speaker

You are watching a video in your browser and its playing through your speakers, but you want to listen to it through your headphones instead.

Focus your browser, and run this script with a shortcut, *always keeping the browser on focus*. The script will automatically detect all audios coming from the browser and play them through the next audio device.

---

## sinkDefaultSwitcher:
This script will just change the default sink(audio device), after this you will be able to control the volume of other sinks.

### Dependencies:

    sudo apt-get install pulseaudio

### For example:
Each time you want to change the volume of another sink, run this script first and then change volume.

# TO-DOs:
Add notification to each changes
