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

## Part 9: Ralph Wiggum - Autonomous Loops

Ralph Wiggum is an autonomous loop technique created by Geoffrey Huntley, heavily used by Boris Cherny (creator of Claude Code). It keeps Claude working on a task until completion criteria are met.

### The Core Concept

At its simplest, Ralph is a bash loop:
```bash
while true; do
  claude "Your task prompt here"
  # Loop continues until completion detected
done
```

The power comes from:
1. **Persistence**: Claude keeps iterating even when it thinks it's "done"
2. **Context accumulation**: Each iteration sees file changes from previous runs
3. **Clear completion criteria**: The loop only exits when success is verified

### Installation

Using the `ralph-claude-code` implementation:

```bash
# One-time global install
git clone https://github.com/frankbria/ralph-claude-code.git
cd ralph-claude-code
./install.sh

# Per-project setup
ralph-setup my-project
# or import existing requirements:
ralph-import requirements.md my-project
```

### Best Use Cases for Ralph

| Good for Ralph | Not Good for Ralph |
|----------------|-------------------|
| Large refactors (Jest → Vitest) | Exploratory work |
| Batch operations | Vague requirements |
| Test coverage gaps | Creative decisions |
| Framework migrations | Architecture design |
| Documentation generation | Debugging unclear bugs |

**The common thread**: Tasks with clear, verifiable completion criteria.

### Boris's Key Insight

> "Give Claude a way to verify its work. If Claude has that feedback loop, it will 2-3x the quality of the final result."

This means:
- Always include test commands in the prompt
- Define what "done" looks like explicitly
- Let Claude run tests/lints after each change

### Example Ralph Commands

```bash
# Basic usage
ralph "Migrate all tests from Jest to Vitest" --max-iterations 50

# With monitoring
ralph --monitor "Add TypeScript types to all JS files in src/"

# With custom completion criteria
ralph "Implement user authentication" \
  --completion-promise "All auth tests pass and login flow works"

# Rate-limited for cost control
ralph --calls 50 "Generate API documentation for all endpoints"
```

### Ralph Project Structure

Each Ralph-managed project gets:
```
project/
├── PROMPT.md       # The main task instructions
├── @fix_plan.md    # Prioritized task list (Ralph updates this)
├── @AGENT.md       # Build/run/test instructions
├── specs/          # Technical specifications
└── logs/           # Execution history
```

### Safety Guardrails

1. **Rate limiting**: Default 100 API calls/hour
2. **Circuit breaker**: Stops after 3 loops with no file changes
3. **Exit detection**: Recognizes "all tasks done" signals
4. **5-hour limit**: Prompts to wait or exit at API limits
5. **Timeout option**: `--timeout 30` for 30-minute max

### Integrating Ralph with Parallel Sessions

```
┌─────────────────────────────────────────────────────────┐
│                    YOUR WORKFLOW                         │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  Local Tab 1: Ralph Loop (autonomous)                   │
│    └─ "Migrate database schema" --monitor               │
│                                                          │
│  Local Tab 2: Manual Claude (interactive)               │
│    └─ Debugging, quick fixes, exploration               │
│                                                          │
│  Cloud Session: Planning/Review                         │
│    └─ PRD work, code review, research                   │
│                                                          │
│  Mobile: Monitoring                                      │
│    └─ Check Ralph progress, approve PRs                 │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

---

## Part 10: Mobile Workflow

Mobile is for **monitoring, triggering, and approving** - not full coding.

### What You Can Do From Phone

| App | Actions |
|-----|---------|
| **Claude App** | Start a planning session, kick off research, quick questions |
| **GitHub App** | Review PRs, approve merges, check CI status, read diffs |
| **Linear App** | Triage issues, update priorities, check progress |
| **Vercel App** | Check deploy status, view preview URLs |
| **Terminal (SSH)** | Trigger Ralph loops, check logs (advanced) |

### Mobile Trigger Patterns

**Pattern 1: Kick off overnight work**
1. Open Claude app on phone
2. Connect to repo
3. Start a Ralph loop: "Run test coverage and fill gaps"
4. Check progress in morning

**Pattern 2: Approve and merge from anywhere**
1. Get GitHub notification on phone
2. Review the diff in GitHub app
3. Approve and merge if looks good
4. Vercel auto-deploys

**Pattern 3: Quick unblock**
1. Get notification that CI failed
2. Open GitHub app, check the error
3. Open Claude app, describe the fix needed
4. Claude pushes the fix, CI reruns

### Mobile Session Start Template

When starting a session from mobile, use clear, contained prompts:

```
Connect to [repo]. Checkout branch [branch-name].

Read CLAUDE.md for context.

Your task: [specific, completable task]

When done:
1. Run tests to verify
2. Commit with message "[type]: [description]"
3. Push to origin
4. Update CLAUDE.md with what you did
```

---

## Part 11: Linear ↔ GitHub Integration Test

Since integration is already set up, verify it works:

### Test Checklist

- [ ] **Branch linking**: Create `feature/LIN-XXX-test`, verify it links in Linear
- [ ] **Status sync**: Create a PR, verify Linear issue moves to "In Review"
- [ ] **Auto-close**: Merge the PR, verify Linear issue closes
- [ ] **Comments sync**: Comment on PR, check if it appears in Linear (if enabled)

### Quick Test Script

```bash
# 1. Create a test issue in Linear, note the ID (e.g., LIN-999)

# 2. Create test branch
git checkout -b feature/LIN-999-integration-test

# 3. Make a small change
echo "# Integration Test" > test-integration.md
git add test-integration.md
git commit -m "test: verify Linear-GitHub integration"
git push -u origin feature/LIN-999-integration-test

# 4. Create PR via CLI
gh pr create --title "Test: Linear Integration" --body "Testing LIN-999 integration"

# 5. Check Linear - issue should show linked PR and move to "In Review"

# 6. Merge PR
gh pr merge --merge

# 7. Check Linear - issue should be closed

# 8. Cleanup
git checkout main
git branch -d feature/LIN-999-integration-test
git push origin --delete feature/LIN-999-integration-test
```

---

## Resolved Questions

1. **Session persistence on cloud**: ✅ Solved via CLAUDE.md - commit state before closing, next session reads it.

2. **Conflict resolution**: ✅ Use sub-branches (`feature/xxx--frontend`, `feature/xxx--backend`) for parallel streams.

3. **Mobile workflow**: ✅ Monitoring, triggering, approving - not full coding. Use Claude/GitHub/Linear apps.

4. **Ralph Wiggum**: ✅ Autonomous loop technique - see Part 9 above.

---

## Next Actions

1. Install Ralph: `git clone https://github.com/frankbria/ralph-claude-code.git && cd ralph-claude-code && ./install.sh`
2. Run the Linear ↔ GitHub test checklist above
3. Try a simple Ralph loop on a contained task
4. Test the mobile workflow with a real trigger

---

## Resources

- [Ralph Wiggum on Awesome Claude](https://awesomeclaude.ai/ralph-wiggum)
- [How Boris Uses Claude Code](https://paddo.dev/blog/how-boris-uses-claude-code/)
- [Ralph Claude Code GitHub](https://github.com/frankbria/ralph-claude-code)
- [Ralph Wiggum Technique Deep Dive](https://www.atcyrus.com/stories/ralph-wiggum-technique-claude-code-autonomous-loops)
