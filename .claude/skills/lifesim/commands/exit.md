# Exit — Save and Close an Active Simulation

Gracefully end the current simulation session. Snapshot state, synthesize codex, commit, and close.

## Process

### 1. Validate Active Session

Check that `sim/.active` exists and points to a valid instance directory. If no simulation is active, tell the player there's nothing to save.

### 2. Ensure State is Current

Read the current `state/scene.md` and verify it reflects the most recent narrative moment. If the conversation has advanced beyond what's written to state files, write any pending updates now:

- `state/scene.md` — current moment and pending threads
- `state/timeline.json` — correct age, stage, turn count
- `state/individual.json` — any psychological changes from the session
- `state/network.json` — any relationship changes from the session

### 3. Create Snapshot

Copy all current state files to `state/snapshots/turn-{N}-session-exit/` where N is the current turn count. This captures the full machine state at session boundary for future rewind or diffing.

### 4. Synthesize Codex

Run a synthesis pass to update the player-facing artifacts:

1. Identify the latest prior snapshot in `state/snapshots/`
2. Diff current state against that snapshot to understand what changed this session
3. Append a new section to `codex/chronicle.md` covering the narrative since the last synthesis
4. Update `codex/characters/<id>.md` for any network nodes that changed significantly
5. Update `codex/psychology/portrait.md` if `individual.json` crossed a threshold
6. Update `codex/world/` entries if world context shifted

### 5. Present Exit Summary

Tell the player — in narrative terms, not file paths — where the character is in their life, what's unresolved, and what the next session might explore. Keep it brief and human.

### 6. Commit and Push

Stage all changes and commit with a message summarizing the session's simulation progress. Push to remote.

```bash
git add .
git commit -m "session summary message"
git push
```

### 7. Clear Active Marker

Remove `sim/.active` to signal that no simulation is running.
