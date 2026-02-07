# Interaction Principles

> **When to create this file:** When your project has UI that responds to user actions — forms, navigation, overlays, feedback. This complements `design.md` (which covers *what things look like*) by defining *when and how things behave*.
>
> **How to fill it out:** Start with the sections most relevant to your app. You don't need all sections immediately — fill them in as you build features that need behavioral rules. The goal is to have a single source of truth so every screen behaves consistently.
>
> **Tip:** If you find yourself making the same interaction decision twice (e.g., "should this validate on blur or on submit?"), that's a sign it should be documented here.
>
> **Relationship to other files:** `design.md` defines *what things look like* (tokens, visual specs). This file defines *when and how things behave*. `patterns.md` catalogs the shared components that implement these behaviors. If you're unsure where something belongs: visual spec → `design.md`, behavioral rule → here, component API → `patterns.md`.

## Design System Scope
<!-- If your app has multiple design sub-systems (e.g., themed components vs. fixed system UI), declare them here.
This prevents mixing concerns — Claude will know which token set applies to which context. -->
<!-- Example:
1. **Skin System** (themed) — Device UI components (PTTButton, ChannelPlate, etc.). Tokens come from `lib/theme/skins/<skin>.ts`. Changes when user switches skins.
2. **System UI** (fixed) — Overlays, menus, settings. Uses DM Sans + fixed color palette from `systemUI.ts`. Does NOT change with skin switching.

**Rule:** Skin components read from `useTheme()`. System UI reads from `SystemColors`/`SystemTypography`. Never mix them.
-->

## Feedback Patterns
<!-- How does the app communicate state changes to the user? -->
<!-- Example:
- **Success:** Inline confirmation text (green, fades after 2s). No toast for expected actions.
- **Error:** Inline below the trigger element. Red text, persists until resolved.
- **Loading:** Skeleton screens for initial loads. Spinner for actions (button becomes spinner, same dimensions).
- **Empty state:** Illustration + single CTA. Never just blank space.
- **Destructive confirmation:** Alert dialog with explicit action name ("Delete Friend", not "OK").
-->

## Form Behavior
<!-- When and how do forms validate? What do error states look like? -->
<!-- Example:
- **Validation timing:** On blur for individual fields. On submit for cross-field rules.
- **Error display:** Inline below the field. Red border on the field. Error text in `caption` style.
- **Disabled state:** Opacity 0.4, no pointer events. Never gray out — use the opacity token.
- **Submit button:** Disabled until form is valid. Shows spinner during submission.
- **Keyboard:** `returnKeyType` matches context ("go" for single-field, "next" for multi-field, "done" for last field).
-->

## Navigation Model
<!-- How do screens and overlays transition? What are the dismiss methods? -->
<!-- Example:
- **Screen transitions:** Push (left-to-right slide) for drill-down. Modal (bottom-up slide) for actions.
- **Overlays:** Fade in backdrop (0.6 opacity black), content slides up with spring animation.
- **Dismiss methods:** Tap backdrop, swipe down, or close button. All three always available.
- **Entry animation:** 300ms spring (damping: 20, stiffness: 200).
- **Exit animation:** 200ms ease-out.
- **Back behavior:** Hardware back / swipe-back always returns to previous screen. Never trap the user.
-->

## Empty States
<!-- What does the user see when there's no data? -->
<!-- Example:
- **Lists with no items:** Centered illustration + descriptive text + primary CTA.
  - Friends list empty: "No friends yet" + "Add Friend" button.
  - Messages empty: "No messages" + subtle prompt text.
- **First-run:** Guide the user to the first meaningful action. Don't just show empty screens.
- **Error-empty:** If the list is empty because of an error, show the error — not the empty state.
-->

## Platform-Specific Behavior
<!-- Which platform conventions to follow and any intentional deviations -->
<!-- Example:
- **iOS:** Respect safe areas. Use haptic feedback for meaningful interactions (success, selection change). Support Dynamic Type where feasible.
- **Android:** Material back gesture. System navigation bar theming.
- **Deviations:** Custom overlay dismiss (swipe down) instead of system modal — justified by full-screen radio metaphor.
-->

## Interaction Decisions

<!-- Track behavioral decisions so they don't get relitigated. -->

| Decision | Choice | Rationale | Date |
|----------|--------|-----------|------|
<!-- Example:
| Form validation timing | On submit, not on blur | "Validation while typing feels like the user made a mistake before they're done" | 2026-01-15 |
| Overlay stacking | Replace, never stack | Radio metaphor — one screen at a time, like physical device | 2026-01-20 |
| Keyboard avoidance | KeyboardAvoidingView + ScrollView | Standard RN pattern, works cross-platform | 2026-02-07 |
-->
