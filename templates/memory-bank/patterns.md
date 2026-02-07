# Reusable UI Patterns

> **When to create this file:** After you've built 2-3 screens and notice shared components emerging. This is a living catalog — add components as they're extracted, not upfront.
>
> **How to fill it out:** Every time you extract a shared component (or realize you should), document it here. The format below captures what the Design Director needs to review: source path, visual specs, props, and usage rules.
>
> **Rule:** If you use a pattern more than once, extract it to a shared component. Duplicated styles = tech debt.
>
> **When to check this file:** Before building any new component, cross-check this catalog. If an existing pattern covers the use case, use it — don't create a new one. The Design Director (G4) will flag duplications.

---

<!-- Template for adding components:

## ComponentName
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
