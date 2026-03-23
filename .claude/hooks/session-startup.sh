#!/bin/bash
# SessionStart (startup) hook
# Loads existing simulation state into context when a session begins.
# Output goes to stdout and is injected into the orchestrator's context.

STATE_DIR="sim/state"

if [ ! -f "$STATE_DIR/scene.md" ]; then
  exit 0
fi

echo "=== Simulation State Loaded ==="
echo ""
cat "$STATE_DIR/scene.md"
echo ""

if [ -f "$STATE_DIR/timeline.json" ]; then
  echo "--- Timeline ---"
  cat "$STATE_DIR/timeline.json"
  echo ""
fi
