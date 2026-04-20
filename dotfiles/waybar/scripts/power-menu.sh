#!/usr/bin/env bash
# ── power-menu.sh ─────────────────────────────────────────────────────────────
# Simple rofi/wofi power menu. Requires: rofi-wayland OR wofi
# ─────────────────────────────────────────────────────────────────────────────

OPTIONS="󰍃  Lock\n󰤄  Suspend\n  Reboot\n󰐥  Shutdown"
CHOSEN=$(echo -e "$OPTIONS" | wofi --dmenu \
  --prompt "Power" \
  --width 200 \
  --height 210 \
  --cache-file /dev/null)

case "$CHOSEN" in
  *Lock)     loginctl lock-session ;;
  *Suspend)  systemctl suspend ;;
  *Reboot)   systemctl reboot ;;
  *Shutdown) systemctl poweroff ;;
esac
