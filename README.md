# sam-sandbox

General purpose sandbox for experiments, scripts, and scratch work.

## Structure

```
scripts/      # One-off utilities, automation scripts
experiments/  # Testing ideas, prototypes
templates/    # Reusable starting points
notes/        # Research, thinking, documentation
scratch/      # True throwaway stuff
```

## Index

_Keep this updated as things grow._

### Active

- **Parallel Workflow System** - Multi-environment Claude workflow (local + cloud)
  - `notes/parallel-workflow-plan.md` - Full workflow plan and architecture
  - `templates/CLAUDE.md.template` - Context handoff template for projects
  - `templates/mermaid-examples.md` - Diagram templates (flowcharts, architecture, etc.)
  - `scripts/session-handoff.sh` - Quick handoff between local/cloud
  - `scripts/parallel-status.sh` - Check status of all work streams
  - `scripts/start-feature.sh` - Initialize a new feature with proper setup
  - `scripts/git-aliases.sh` - Useful git aliases for parallel workflow

### Archived

- (nothing yet)

---

## Quick Start: Parallel Workflow

### Starting a new feature
```bash
./scripts/start-feature.sh LIN-123 "feature-description"
```

### Check status of parallel work
```bash
./scripts/parallel-status.sh
```

### Hand off to cloud (when leaving your desk)
```bash
./scripts/session-handoff.sh to-cloud "summary of current state"
```

### Hand off to local (when returning)
```bash
./scripts/session-handoff.sh to-local "summary of cloud work"
```

### Install git aliases
```bash
source ./scripts/git-aliases.sh
```

See `notes/parallel-workflow-plan.md` for the full workflow documentation.
