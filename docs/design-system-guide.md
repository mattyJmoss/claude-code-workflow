# Filling Out the Design System Files

The design system lives across three optional memory bank files. You don't need all three — start with `design.md` and add the others as your project matures.

## The Three Files

| File | What It Covers | When to Create |
|------|---------------|----------------|
| `design.md` | Visual specs — colors, typography, spacing, motion tokens | When you have any UI |
| `interaction.md` | Behavioral rules — how things respond to user actions | When you have forms, overlays, navigation |
| `patterns.md` | Reusable component catalog — shared components with specs | After 2-3 screens, when shared patterns emerge |

## `design.md` — Visual Specs

This is your visual source of truth. Every color, font size, spacing value, and animation timing lives here.

### How to fill it out

**If you have a Figma file or mockup:**
1. Open the design file
2. Extract every unique color → put in Colors table
3. Extract the type scale (font, size, weight, line-height) → put in Typography table
4. Identify the spacing grid (usually 4px or 8px base) → put in Spacing table
5. Note any animations or transitions → put in Motion table

**If you're designing as you go:**
1. Pick a color palette (accent + neutrals + semantics) and commit to it
2. Define 4-5 type levels (heading, subheading, body, caption, mono)
3. Pick a spacing scale (recommended: 4, 8, 12, 16, 24, 32)
4. Define 2-3 motion durations (fast, normal, slow)

**What the Design Director checks:**
- Every value in code matches a token in this file
- Accent color is used in ≤ 4 contexts
- Font weights are limited to 2 per screen
- Spacing values come from the scale (no arbitrary values)

### Example (minimal)

```markdown
### Colors
| Token | Value | Usage |
|-------|-------|-------|
| `background` | `#0a0a0a` | App background |
| `surface` | `#1a1a1a` | Cards, overlays |
| `accent` | `#3b82f6` | Primary CTA, active states |
| `text` | `#e5e5e5` | Body text |
| `textMuted` | `#666` | Labels, hints |
| `danger` | `#ef4444` | Errors, destructive |
| `success` | `#22c55e` | Confirmations |

### Typography
| Level | Font | Size | Weight | Line Height |
|-------|------|------|--------|-------------|
| `h1` | Inter | 24px | Bold | 32px |
| `body` | Inter | 14px | Regular | 20px |
| `caption` | Inter | 10px | Medium | 16px |

### Spacing
4px grid: xs=4, sm=8, md=12, lg=16, xl=24, xxl=32
```

---

## `interaction.md` — Behavioral Rules

This covers *when and how* things behave — complementing `design.md` which covers *what things look like*.

### How to fill it out

For each section, ask yourself these questions:

**Feedback Patterns:**
- How does the app show success? (Toast? Inline text? Haptic?)
- How does it show errors? (Inline below the trigger? Modal? Banner?)
- How long do messages persist? (Auto-dismiss after 2s? Persist until dismissed?)

**Form Behavior:**
- When does validation happen? (On blur? On submit? Real-time?)
- What do disabled elements look like? (Opacity value? Different color?)
- Where do error messages appear? (Below the field? Toast?)

**Navigation:**
- How do screens transition? (Push? Modal? Fade?)
- How are overlays dismissed? (Tap backdrop? Swipe down? Close button? All three?)
- What are the animation durations?

**Empty States:**
- What does the user see when there's no data?
- Is there a CTA to guide them?

### When to update

Update this file when you find yourself making the same behavioral decision on a second screen. If you debated "should this validate on blur or submit?" — document the answer here so every future form is consistent.

---

## `patterns.md` — Component Catalog

This is a living inventory of shared components. It prevents duplication and gives the Design Director something concrete to review against.

### How to fill it out

**Don't fill it out upfront.** This file grows organically:

1. You build Screen A with a custom button
2. You build Screen B and need a similar button
3. You extract the button into a shared component
4. You document it in `patterns.md`

For each component, capture:
- **Source path** — where the code lives
- **Visual specs** — height, radius, colors (reference design.md tokens)
- **Props** — what it accepts
- **States** — default, pressed, disabled, loading
- **Usage rules** — when to use it and when NOT to

### When the Design Director checks this

During G4 (UI code review), the Design Director will:
1. Check if the new component duplicates anything in `patterns.md`
2. If it does → flag it ("Use the existing `MenuItem` component instead")
3. If it's genuinely new → suggest adding it to `patterns.md`

### Example entry

```markdown
## OverlayTitle
**Source:** `lib/overlays/OverlayBase.tsx`

Standardized title for overlay screens. Uppercase, tracked, centered.

| Property | Value |
|----------|-------|
| Font | JetBrains Mono SemiBold |
| Size | 11px |
| Letter spacing | 2px |
| Text transform | uppercase |
| Margin bottom | 32px (center-justified) / 24px (top-justified) |

**Props:**
- `children: string` — The title text
- `color?: 'orange' | 'green' | 'white'` — Accent color (default: orange)

**Usage rules:**
- Use for every overlay title. No exceptions.
- Color matches the overlay's semantic meaning (orange = action, green = incoming request).
```

---

## The Design Director Connection

These three files are what the Design Director persona references during reviews:

| Review Gate | Files Referenced | What's Checked |
|-------------|-----------------|----------------|
| G2 (UI ticket planning) | `design.md`, `interaction.md` | Are acceptance criteria consistent with the design system? |
| G4 (UI code review) | All three | Do token values match? Is behavior consistent? Are components reused? |

If the Design Director finds a contradiction between code and these files, it will flag it explicitly. If the design system itself needs to evolve, it proposes the change rather than silently deviating.

---

## Quick Start

1. Copy the templates from `templates/memory-bank/` into your project's `.kilocode/rules/memory-bank/`
2. Start with `design.md` — define your color palette, type scale, and spacing grid
3. Add `interaction.md` when you build your first form or overlay
4. Add `patterns.md` after you extract your first shared component
5. Run a G4 review to validate your design system docs against the actual code
