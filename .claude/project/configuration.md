# Configuration

Each instance's `config.json` controls simulation fidelity. Token budget is treated as a hardware constraint; these parameters are the LOD controls.

```json
{
  "state_resolution": 3,
  "turn_scope": "season",
  "narrative_verbosity": "medium",
  "profile_update_threshold": "significant",
  "network_depth": 5,
  "ancestry_detail": "emergent",
  "player_mode": "human",
  "interaction_model": "discussion",
  "player_intention": null
}
```

| Parameter | Values | Effect |
|-----------|--------|--------|
| `state_resolution` | 1-5 | Number of actively tracked fields per state layer. |
| `turn_scope` | `day` / `season` / `year` / `decade` | Time window per turn. |
| `narrative_verbosity` | `minimal` / `medium` / `rich` | Prose length per event. |
| `profile_update_threshold` | `any` / `significant` / `major` | How significant a decision must be to trigger profile update. |
| `network_depth` | 1-10 | Number of actively simulated relationship nodes. |
| `ancestry_detail` | `stub` / `emergent` | Shallow placeholder vs. retroactively resolved through play. |
| `player_mode` | `human` / `ai` / `hybrid` | Who provides prose responses to events. |
| `interaction_model` | `discussion` / `prose` | Co-authoring conversation vs. in-character scene responses. |
| `player_intention` | string or null | Player's meta-orientation for the simulation. |
