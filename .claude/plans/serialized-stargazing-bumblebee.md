# Session Plan: lifesim Skill + Orchestrator

## Context

The simulation needs a single skill (`lifesim`) with sub-commands that manage context layers, plus an orchestrator agent for turn processing. Each simulation instance is fully self-contained in its own directory. No shared state, no implicit session resumption.

## Design Decisions

- **No `.active` file** — simulation only runs after explicit `/lifesim birth` or `/lifesim load`. No implicit state tracking across sessions.
- **Period details generated at birth** — no hardcoded period documents. The model uses its training knowledge. Period context is stored per-instance, separate from society details.
- **Player names instances** — character-based default (e.g., `agnes-1345`), player can override, validated for uniqueness.
- **Turn processing lives in the orchestrator** — not a skill sub-command. After birth/load, every player message is a turn.

## Instance Directory Structure

```
sim/
  <instance-name>/
    config.json                  # Simulation parameters for this run
    state/
      period.md                  # Historical period context (generated at birth, reference doc)
      society.json               # Specific social conditions for this life
      generation.json            # Birth cohort, collective events
      individual.json            # Seven-layer psychological profile
      network.json               # Relationship graph
      timeline.json              # Age, stage, turn counter
      scene.md                   # Current narrative moment
    log/
      decisions.jsonl            # Player decisions
      events.jsonl               # Generated events
    archive/                     # Compressed cold state
```

Note: `period.md` is a new addition — separates historical period facts (what's physically/socially possible in 14th century France) from `society.json` (the specific social conditions the character navigates). The orchestrator reads `period.md` when validating actions.

## Files to Create

### 1. Orchestrator Agent — `.claude/agents/orchestrator.md`

Lean system prompt. Defines:
- Identity: simulation engine, not a game master
- Turn protocol: read state → interpret → validate → update → generate → persist
- Pacing rules: compress between inflection points, slow at them
- State I/O: how to resolve the active instance path (passed in context by birth/load)
- What NOT to do: no menus, no meta-commentary, no numbered choices

Does NOT contain state schemas or birth protocol — those live in the skill's context layers.

### 2. Skill — `.claude/skills/lifesim/`

```
lifesim/
  SKILL.md                       # Routes sub-commands, shared context overview
  commands/
    birth.md                     # Create new instance + character + first event
    load.md                      # Load existing instance into context
    profile.md                   # Render psychological portrait
    compress.md                  # Archive cold state
    replay.md                    # Reconstruct life narrative from logs
```

**SKILL.md** — routing table, instance directory layout, brief state layer overview. Kept short — detail lives in command files.

**commands/birth.md** — the heavy one:
1. Read `sim/config.json` defaults (or use built-in defaults if absent)
2. Accept optional player input (period, region, constraints) or generate
3. Generate period context → write `period.md`
4. Generate society → write `society.json`
5. Generate birth cohort → write `generation.json`
6. Generate character (biological + temperament at birth) → write `individual.json`
7. Initialize family network → write `network.json`
8. Initialize timeline at age 0 → write `timeline.json`
9. Copy config into instance → write `config.json`
10. Generate first formative event → write `scene.md`
11. Initialize empty logs
12. Suggest instance name (character-name-birthyear), let player confirm/override, validate uniqueness
13. Present opening narrative

**commands/load.md** — list instances if none specified, read scene.md + timeline.json + individual.json summary, present current state to player.

**commands/profile.md** — read individual.json, render as readable prose portrait.

**commands/compress.md** — identify cold state (inactive network nodes, old events), move to archive/.

**commands/replay.md** — read decisions.jsonl + events.jsonl, reconstruct narrative.

### 3. Settings Update — `.claude/settings.json`

Add `Skill(lifesim)` to the permissions allow-list.

### 4. Hook Updates — `.claude/hooks/`

The existing hooks reference `sim/state/` which no longer exists. Two options:
- **Option A:** Remove the hooks. Birth/load handle context injection. The orchestrator handles compaction recovery by re-reading state from the instance path it already knows (it's in conversation context).
- **Option B:** Update hooks to find the active instance (e.g., most recently modified directory in `sim/`).

Recommendation: **Option A** — simpler, and aligns with the "no implicit state" principle. The `/lifesim load` command already does what `session-startup.sh` did. For compaction, the orchestrator knows the instance path from the conversation and can re-read state files directly.

### 5. Update CLAUDE.md

Update state file paths to reflect instance-scoped layout. Update the turn protocol to reference the active instance path rather than hardcoded `sim/state/`.

### 6. Update `.claude/project.md`

- Update directory structure section
- Update state file layout
- Add `period.md` as a new state layer
- Update requirements checklist

## What Changes About `.gitignore`

Currently ignores `sim/state/`, `sim/log/`, `sim/archive/`. Needs to ignore `sim/*/` (all instance directories) instead, while keeping the `sim/` directory itself.

## Verification

1. `/lifesim birth` — creates instance directory with all state files, presents opening narrative
2. Player responds in prose — orchestrator processes as turn, updates state, generates next event
3. Check instance directory for updated files
4. `/lifesim profile` — renders readable psychological portrait
5. `/lifesim load <instance>` — lists instances, loads one, presents current state
6. New session → `/lifesim load <instance>` → continues seamlessly
