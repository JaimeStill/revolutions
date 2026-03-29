# Requirements

Capabilities the simulation needs, roughly ordered by dependency.

## Core Loop
- [x] Orchestrator agent coordinates the simulation
- [x] Three-phase turn cycle: Scene → Discussion → Commit
- [x] `/lifesim birth` initializes a character, world, and first formative event
- [x] `/lifesim load` resumes an existing simulation instance
- [x] State files persist to disk at commit time
- [x] Simulation instances are self-contained directories
- [x] Commit trigger is conversational — no explicit command

## Domain Architecture
- [x] Every state file has exactly one owning agent
- [x] Orchestrator owns coordination files only (scene.md, timeline.json)
- [x] Psychology agent owns individual.json
- [x] Network agent owns network.json
- [x] World agent owns world state (society.json, period.md, generation.json)
- [x] Codex agent owns codex/*
- [x] Orchestrator delegates to affected domain agents at commit time

## Event Mechanics
- [x] Relationship events during time compression — orchestrator selects neglected high-warmth/attachment characters
- [x] Relationship event pacing — 1-2 per compression period, woven into compression narrative
- [x] Event presentation principle — presence test determines scene vs. information channel
- [x] Network events slow compression when protagonist would be present
- [x] Event reference guide for craft guidance (`.claude/skills/lifesim/reference/events.md`)
- [x] Persona agent for character embodiment during events — player interacts with characters directly
- [x] Agent directory organized by role: domain (state processors) vs. actors (character performers)
- [ ] Formalized engagement mode for pivotal moments — distinct from routine turn cycle
- [ ] Mechanics for how pivotal moments play out (stakes, constraints, feedback loops)
- [ ] Integration with three-phase cycle (how does discussion/commit behave during pivotal moments?)
- [ ] World events that emerge at narrative climaxes — not scripted, but organically timed
- [ ] Consequences of pivotal moments have outsized impact on state

## Psychological Engine
- [x] Psychology agent interprets psychological signals from committed actions
- [x] Seven-layer profile updates when significance threshold is crossed
- [x] Events target active psychological tensions
- [x] Formative event lifecycle pacing — compress between inflection points, slow at them

## World Simulation
- [x] World agent validates actions against period.md possibility space
- [x] World-building session at birth supports any setting (historical, fantasy, sci-fi, etc.)
- [x] Period.md captures tonal register alongside factual possibility space
- [x] Society and generation state inform event generation
- [x] Material conditions constrain what's possible

## Tonal Sovereignty
- [x] User sets the narrative register; engine maintains it
- [x] Orchestrator never originates tonal shifts
- [x] World agent validates tonal plausibility alongside factual plausibility
- [x] Tonal register can expand — only when user expands it

## Social Network
- [x] Relationship nodes and edges tracked in network.json
- [x] Social consequences propagate through the network
- [x] Gatekeepers control access to opportunity
- [x] Normative pressure affects decision costs

## State History
- [x] Snapshots capture full state at inflection points and session exits
- [ ] Simulation can be rewound to any snapshot point (deferred — depends on world simulation architecture)

## Codex
- [x] Synthesis pass generates codex at inflection transitions
- [x] Synthesis pass runs at session exit (if no inflection-triggered synthesis occurred)
- [x] Chronicle organized by inflection point chapters
- [x] Codex entries for characters, world, and psychology
- [x] Codex agent receives domain agent summaries alongside state diffs

## Ancestry
- [ ] Ancestry stubs maintained
- [ ] Retroactive trait resolution based on expressed psychology
- [ ] Ancestry integrates with the character's self-concept narrative

## Player Modes
- [x] Human mode — player provides prose responses (default)
- [ ] AI mode — a subagent generates prose responses autonomously
- [ ] Hybrid mode — AI generates default, player can override
- [x] `/lifesim replay` reconstructs life narrative

## Session Continuity
- [x] `/lifesim load` uses conversational briefing style — catches player up like a friend, not engine prose
- [x] Inflection point recognition — orchestrator identifies crystallizing moments, not just binary thresholds

## Quality of Life
- [x] `/lifesim profile` renders a readable psychological portrait
- [x] Configurable parameters in instance `config.json` control fidelity
- [x] Session resume via `/lifesim load`
- [x] `/lifesim exit` saves state and commits

## Future Vision
- [ ] World simulation — full world perspective beyond single character (architecture TBD)
- [ ] Snapshot rewinding with branching (depends on world simulation decisions)
- [ ] Non-historical birth validation (after core mechanics stabilize)
- [ ] Bun infrastructure / GitHub Pages deployment for codex and simulation state (after state and codex schemas are stable)
