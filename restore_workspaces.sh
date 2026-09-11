#!/bin/bash
# restore_workspaces.sh
# This script reorders windows for specific apps back to their designated workspaces
# using the AeroSpace CLI and jq.

# Ensure that jq is installed (use: brew install jq)

set -u

# Array of target app names, corresponding to the "app-name" in AeroSpace list output.
apps=("Books" "Discord" "Finder" "Mail" "Music" "Obsidian" "VLC" "Zed" "Code" "Firefox" "Calendar" "Reminders")
# Their corresponding workspace names; adjust them if needed.
workspaces=("Books" "Discord" "Finder" "Mail" "Music" "Obsidian" "VLC" "Zed" "Zed" "Firefox" "CalRem" "CalRem")

# Number of apps in our arrays.
n=${#apps[@]}

# Optional debug output:
#   AEROSPACE_RESTORE_DEBUG=1 ~/Documents/config/restore_workspaces.sh
if [ "${AEROSPACE_RESTORE_DEBUG:-0}" = "1" ]; then
  echo "Current window app names:"
  aerospace list-windows --all --json | jq -r '.[].["app-name"]' | sort -u
  echo
fi

for (( i=0; i < n; i++ )); do
  app="${apps[$i]}"
  workspace="${workspaces[$i]}"

  # Extract all window-ids for the given app from the JSON output.
  window_ids=$(
    aerospace list-windows --all --json \
      | jq -r --arg app "$app" '.[] | select(.["app-name"] == $app) | .["window-id"]'
  )

  if [ -n "$window_ids" ]; then
    while IFS= read -r window_id; do
      [ -z "$window_id" ] && continue
      # Ensure restored windows participate in tiling split (not floating).
      aerospace layout tiling --window-id "$window_id" >/dev/null
      echo "Moving window $window_id ($app) to workspace $workspace"
      aerospace move-node-to-workspace "$workspace" --window-id "$window_id"
    done <<< "$window_ids"
  else
    echo "No window found for app '$app'"
  fi
done
