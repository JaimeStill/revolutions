# Load — Resume a Simulation Instance

Load an existing simulation into context so the player can continue where they left off.

## Process

### 1. Find the Instance

If `$ARGUMENTS` includes an instance name after `load` (e.g., `/lifesim load agnes-1345`), use that.

If no instance is specified, list all directories in `sim/` (excluding `.active`) and ask the player to choose. For each instance, show a brief summary by reading its `state/timeline.json`:
- Character age and developmental stage
- Turn count
- Current year

### 2. Validate

Confirm the instance directory exists and contains the minimum required files:
- `state/scene.md`
- `state/timeline.json`
- `state/individual.json`

If any are missing, warn the player that the instance may be corrupted.

### 3. Load State

Read the following files and present a narrative summary to the player:

1. `state/scene.md` — the current moment (read in full)
2. `state/timeline.json` — age, stage, turn count
3. `state/individual.json` — brief psychological summary (active schemas, current defense tier, dominant self-concept)
4. `state/network.json` — active relationships (names and roles only, not full detail)

### 4. Activate

Write the instance name to `sim/.active`.

Set the instance path in context so the orchestrator knows where to read/write state. From this point forward, every player message is a simulation turn.

### 5. Present

Output a brief orientation — where the character is in their life, what just happened, what's unresolved — then present the current scene. The player should be able to respond in prose immediately.
