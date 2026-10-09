#!/bin/bash
set -u

aerospace list-windows --all --format '%{app-name}|%{window-id}' |
while IFS='|' read -r app id; do
  case "$app" in
    Books)              ws=Books ;;
    Discord|Vesktop)    ws=Discord ;;
    Finder)             ws=Finder ;;
    Mail)               ws=Mail ;;
    Music)              ws=Music ;;
    Obsidian)           ws=Obsidian ;;
    VLC)                ws=VLC ;;
    Zed|Code|kitty)     ws=Zed ;;
    Firefox)            ws=Firefox ;;
    Calendar|Reminders) ws=CalRem ;;
    *) continue ;;
  esac
  aerospace layout tiling --window-id "$id" >/dev/null 2>&1
  echo "Moving window $id ($app) to workspace $ws"
  aerospace move-node-to-workspace "$ws" --window-id "$id"
done
