# Next Session: First Playtest + Iteration

The core loop infrastructure is in place — orchestrator agent, lifesim skill with sub-commands, instance-scoped state, compaction hooks. This session is about playing and fixing.

## Goal

Run `/lifesim birth`, play through several turns, and iterate on anything that doesn't work or feel right.

## What to Test

1. `/lifesim birth` — does it create all state files, present a compelling opening, and transition smoothly into turn processing?
2. Turn processing — does the orchestrator read state, interpret prose, update files, and generate the next event?
3. Pacing — does time compress between inflection points and slow at them?
4. `/lifesim profile` — does it render a readable portrait from the current state?
5. `/lifesim load` — kill the session, restart, load the instance. Does it pick up cleanly?

## What to Fix

Expect rough edges in:
- State file writes (missing fields, schema drift from what the orchestrator expects)
- Pacing feel (too fast, too slow, wrong granularity)
- Narrative quality (too mechanical, too verbose, breaks character)
- Birth flow (too many questions, not enough context generated)

Fix issues inline as they surface. Update the skill commands and orchestrator agent as needed.

## Definition of Done

A full birth-to-childhood arc (at least through the attachment formation inflection point) that feels like a coherent simulation, with state persisting correctly across turns.
