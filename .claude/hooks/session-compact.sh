#!/bin/bash
# SessionStart (compact) hook
# Rebuilds context from state files after compaction.
# Reads sim/.active to find the active simulation instance.

ACTIVE_FILE="sim/.active"

if [ ! -f "$ACTIVE_FILE" ]; then
  exit 0
fi

INSTANCE=$(cat "$ACTIVE_FILE")
STATE_DIR="sim/$INSTANCE/state"

if [ ! -d "$STATE_DIR" ]; then
  echo "WARNING: Active instance '$INSTANCE' not found." >&2
  exit 0
fi

echo "=== Context Rebuilt From State Files ==="
echo "Active instance: $INSTANCE"
echo ""

cat "$STATE_DIR/scene.md"
echo ""

if [ -f "$STATE_DIR/timeline.json" ]; then
  echo "--- Timeline ---"
  cat "$STATE_DIR/timeline.json"
  echo ""
fi

if [ -f "$STATE_DIR/individual.json" ]; then
  echo "--- Individual Profile ---"
  cat "$STATE_DIR/individual.json"
  echo ""
fi

if [ -f "$STATE_DIR/network.json" ]; then
  echo "--- Network ---"
  cat "$STATE_DIR/network.json"
  echo ""
fi
