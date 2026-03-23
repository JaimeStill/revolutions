#!/bin/bash
# SessionStart (compact) hook
# Rebuilds context entirely from state files after compaction.
# The compaction summary is irrelevant — state files are authoritative.

STATE_DIR="sim/state"

if [ ! -f "$STATE_DIR/scene.md" ]; then
  exit 0
fi

echo "=== Context Rebuilt From State Files ==="
echo ""
cat "$STATE_DIR/scene.md"
echo ""

if [ -f "$STATE_DIR/timeline.json" ]; then
  echo "--- Timeline ---"
  cat "$STATE_DIR/timeline.json"
  echo ""
fi

if [ -f "$STATE_DIR/individual.json" ]; then
  echo "--- Individual Profile (summary) ---"
  # Load enough of the profile for the orchestrator to orient
  cat "$STATE_DIR/individual.json"
  echo ""
fi

if [ -f "$STATE_DIR/network.json" ]; then
  echo "--- Network (active nodes) ---"
  cat "$STATE_DIR/network.json"
  echo ""
fi
