# Requirements

Capabilities the simulation needs, roughly ordered by dependency.

## Core Loop
- [x] Orchestrator agent processes every player message as a turn
- [x] `/lifesim birth` initializes a character, world, and first formative event
- [x] `/lifesim load` resumes an existing simulation instance
- [x] State files persist to disk after every turn
- [x] Compaction hooks rebuild context seamlessly from state files
- [x] Simulation instances are self-contained directories

## Psychological Engine
- [x] Orchestrator interprets player prose and extracts intent
- [x] Seven-layer profile updates when significance threshold is crossed
- [x] Events target active psychological tensions
- [x] Formative event lifecycle pacing — compress between inflection points, slow at them

## World Simulation
- [x] Orchestrator validates actions against period.md
- [x] Period context generated at birth from model knowledge
- [x] Society and generation state inform event generation
- [x] Material conditions constrain what's possible

## Social Network
- [x] Relationship nodes and edges tracked in network.json
- [ ] Social consequences propagate through the network
- [ ] Gatekeepers control access to opportunity
- [ ] Normative pressure affects decision costs

## State History
- [x] Snapshots capture full state at inflection points and session exits
- [ ] Simulation can be rewound to any snapshot point

## Codex
- [ ] Synthesis pass generates codex at inflection transitions
- [ ] Synthesis pass runs at session exit
- [ ] Chronicle organized by inflection point chapters
- [ ] Codex entries for characters, world, and psychology

## Ancestry
- [ ] Ancestry stubs maintained
- [ ] Retroactive trait resolution based on expressed psychology
- [ ] Ancestry integrates with the character's self-concept narrative

## Player Modes
- [x] Human mode — player provides prose responses (default)
- [ ] AI mode — a subagent generates prose responses autonomously
- [ ] Hybrid mode — AI generates default, player can override
- [x] `/lifesim replay` reconstructs life narrative

## Quality of Life
- [x] `/lifesim profile` renders a readable psychological portrait
- [x] Configurable parameters in instance `config.json` control fidelity
- [x] Session resume via `/lifesim load`
- [x] `/lifesim exit` saves state and commits
