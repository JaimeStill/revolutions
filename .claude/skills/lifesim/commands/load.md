# Load — Resume a Simulation Instance

Load an existing simulation into context so the player can continue where they left off.

## Process

### 1. Find the Instance

If `$ARGUMENTS` includes an instance name after `load` (e.g., `/lifesim load drew-1993`), use that.

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

### 3. Load State into Context

Read the following files to build your understanding of the character's current state. **Do not present these to the player yet** — internalize them as context for the orientation you'll write in step 5.

1. `state/scene.md` — the current moment (read in full)
2. `state/timeline.json` — age, stage, turn count
3. `state/individual.json` — psychological state (active schemas, current defense tier, dominant self-concept)
4. `state/network.json` — active relationships and their dynamics
5. `codex/chronicle.md` — if it exists, read it. This is the narrative record of the character's life and your primary source for the story-so-far summary.

### 4. Activate

Write the instance name to `sim/.active`.

Set the instance path in context so the orchestrator knows where to read/write state. From this point forward, the simulation is active and operates in the three-phase turn cycle (Scene → Discussion → Commit).

### 5. Present

Output an orientation that catches the player up on this character's life, then present the current scene.

**Style:** Write the orientation like you're catching a co-worker up on a game you've been playing. Conversational, specific, informational. Not literary prose, not engine narration. The player may not have been in the simulation for days or weeks — the orientation should make them feel caught up and ready to engage.

**Content — hit these beats in plain language:**
- **Who this person is** — name, age, where they live, a sentence or two that captures who they are right now
- **What's happened so far** — the major beats of the character's life, compressed to what matters. Use `codex/chronicle.md` as your primary source. Be specific: names, events, decisions, consequences.
- **Who matters** — the 3-4 most important relationships and their current state
- **What's unresolved** — active threads, pending decisions, open questions the simulation is sitting on

**Anti-patterns:**
- No engine prose. Not "Three years of building have made him into something." Instead: "Drew is 14, about to start eighth grade in Plano, Texas. He's spent the last three years training muay thai at Tran's gym and building websites with his best friend Marcus."
- No psychological jargon. Not "emotional inhibition schema is active." Instead: "He's always been better at doing things than saying what he feels."
- No numbered lists of relationships. Weave the people into the story naturally.

**Transition:** After the orientation, present the current scene from `scene.md` so the player can respond in prose immediately. If the codex is available, mention it briefly in case the player wants to review the full record.
