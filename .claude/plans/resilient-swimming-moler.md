# Plan: Chronicle Directory Migration

## Context

The drew-1993 chronicle is 327 lines / 60KB in a single `codex/chronicle.md` and growing with each synthesis pass. Playtest feedback: it should become an indexed sub-directory (like `.claude/project/`), with a README.md index and individual chapter files. This improves context efficiency — the load command can read the index + recent chapters instead of the entire file.

## Approach

Two concerns: **migrate drew-1993 data** and **update engine instructions** so all future synthesis passes create chapter files instead of appending to a monolithic file.

### 1. Split drew-1993 chronicle into chapter files

Create `sim/drew-1993/codex/chronicle/` with:

| File | Source |
|------|--------|
| `README.md` | New — title + table index with links, periods, one-line summaries |
| `01-the-absorbent-years.md` | Lines 4–17 (Chapter: The Absorbent Years, 1993–2000) |
| `02-the-agency-threshold.md` | Lines 19–25 (Chapter: The Agency Threshold, 2000–2002) |
| `03-the-quiet-years.md` | Lines 27–39 (Interlude: The Quiet Years, 2002–2004) |
| `04-ranges.md` | Lines 41–127 (Chapter: Ranges, 2004–2007) |
| `05-the-letter.md` | Lines 129–267 (Chapter: The Letter, Aug–Sep 2007) |
| `06-carols-kitchen.md` | Lines 269–327 (Chapter: Carol's Kitchen, Oct 2007) |

Each file promotes its heading from `##` to `#`. Delete the original `chronicle.md` after split.

Update `sim/drew-1993/codex/README.md` — link changes from `chronicle.md` to `chronicle/`.

### 2. Update engine files (runtime behavior)

**`.claude/agents/domain/codex-agent.md`**
- Step 6 instruction: "Append to `chronicle.md`" → "Create a new chapter file in `chronicle/` and update `chronicle/README.md`"
- File path example: update to show `chronicle/07-chapter-slug.md`
- Add naming convention note: `NN-slug.md`, `#` level heading, update README index after each chapter

**`.claude/skills/lifesim/reference/synthesis.md`**
- Step 2: "writes a new chapter or section for `chronicle.md`" → "writes a new chapter file in `chronicle/`"
- "Append, don't overwrite" → "Create, don't overwrite" — each chapter is a new file, existing chapters aren't rewritten

**`.claude/skills/lifesim/commands/load.md`**
- Step 5: read `codex/chronicle/README.md` for index, then most recent 1-2 chapters (not the entire chronicle)
- Story-so-far source: `codex/chronicle/` with README for structure, chapter files for content

**`.claude/skills/lifesim/commands/birth.md`**
- Step 9 (codex init): `chronicle.md` → `chronicle/README.md`
- Step 11 (directory listing): same structural change

**`.claude/skills/lifesim/commands/replay.md`**
- Step 2: check `codex/chronicle/README.md`, read chapter files in sequence

### 3. Update documentation files

- `.claude/project/README.md` — directory tree: `chronicle.md` → `chronicle/` + `README.md`
- `.claude/project/state.md` — instance layout + synthesis step 2
- `.claude/skills/lifesim/SKILL.md` — instance layout
- `sim/README.md` — instance layout

### Files NOT changed

- `.claude/skills/lifesim/reference/codex-style.md` — references "the chronicle" conceptually, never by path
- `.claude/agents/orchestrator.md` — no direct chronicle references
- Plan files in `.claude/plans/` — historical, left as-is

## Verification

1. Confirm all 6 chapter files + README exist in `sim/drew-1993/codex/chronicle/`
2. Confirm `chronicle.md` is removed
3. Grep for remaining `chronicle.md` references in engine/doc files — should be zero (excluding plan files and old snapshots)
4. Spot-check that chapter file content matches original (heading promotion, no content loss)
5. Verify README index links resolve correctly
