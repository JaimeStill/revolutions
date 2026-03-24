# Revolutions

Claude Code psychological human lifecycle simulator. Intended for building a deeper understanding of programming Claude Code features.

## What Is This

Revolutions is a prose-driven simulation of a human life — from birth through death — under specific cultural and historical conditions. Every decision is a free-form prose response to a narrative event. Intent is interpreted semantically by the orchestrator agent built on Claude Code's native infrastructure: agents, skills, hooks, and file-based state.

The simulation models psychological development through a seven-layer profile grounded in established theory (attachment theory, schema therapy, Schwartz's values, narrative identity). Characters grow, accumulate wounds, develop defenses, and face formative events structured around developmental psychology inflection points.

## How It Works

1. Run `claude` in this directory
2. Invoke `/lifesim birth` to start a new life
3. Respond to narrative events in prose
4. The orchestrator interprets your response, validates it against the historical period, propagates social consequences, and generates the next event

Each simulation instance lives in `sim/<instance-name>/` with two domains: `state/` (machine-optimized JSON and markdown for the engine) and `codex/` (human-readable narrative projections — chronicle, character sheets, psychological portraits). State snapshots at inflection points enable rewinding and codex synthesis.

## Project Structure

See [`.claude/project/`](.claude/project/README.md) for the full architecture, psychological model, state schemas, and requirements.
