#!/bin/bash
# PreCompact hook
# Validates that critical state files exist in the active instance before compaction.

ACTIVE_FILE="sim/.active"

if [ ! -f "$ACTIVE_FILE" ]; then
  exit 0
fi

INSTANCE=$(cat "$ACTIVE_FILE")
STATE_DIR="sim/$INSTANCE/state"
MISSING=0

for f in scene.md timeline.json individual.json; do
  if [ ! -f "$STATE_DIR/$f" ]; then
    echo "WARNING: $STATE_DIR/$f missing before compaction" >&2
    MISSING=$((MISSING + 1))
  fi
done

if [ $MISSING -gt 0 ]; then
  echo "PreCompact: $MISSING state files missing in instance '$INSTANCE'. State may be incomplete." >&2
fi

exit 0
