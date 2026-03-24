# Exit — Save and Close an Active Simulation

Gracefully end the current simulation session. Aggregate state, write a session summary, commit, and push.

## Process

### 1. Validate Active Session

Check that `sim/.active` exists and points to a valid instance directory. If no simulation is active, tell the player there's nothing to save.

### 2. Ensure State is Current

Read the current `state/scene.md` and verify it reflects the most recent narrative moment. If the conversation has advanced beyond what's written to state files, write any pending updates now:

- `state/scene.md` — current moment and pending threads
- `state/timeline.json` — correct age, stage, turn count
- `state/individual.json` — any psychological changes from the session
- `state/network.json` — any relationship changes from the session
- `log/events.jsonl` — any unlogged events
- `log/decisions.jsonl` — any unlogged player decisions

### 3. Write Session Summary

Create or append to `log/sessions.jsonl` in the instance directory. Each entry captures:

```json
{
  "session_date": "YYYY-MM-DD",
  "turns_this_session": "number",
  "age_range": "start_age - end_age",
  "year_range": "start_year - end_year",
  "key_events": ["brief descriptions"],
  "psychological_changes": ["brief descriptions"],
  "open_threads": ["what's unresolved"],
  "player_intention": "current player intention if set",
  "interaction_model": "discussion or prose"
}
```

### 4. Update init.md

Update `.claude/init.md` to reflect the current session state so the next session can bootstrap cleanly. Include:
- Active instance and its current state
- What was learned or decided this session
- What to work on next

### 5. Present Exit Summary

Tell the player — in narrative terms, not file paths — where Drew (or whoever) is in their life, what's unresolved, and what the next session might explore. Keep it brief and human.

### 6. Commit and Push

Stage all changes and commit with a message summarizing the session's simulation progress. Push to remote.

```bash
git add .
git commit -m "session summary message"
git push
```

### 7. Clear Active Marker

Remove `sim/.active` to signal that no simulation is running.
