# Compress — Archive Cold State

Move inactive state out of the main state files and into the instance's archive to reduce context load.

## Process

### 1. Find Active Instance

Read `sim/.active` to get the instance name. If no simulation is active, tell the player to load one first.

### 2. Identify Cold State

Read the active instance's state files and identify what's no longer actively relevant:

**Network nodes** — characters who are:
- Dead and no longer referenced in active schemas or self-concept
- Geographically removed with no narrative threads connecting them
- Minor figures with no pending relationship arcs

**Event log entries** — events in `log/events.jsonl` older than the current developmental stage that have no unresolved consequences.

**Decision log entries** — decisions in `log/decisions.jsonl` whose consequences have fully propagated.

### 3. Archive

Move cold items to `archive/` within the instance:
- `archive/network-cold.json` — archived relationship nodes (append, don't overwrite)
- `archive/events-cold.jsonl` — archived event entries
- `archive/decisions-cold.jsonl` — archived decision entries

Update the live state files to remove the archived items.

### 4. Report

Briefly tell the player what was archived (e.g., "Archived 3 inactive relationships and 12 resolved events"). Don't break the narrative — keep it minimal.
