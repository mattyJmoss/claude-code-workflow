---
name: collab
description: >
  Orchestrates a two-agent debate for architectural and product decisions.
  Three phases: Frame (interactive), Debate (autonomous), Synthesize (Opus).
  Saves confirmed decisions to Open Brain and DECISIONS.md. Invoke with
  /collab followed by the question or topic.
user-invocable: true
---

# Collab — Two-Agent Decision Debate

You orchestrate a structured debate between two agent personas to help Matt
make architectural and product decisions. You are the orchestrator — you
manage the phases, dispatch agents, and synthesize the result.

## When to Use

Use `/collab` when there is **more than one defensible implementation path**.
If you already know what to build, just build it.

- "Should we use X or Y?" → `/collab`
- "What's the best approach for...?" → `/collab`
- "Fix the crash in..." → just do it
- "Add a button that..." → just do it

## Phase 0 — Frame (Interactive)

Before any agents spin up, have a conversation with Matt to frame the decision.

### What to establish:
1. **The actual question** — not a vague topic, but the specific decision
2. **Known constraints** — tech stack, timeline, compatibility, security
3. **Matt's initial lean** — "I'm thinking X but not sure about Y"
4. **Success criteria** — what "good" looks like
5. **Relevant files** — Matt points to them, you read them

### Ask clarifying questions until you can write this:

```markdown
## Decision Brief
**Question:** [The specific decision in one sentence]
**Constraints:** [Technical and product constraints]
**Matt's lean:** [His initial thinking, if any]
**Success criteria:** [What good looks like]
**Relevant code:** [File paths identified]
```

Keep the brief under 200 words. This is what both agents receive — it
prevents them from talking past each other.

### Gather context (before launching debate):

1. **Search Open Brain** for prior decisions related to this topic:
   - Use `mcp__open-brain__search_thoughts` with keywords from the question
   - Cap at **5 results**, present as **one-sentence summaries** each
   - Tag filter: look for `collab-decision` tagged thoughts first

2. **Read project memory** (already in your context via CLAUDE.md and rules):
   - `.claude/rules/conventions.md`, `security.md`, `performance.md`
   - If needed, read selective `.kilocode/rules/memory-bank/` files:
     `architecture.md`, `product.md`, `tech.md` (skip `context.md` and
     `tasks.md` — too large, low signal for decisions)

3. **Read scoped files** — only the files Matt identified in the brief.
   Do NOT read the full codebase. If agents need more, they can request
   up to 3 additional file reads each.

Support `--deep` flag: if present, use 3 debate rounds instead of 2.

## Phase 1 — Debate (Autonomous)

Run the debate loop. This is autonomous — no human input during the rounds.

### Round structure (2 rounds default, 3 with --deep):

For each round:

**Step A:** Launch Agent with `subagent_type: "general-purpose"` and the
`collab-product-architect` persona prompt. Provide:
- The decision brief
- Prior decisions from Open Brain (one-sentence summaries)
- Project context (constraints, conventions, relevant architecture)
- Contents of the scoped files
- The full debate transcript so far
- Instruction: "Give your take in ≤300 words. [If round 2+: Respond to
  the Staff Engineer's specific points.] End with AGREE or DISAGREE: [reason]."

**Step B:** Launch Agent with `subagent_type: "general-purpose"` and the
`collab-staff-engineer` persona prompt. Provide the same context PLUS
the Product Architect's response from Step A.

### Display each agent's response to Matt as it comes in.

### Convergence check:
After each round, check if BOTH agents ended with `AGREE`.
- Both `AGREE` → exit early, skip remaining rounds
- Either `DISAGREE` → continue to next round
- If token not found clearly → treat as `DISAGREE`, continue

## Phase 2 — Synthesize + Decide

You (the orchestrator, running on Opus) read the full transcript and produce:

```markdown
## Recommendation
[The consensus approach, or the stronger argument if they disagree]

## Key Agreements
- [What both agents aligned on]

## Open Disagreements
- [Product Architect thinks X, Staff Engineer thinks Y — Matt to decide]

## Decision Needed
[Specific question for Matt, if any]
```

Present this to Matt. Wait for his response.

## Post-Confirmation — Save the Decision

**ONLY save after Matt explicitly confirms** (says yes, approves, "go with
that", "let's do it", confirms the approach, etc.). Do NOT save if:
- Matt says "let me think about it"
- Matt asks follow-up questions (answer them, then wait for confirmation)
- The debate was exploratory without a clear decision

### When confirmed, dual-write:

**1. Open Brain:**
```
mcp__open-brain__capture_thought({
  text: "Decision: [one-sentence outcome]. Context: [what was being decided].
         Rationale: [why this approach won].",
  tags: ["collab-decision", "project:<project-name>"]
})
```

**2. DECISIONS.md** — append to the project's `DECISIONS.md` file:
```markdown
---

**Date:** [today's date, YYYY-MM-DD]
**Question:** [the decision brief question]
**Decision:** [the confirmed approach, one sentence]
**Rationale:** [why — 2-3 sentences max, capturing the key reasoning]
```

## Rules

- **Token discipline:** Each agent response ≤300 words. 2 rounds max
  (3 with `--deep`). Don't let the debate sprawl.
- **Matt arbitrates.** You present options and flag disagreements. Matt
  makes the call. Never auto-decide on his behalf.
- **Memory-first context.** Open Brain + project docs before file reads.
  File reads are verification, not discovery.
- **Ephemeral transcripts, permanent decisions.** Don't save the raw
  debate to Open Brain — only the confirmed decision.
- **No invented requirements.** Agents argue from the decision brief and
  actual codebase, not hypothetical future needs.
