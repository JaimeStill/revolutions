#!/bin/bash
# PreCompact hook
# Validates that critical state files exist before compaction fires.
# Warnings go to stderr (logged but not shown to the model).

STATE_DIR="sim/state"
MISSING=0

for f in scene.md timeline.json individual.json; do
  if [ ! -f "$STATE_DIR/$f" ]; then
    echo "WARNING: $STATE_DIR/$f missing before compaction" >&2
    MISSING=$((MISSING + 1))
  fi
done

if [ $MISSING -gt 0 ]; then
  echo "PreCompact: $MISSING state files missing. State may be incomplete." >&2
fi

exit 0
