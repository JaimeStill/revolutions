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

Delegate synthesis to the **codex agent** (`.claude/agents/codex-agent.md`). Pass it:

1. **The active instance path** — so it knows where to read and write
2. **The baseline snapshot path** — the most recent prior snapshot in `state/snapshots/` (not the one just created — the one *before* it, so the diff covers the session's changes)
3. **Discussion context** — a summary of the session's conversation: what happened narratively, what decisions were made, what tensions were explored, what the player's intentions were. This is the codex agent's richest source material.
4. **Any specific guidance** — moments, characters, or themes that deserve particular attention in the codex

The codex agent follows the synthesis protocol in `.claude/skills/lifesim/reference/synthesis.md` and the style guide in `.claude/skills/lifesim/reference/codex-style.md`. It writes updated codex files directly to the instance and returns a summary of what was created or updated.

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
