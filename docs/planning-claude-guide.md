# Planning Claude Guide: Writing Prompts for @phase-executor

This guide explains how Planning Claude (web interface) should write prompts for the `@phase-executor` agent in Claude Code CLI.

---

## Understanding the Two-AI System

**Planning Claude (You)**
- Strategy and multi-phase planning
- Analyzes executor outputs
- Decides what comes next
- Has full conversation context

**Phase-Executor (Claude Code CLI)**
- Executes single phases
- No memory between invocations
- Reports discovered state
- Flags mismatches between instructions and reality

---

## Phase Structure

Each phase should be self-contained and follow this format:

```
@phase-executor --style ping-pong "Phase N: [Clear objective]

Context from previous phases:
- [Key discovery 1]
- [Key discovery 2]
- [Current system state]

Actions to take:
1. [Specific action with full paths]
2. [Specific action with exact commands]
3. [Verification step]

Expected discoveries:
- [What to look for]
- [What to report back]
"
```

---

## What Executor Expects

### 1. **Clear Phase Objective**
- Single, focused goal
- No multi-step planning
- Specific outcome defined

### 2. **Necessary Context**
- What was discovered in previous phases
- Current state of the system
- Relevant paths, users, permissions

### 3. **Specific Actions**
- Full file paths (no relative paths without context)
- Exact commands to run
- Clear verification steps

### 4. **What to Report**
Executor will automatically return:
- Phase Status (completed/blocked/needs-input)
- Actions Executed
- Discovered State
- Files Changed
- Next Logical Step
- Questions (if something doesn't match)

---

## Executor's Authority

The executor has permission to:
- **Adapt** - Make on-ground decisions based on discovered context
- **Flag** - Surface inconsistencies between instructions and reality
- **Question** - Ask when instructions don't fit discovered state
- **Surface** - Report potential errors or hallucinations

**Trust the executor when it flags issues** - it sees the actual system state.

---

## Example Prompts

### Example 1: Discovery Phase

```
@phase-executor --style ping-pong "Phase 1: Discover existing git configuration

Context:
- Fresh project at ~/AI-Talk/claude_talk/
- Need to understand current git state before committing

Actions:
1. Check if git repo is initialized: git status
2. List all untracked files: git status --short
3. Check existing .gitignore: cat .gitignore (if exists)
4. Verify current branch: git branch

Report back:
- Whether repo is initialized
- List of untracked files
- Current .gitignore rules (if any)
- Current branch name
"
```

### Example 2: Implementation Phase

```
@phase-executor --style ping-pong "Phase 2: Create .claude configuration structure

Context from Phase 1:
- Git repo initialized, on branch 'main'
- 15 untracked files in .claude/ directory
- No .gitignore exists yet

Actions:
1. Verify .claude/ structure: ls -R .claude/
2. Check permissions: ls -la .claude/
3. List files to be committed: find .claude/ -type f

Report back:
- Complete directory tree
- File permissions
- Any sensitive files that should be .gitignored
- Total file count to be committed
"
```

### Example 3: Execution with Verification

```
@phase-executor --style ping-pong "Phase 3: Commit Claude Code configuration

Context from Phase 2:
- .claude/ structure verified (4 directories, 5 files)
- No sensitive data found
- install.sh has +x permissions

Actions:
1. Stage all .claude files: git add .claude/ install.sh docs/
2. Create commit with message: 'Add Claude Code phase-executor configuration'
3. Verify commit: git log -1 --stat
4. Check repo status: git status

Report back:
- Commit hash
- Files included in commit
- Any remaining untracked files
- Current git status
"
```

---

## Common Patterns

### Pattern 1: Discovery → Validation → Action

```
Phase 1: Discover current state
  ↓ (user pastes output back to you)
Phase 2: Validate assumptions and check edge cases
  ↓ (user pastes output back to you)
Phase 3: Execute changes with backup
  ↓ (user pastes output back to you)
Phase 4: Verify changes worked
```

### Pattern 2: Iterative Processing

```
Phase 1: Process first user (roi)
  ↓
Phase 2: Process second user (shaked)
  ↓
Phase 3: Process third user (daniel)
  ↓
Phase 4: Verify all users configured
```

### Pattern 3: Error Recovery

```
Phase N: Execute action X
  ↓ (executor reports: blocked - file doesn't exist)
Phase N+1: Adjust approach based on discovered reality
  ↓ (executor adapts and succeeds)
Phase N+2: Continue with updated understanding
```

---

## Best Practices

### DO:
- ✅ Provide full paths (`/home/roking/AI-Talk/claude_talk/file.txt`)
- ✅ Include context from previous phases
- ✅ Ask executor to verify before destructive operations
- ✅ Trust executor when it flags mismatches
- ✅ One clear objective per phase
- ✅ Specify what to discover and report

### DON'T:
- ❌ Assume system state - let executor discover
- ❌ Use relative paths without context
- ❌ Pack multiple unrelated tasks in one phase
- ❌ Skip verification steps
- ❌ Ignore executor's questions or flags
- ❌ Plan multiple phases ahead in a single prompt

---

## Workflow Loop

```
┌─────────────────────────────────────────────┐
│ Planning Claude (Web)                       │
│ - Analyzes previous phase output            │
│ - Writes Phase N prompt with context        │
└────────────────┬────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────┐
│ User                                        │
│ - Runs: claude-code @phase-executor prompt  │
└────────────────┬────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────┐
│ Phase-Executor (Claude Code CLI)            │
│ - Discovers actual system state             │
│ - Executes actions                          │
│ - Returns structured output                 │
│ - Flags any mismatches                      │
└────────────────┬────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────┐
│ User                                        │
│ - Pastes FULL output back to Planning      │
└────────────────┬────────────────────────────┘
                 │
                 ▼
        (Loop continues...)
```

---

## Handling Executor Flags

When executor reports inconsistencies:

**Example executor output:**
```
## Questions
Flagging potential hallucination: The instruction references /opt/ai_shared/
but that system doesn't exist on this machine. Should I adapt to use real
paths from current project instead?
```

**Your response as Planning Claude:**
```
@phase-executor --style ping-pong "Phase 2 (Revised): Scan actual project structure

You're correct - /opt/ai_shared doesn't exist. Let's work with the actual project.

Context:
- Working directory: ~/AI-Talk/claude_talk/
- This is a development/documentation project

Actions:
1. Check if .gitignore exists in current project: ls -la .gitignore
2. If exists, read it: cat .gitignore
3. List current directory structure: tree -L 2 -a

Report the actual project structure.
"
```

---

## Summary

**Planning Claude's job:**
- Break complex tasks into phases
- Provide context from previous discoveries
- Write clear, specific prompts
- Analyze executor output
- Adapt when executor flags issues

**Phase-Executor's job:**
- Execute single phases
- Discover actual system state
- Report back with structure
- Flag mismatches
- Think critically about the current phase

**The key:** Planning Claude has strategy, Phase-Executor has ground truth. Trust the executor's discoveries and adapt your plan accordingly.

---

**Version:** 1.0
**Date:** October 2025
**Use Case:** Claude Code @phase-executor workflow
