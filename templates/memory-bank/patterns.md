# Reusable UI Patterns

> **When to create this file:** After you've built 2-3 screens and notice shared components emerging. This is a living catalog — add components as they're extracted, not upfront.
>
> **How to fill it out:** Every time you extract a shared component (or realize you should), document it here. The format below captures what the Design Director needs to review: source path, visual specs, props, and usage rules.
>
> **Rule:** If you use a pattern more than once, extract it to a shared component. Duplicated styles = tech debt.
>
> **When to check this file:** Before building any new component, cross-check this catalog. If an existing pattern covers the use case, use it — don't create a new one. The Design Director (G4) will flag duplications.

> **Relationship to other files:** This file catalogs *what* components exist and their specs. `design.md` defines the tokens these components consume (colors, typography, spacing). `interaction.md` defines *when and how* components behave (validation timing, dismiss methods, feedback patterns).

---

## System Tokens

<!-- If your app has shared token objects (typography scales, color palettes, button/input style presets), document them here. These are the foundation that individual components reference. -->

<!-- Example:

### Typography Scale
| Token | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|--------|-------------|----------------|-------|
| `largeTitle` | 28px | Regular | 34px | -0.5 | Hero content |
| `headline` | 17px | SemiBold | 22px | 0 | Section emphasis |
| `body` | 15px | Regular | 20px | 0 | Primary content |
| `callout` | 13px | Regular | 18px | 0.3 | Menu items, labels |
| `caption` | 10px | Medium | 12px | 1.0 | Badges, metadata |

### Color Palette
| Token | Value | Contrast | Usage |
|-------|-------|----------|-------|
| `textPrimary` | `#FFFFFF` | 19.7:1 | Names, headings |
| `textMuted` | `#8A8A8A` | 4.9:1 | Hints, placeholders |
| `accent` | `#E84A1B` | 5.2:1 | CTAs, brand moments |
| `accentPressed` | `#C73E17` | — | Pressed state variant |
| `danger` | `#FF3B30` | — | Errors, destructive actions |
| `surfaceLight` | `#F0F0F2` | — | Light button backgrounds |

**Naming convention for state variants:** `{token}{State}` — e.g., `accentPressed`, `dangerShadow`, `surfaceLightShadow`.
-->

### Button Styles
<!-- Presets for primary, secondary, danger buttons. Include base + pressed + disabled states. -->

### Input Styles
<!-- Base input styling + modifiers (e.g., code input with wider letter spacing). -->

---

## Components

<!-- Template for adding components:

### ComponentName
**Source:** `path/to/file.tsx`

Brief description of what it does and when to use it.

| Property | Value |
|----------|-------|
| Height | 48px |
| Border radius | 8px |
| Background | `surface1` token |

**Props:**
- `title: string` — The display text
- `onPress: () => void` — Tap handler
- `variant?: 'primary' | 'secondary'` — Visual style (default: primary)
- `disabled?: boolean` — Grays out and prevents interaction

**States:**
- Default: normal appearance
- Pressed: darken 15%
- Disabled: opacity 0.4

**Usage rules:**
- Use for [specific context]. Don't use for [anti-pattern].
- Always pair with [related component] when [condition].

**Example:**
```tsx
<ComponentName title="Save" onPress={handleSave} />
```
-->

---

## Compositional Patterns

<!-- Document how components compose — which components wrap or contain others.
This prevents confusion about which component to use when.

Example:
- **OverlayBase** → contains → **OverlayHeader** (or **CloseButton** + **OverlayTitle**)
- **OverlayHeader** → provides → title + close button in a single row
- **MenuItem** → used inside → **SettingsOverlay**, **OptionsMenu**
- **ButtonStyles** → consumed by → any Pressable that needs consistent button appearance

When adding a new component, check: does it compose with existing patterns?
If yes, document the relationship here.
-->

---

## Completeness Checklist

<!-- For each pattern documented above, verify:
- [ ] Every color is a hex code or token reference (not "light blue")
- [ ] Every size is in px/pt or a token reference
- [ ] Every animation has a duration + easing function
- [ ] All states are specified (default, pressed, disabled, loading, error)
- [ ] Props are typed (string, boolean, enum values listed)
- [ ] Source path points to current file location
-->
