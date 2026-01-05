# Parallel Claude Workflow: Local + Cloud Integration Plan

## The Vision

Run Claude sessions in parallel across:
- **Local (Cursor)**: 3-4 Claude Code CLI sessions in terminal tabs
- **Cloud (claude.ai/code)**: Additional sessions running in browser
- **Mobile**: Check-ins and kick-offs from phone

All synchronized through **GitHub as the shared state layer**.

---

## Part 1: The Architecture

```
                    ┌─────────────────────────────────────────┐
                    │              LINEAR                      │
                    │  (Project Hub / Issue Tracker)          │
                    └──────────────┬──────────────────────────┘
                                   │
                                   ▼
                    ┌─────────────────────────────────────────┐
                    │              GITHUB                      │
                    │  (Shared State / Sync Layer)            │
                    │  - Branches = Work Streams              │
                    │  - CLAUDE.md = Context Handoff          │
                    │  - Commits = Checkpoints                │
                    └──────────────┬──────────────────────────┘
                                   │
          ┌────────────────────────┼────────────────────────┐
          │                        │                        │
          ▼                        ▼                        ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  CURSOR LOCAL   │    │  CLAUDE.AI WEB  │    │    VERCEL       │
│  (Development)  │    │  (Research/     │    │    (Deploy)     │
│                 │    │   Planning)     │    │                 │
│  Session 1: Arch│    │  Big picture    │    │  Auto-deploy    │
│  Session 2: Impl│    │  PRD creation   │    │  Preview URLs   │
│  Session 3: Test│    │  Code review    │    │                 │
│  Session 4: Debug│   │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
          │                        │                        │
          └────────────────────────┼────────────────────────┘
                                   │
                                   ▼
                    ┌─────────────────────────────────────────┐
                    │              SUPABASE                    │
                    │  (Backend / Database)                   │
                    └─────────────────────────────────────────┘
```

---

## Part 2: Session Types & Roles

### Local Sessions (Cursor Terminal)

| Session | Role | Focus | When to Use |
|---------|------|-------|-------------|
| **Architect** | Big picture | Codebase-wide changes, refactoring, planning | Starting new features, major restructuring |
| **Implementer** | Feature work | Writing new code, components, APIs | Active development on a specific feature |
| **Tester** | Quality | Writing tests, fixing test failures | After implementation, before merge |
| **Debugger** | Problem solving | Investigating issues, fixing bugs | When something breaks |

### Cloud Sessions (claude.ai/code)

| Session Type | Best For |
|--------------|----------|
| **Research** | Exploring unfamiliar territory, reading docs, comparing approaches |
| **PRD Creation** | The "interview" process to define requirements |
| **Code Review** | Fresh eyes on a branch before merging |
| **Handoff Prep** | Summarizing session state for local pickup |

---

## Part 3: The Handoff Protocol

### Handoff: Local → Cloud

**When**: You're leaving your desk but have active work
**Method**: Commit + Push + Context File

```bash
# 1. Commit current state
git add -A
git commit -m "WIP: [feature] - handoff to cloud

Current state:
- Completed: [list what's done]
- In progress: [what's partially done]
- Next: [what needs to happen next]
- Blockers: [any issues]
"

# 2. Push to feature branch
git push -u origin feature/[name]
```

Then on claude.ai/code:
1. Open the repo
2. Checkout the branch
3. Read CLAUDE.md for context
4. Continue work

### Handoff: Cloud → Local

**When**: Cloud session made progress, you're back at desk
**Method**: Cloud commits, local pulls

```bash
# On local
git fetch origin
git checkout feature/[name]
git pull origin feature/[name]

# Review what cloud session did
git log --oneline -10
git diff HEAD~3
```

### The CLAUDE.md Handoff File

Each project should have a `CLAUDE.md` at root that serves as the "state file":

```markdown
# CLAUDE.md - Session Context

## Current Sprint
[What we're building this sprint]

## Active Work Streams
- [ ] Feature A (branch: feature/a) - @local
- [ ] Feature B (branch: feature/b) - @cloud
- [ ] Bug fix C (branch: fix/c) - @local

## Last Session Summary
**Session**: Cloud / 2024-01-05 14:30
**Work Done**:
- Created auth flow scaffolding
- Set up Supabase client

**Next Steps**:
1. Implement login form component
2. Add session persistence
3. Test with real credentials

## Key Decisions Made
- Using Supabase Auth (not custom JWT)
- Session stored in cookies, not localStorage
- Magic link preferred over password

## Blockers / Questions
- Need API key for production Supabase
```

---

## Part 4: Branch Naming Convention

Structure branches for easy identification of ownership and purpose:

```
[type]/[linear-id]-[short-description]

Examples:
feature/LIN-123-user-auth
fix/LIN-456-login-redirect
experiment/LIN-789-new-ui-pattern
```

**Special branches for parallel work:**

```
feature/LIN-123-user-auth          # Main feature branch
feature/LIN-123-user-auth--frontend # Sub-stream: frontend
feature/LIN-123-user-auth--backend  # Sub-stream: backend
feature/LIN-123-user-auth--tests    # Sub-stream: tests
```

This lets multiple sessions work on the same feature without conflicts.

---

## Part 5: The Daily Flow

### Morning Startup (Local)

```bash
# 1. Check what happened overnight (if cloud sessions ran)
git fetch --all
git log --oneline --all --since="yesterday"

# 2. Review Linear for priorities
# (Use Linear MCP or open in browser)

# 3. Open terminal tabs for the day:
#    Tab 1: Architect session
#    Tab 2: Implementer session
#    Tab 3: Available for ad-hoc

# 4. Start first session
claude  # or your CLI command
```

### Mid-Day (Parallel Work)

**Local Tab 1** (Architect):
```
"Review the current architecture and identify any refactoring
needed before we add [new feature]. Update CLAUDE.md with findings."
```

**Local Tab 2** (Implementer):
```
"Implement the [component] as specified in Linear LIN-123.
Focus only on this component, don't refactor surrounding code."
```

**Cloud Session** (Research):
```
"Research best practices for [specific pattern] in our stack.
Create a summary in notes/research/[topic].md with recommendations."
```

### End of Day (Handoff)

```bash
# 1. Commit all work in progress
git add -A
git commit -m "EOD: [summary of day's work]"

# 2. Update CLAUDE.md with session state
# 3. Push all branches
git push --all
```

---

## Part 6: Integration Points

### Linear → GitHub

1. **Auto-link**: Branch names with `LIN-XXX` auto-link to Linear issues
2. **Status sync**: PR creation moves issue to "In Review"
3. **Auto-close**: Merged PRs close linked issues

### GitHub → Vercel

1. **Preview deploys**: Every push gets a preview URL
2. **Production**: Main branch auto-deploys
3. **Branch previews**: Test cloud work before merging

### GitHub → Supabase

1. **Migrations**: Track in `supabase/migrations/`
2. **Environment sync**: Use GitHub secrets for connection strings
3. **Branch DBs**: Consider Supabase branching for isolated testing

---

## Part 7: Quick Reference Commands

### Starting a Feature
```bash
# Create branch from Linear ID
git checkout -b feature/LIN-123-description

# Initialize CLAUDE.md context
echo "## Working on LIN-123: [title]" >> CLAUDE.md
```

### Syncing Between Sessions
```bash
# Quick sync (commit + push)
git add -A && git commit -m "sync: [quick note]" && git push

# Pull latest (on other session)
git pull origin $(git branch --show-current)
```

### Checking Parallel Progress
```bash
# See all active branches and their latest commits
git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short) - %(committerdate:relative) - %(subject)'
```

### Handoff Commit Template
```bash
git commit -m "handoff: [from] → [to]

State: [WIP/Ready for Review/Blocked]
Done:
- [item 1]
- [item 2]

Next:
- [item 1]
- [item 2]

Notes: [any context the next session needs]
"
```

---

## Part 8: Implementation Checklist

### Phase 1: Foundation
- [ ] Set up Linear ↔ GitHub integration
- [ ] Create branch naming convention documentation
- [ ] Create CLAUDE.md template
- [ ] Set up Vercel project with GitHub integration

### Phase 2: Workflow Files
- [ ] Create handoff commit message templates
- [ ] Create session startup scripts
- [ ] Set up git aliases for common operations

### Phase 3: Templates
- [ ] PRD interview prompt template
- [ ] Feature kickoff checklist
- [ ] Code review request template

### Phase 4: Automation
- [ ] Git hooks for branch naming validation
- [ ] Auto-update CLAUDE.md on commit
- [ ] Sync scripts for multi-session management

---

## Open Questions to Resolve

1. **Session persistence on cloud**: How to maintain context across claude.ai sessions?
   - Option A: Always commit state before closing
   - Option B: Use project files in repo as persistent memory

2. **Conflict resolution**: When local and cloud both edit same files?
   - Recommendation: Use sub-branches for parallel streams

3. **Mobile workflow**: What can realistically be done from phone?
   - GitHub app for PR reviews
   - Linear app for issue management
   - Claude app for quick questions/planning
   - Actual coding: probably just monitoring

4. **Ralph Wiggum / Autonomous mode**:
   - What's the actual plugin/feature being referenced?
   - How to safely run autonomous loops?
   - What guardrails are needed?

---

## Next Actions

1. Review this plan and flag anything that doesn't fit your actual workflow
2. Decide on the open questions above
3. Start with Phase 1 implementation
4. Test the handoff protocol with a real feature
