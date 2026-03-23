# Revolutions

Claude Code psychological human lifecycle simulator. Intended for building a deeper understanding of programming Claude Code features.

## What Is This

Revolutions is a prose-driven simulation of a human life — from birth through death — under specific cultural and historical conditions. Every decision is a free-form prose response to a narrative event. Intent is interpreted semantically by a multi-agent system built entirely on Claude Code's native infrastructure: agents, skills, hooks, and file-based state.

The simulation models psychological development through a seven-layer profile grounded in established theory (attachment theory, schema therapy, Schwartz's values, narrative identity). Characters grow, accumulate wounds, develop defenses, and face formative events structured around developmental psychology inflection points.

## Why

This project explores Claude Code's capabilities as a simulation engine:

- **Agents** as specialized processing units (world validation, psychological interpretation, narrative generation)
- **Skills** as game commands (`/birth`, `/profile`, `/replay`)
- **Hooks** for deterministic state management (persistence, context rebuilding after compaction)
- **File-based state** as the ground truth that survives across sessions
- **Context management** as a first-class design constraint — token budget is frame budget

## How It Works

1. Run `claude` in this directory
2. Invoke `/birth` to start a new life
3. Respond to narrative events in prose
4. The orchestrator coordinates subagents to interpret your response, validate it against the historical period, propagate social consequences, and generate the next event

State persists to `sim/state/`. The conversation is ephemeral — compaction hooks rebuild context from state files, so the simulation is seamless across context resets and sessions.

## Project Structure

See [`.claude/project.md`](.claude/project.md) for the full architecture, psychological model, state schemas, and requirements.
