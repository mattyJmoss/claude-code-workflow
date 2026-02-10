Set up the design system spec for this project. This captures interaction principles with reasoning — the "taste layer" that components can't encode.

Run this command whenever you're ready — at project start, after you've built some UI, or when bringing in a Figma design. The timing is flexible.

---

## For a new project (from scratch)

Create or update `.kilocode/rules/memory-bank/interaction.md` by asking me about:

**Interaction Philosophy:**
- What should the user always feel in control of?
- What should the system handle automatically?
- When should we slow users down vs. get out of their way?

**Feedback Patterns:**
- How should success be communicated? (Toast, inline, sound, haptic?)
- How should errors be communicated? (Modal, inline, persist or auto-dismiss?)
- How should loading states work? (Skeleton, spinner, optimistic?)

**Form Behavior:**
- When should validation happen? (On blur, on submit, while typing?)
- How should errors display? (Inline, summary, both?)
- What about keyboard behavior? (Return key types, focus management)

**Navigation Model:**
- Modal vs. push vs. inline for different actions?
- How do overlays dismiss? (Backdrop tap, swipe, close button?)
- What are the animation patterns?

For each decision, capture the **behavior AND the rationale**. Not "validate on blur" but "validate after focus leaves, not while typing — red text before they're done typing feels like they've made a mistake."

---

## For an existing project (audit mode)

Analyze this codebase and draft interaction principles based on what's already there.

Focus on HOW the UI behaves, not WHAT components exist:

1. **Feedback patterns** — How do we communicate success, errors, loading? Toasts, inline, modals?
2. **Form behavior** — Validation timing, error display, save behavior?
3. **Navigation patterns** — Modals vs. inline? How do overlays dismiss?
4. **Empty/edge states** — What happens when there's no data?
5. **Destructive actions** — Confirmation patterns?

For each pattern found, report:
- What the current behavior is (with file/component examples)
- Whether it seems intentional and consistent, or accidental/inconsistent
- A proposed principle statement if it should be codified

Format output as a draft `interaction.md` with:
- **Principles that ARE consistent** — document these
- **Principles that SHOULD BE consistent but aren't** — flag for decision
- **Gaps where no clear pattern exists** — flag for decision

After the audit, ask me which findings to codify as principles.

---

## The Taste Layer Philosophy

Every principle in interaction.md should follow the pattern:

**Behavior:** What happens
**Rationale:** Why it should happen this way

Bad: "Validate on blur"
Good: "Validate after focus leaves, not while typing. Red text before they're done typing feels like they've made a mistake."

The rationale helps AI extrapolate to new situations. When a new interaction question comes up, check if existing rationale applies before inventing something new.

This is a living document. Update it as you build.

---

The argument (optional) specifies mode: **$ARGUMENTS**
- No argument or "new" → from scratch (conversational)
- "audit" → analyze existing codebase
