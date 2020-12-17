#!/usr/bin/env bash

#######

# Dependencies: pulseaudio, xprop
# Recommended: compizconfig-settings-manager. To configure this script with a keyboard shortcut.
# Intended to run with a keyboard shortcut.

# USAGE: Focus the application you want to change its sink and run this script with a shortcut.

# This scripts detects the focused application with `xprop`, and iterate through all sink-inputs and
# if a sink-input belongs to the application or it's children processes then switch it to the next sink.

#######
##  Terminology
# sink:       audio device (mostly hardware)
# sink-input: audio stream coming from apps (An app can have multiple sink-inputs)
# pid-source: pids of app on focus (main pid, and children's pid's)
#######

# Recursive function to get all the nested Pids from the main pid
MAX_RECURSION=10
i=0
getAllRelatedPids()
{
    local parentPid=$1
    local childrenPids=( $(pgrep -P $parentPid) )
    local nestedPids=()
    for childPid in "${childrenPids[@]}"; do
      i=$((i+1))
      if [ $i = $MAX_RECURSION ]; then
        return
      fi
      nestedPids+=( $(getAllRelatedPids $childPid) )
      i=$((i-1))
    done
    echo "$parentPid ${nestedPids[@]}"
}

# Find PIDs of focused window
xid=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print $NF}')
app_main_pid=$(xprop -id $xid _NET_WM_PID | awk '{print $NF}')
pid_sources_array=( $(getAllRelatedPids $app_main_pid) )
sink_list_array=( $(pacmd list-sinks | awk '/index:/{print $NF}') )
sink_list_size=${#sink_list_array[@]}

# Linearizes sink-inputs, showing index, sink and pid on a same line. Then iterate through each sink_input.
pacmd list-sink-inputs | grep -E 'index:|sink:|process.id' | tr '\n' ' ' | tr -d '"' | sed -e 's/index:/\n/g' | tail -n +2 | while IFS= read -r line || [ -n "$line" ]; do
  sink_input_app_pid=$(echo $line | awk '{print $NF}')
  # Check if sink-input's app matches with the focused app
  sinkMatchesSource=false;
  for pid_source in "${pid_sources_array[@]}"; do
    if [ $sink_input_app_pid = $pid_source ]; then
      sinkMatchesSource=true
      break
    fi
  done
  if ! $sinkMatchesSource ; then
      continue;
  fi

  # A match was found. This sink-input comes from one of the pid-sources

  # Extract more parameters
  sink_input_index=$(echo $line | awk '{print $1}')
  current_sink_index=$(echo $line | awk '{print $3}') # this is the sink where current sink-input is playing

  # Find next sink's index to switch to
  i=0
  for sink in "${sink_list_array[@]}"; do
    i=$((($i+1)%sink_list_size))  # i++ mod(#sinks)
    if [ $sink = $current_sink_index ]; then
      next_sink_index=${sink_list_array[i]}
      break
    fi
  done

  # Swtich to next sink
  pacmd move-sink-input $sink_input_index $next_sink_index
done