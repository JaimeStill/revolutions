# Exit — Save and Close an Active Simulation

Gracefully end the current simulation session. Validate state, snapshot, synthesize if needed, commit, and close.

## Process

### 1. Validate Active Session

Check that `sim/.active` exists and points to a valid instance directory. If no simulation is active, tell the player there's nothing to save.

### 2. Ensure State is Current

Read the current `state/scene.md` and verify it reflects the most recent narrative moment. If the conversation has advanced beyond what's written to state files (e.g., discussion was in progress but no commit happened), run a final commit:

- Delegate to affected domain agents for any pending state changes
- Write `state/scene.md` — current moment and pending threads
- Write `state/timeline.json` — correct age, stage, turn count

### 3. Create Snapshot

Copy all current state files to `state/snapshots/turn-{N}-session-exit/` where N is the current turn count.

### 4. Synthesize Codex (if needed)

Synthesis is primarily triggered during commit phases at inflection points. At session exit, only run the codex agent if the session included commits that didn't already trigger synthesis — i.e., if the session advanced the narrative but no inflection point was crossed.

If synthesis is needed, delegate to the **codex agent** (`.claude/agents/codex-agent.md`):

1. **The active instance path**
2. **The baseline snapshot path** — the most recent prior snapshot (not the one just created)
3. **Discussion context** — summary of the session's narrative: what happened, what decisions were made, what tensions were explored
4. **Domain agent summaries** — consequence narratives from domain agents that ran during the session's commits
5. **Any specific guidance** — moments, characters, or themes that deserve attention

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
