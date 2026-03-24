# Bootstrap a New Project

Scaffold a new project using the iterative-dev workflow.

## Process

### 1. Collect Requirements

Ask the user for:
- **Project name** — used for the directory and git repo
- **Directory path** — where to create the project (default: current working directory)
- **Description** — one-line summary of what the project does

### 2. Enter Plan Mode

This is a concept development session. Enter plan mode and collaborate with the user to flesh out the project concept before writing any files. Work through:

- **Vision** — what the project is and why it exists
- **How it works** — high-level system design
- **Architecture** — components, data flow, key technical decisions
- **Requirements** — the capabilities the project needs, organized by area with checkboxes

Take time here. The project documents carry the project's identity across every future session. They need to be comprehensive enough to bootstrap any conversation, but concise enough to scan quickly.

### 3. Create the Project Skeleton

Once aligned on the concept, exit plan mode and create:

1. **Initialize the directory and git repo**
   ```
   mkdir -p <path>/<project-name>
   cd <path>/<project-name>
   git init
   ```

2. **`.claude/project/README.md`** — vision, how it works, high-level architecture, pointers to sub-files

3. **`.claude/project/requirements.md`** — the requirements checklist developed in step 2

4. **Additional `.claude/project/` files** — as warranted by the project's complexity (schemas, configuration, etc.)

5. **`CLAUDE.md`** — project identity and operational instructions. Keep it focused on what Claude needs to know to work effectively. Reference `.claude/project/README.md` for full context.

6. **`.claude/settings.json`** — if the project needs specific agent configuration, hooks, or environment variables

7. **Replicate the iterative-dev skill** — copy the entire iterative-dev skill into the project so it's self-contained:
   ```
   cp -r ~/.claude/skills/iterative-dev <path>/<project-name>/.claude/skills/iterative-dev
   ```

8. **`.claude/init.md`** — bootstrap for the first development session. Identify the most foundational requirement and write an init targeting it.

9. **`.gitignore`** — appropriate for the project type

### 4. Commit

Stage everything and create the initial commit:
```
git add .
git commit -m "Initial concept: <one-line description>"
```

The project is now ready. The user can start their first development session by opening Claude Code in the project directory and running `/iterative-dev init`.
