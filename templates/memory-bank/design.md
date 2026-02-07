# Design System

> **When to create this file:** When your project has any UI. Fill it out as design decisions are made — you don't need everything upfront.
>
> **How to fill it out:** Extract tokens from your mockups, Figma files, or HTML prototypes. Every value should be a concrete number, not a description. If you're working from a designer's comp, pull the exact hex codes, font sizes, and spacing values. If you're designing as you go, define tokens early and reference them everywhere.
>
> **Tip:** Run the Design Director review (G4) against this file after filling it out. It will catch gaps and inconsistencies.

## Design Tokens

### Colors
<!-- List every color used in the app with its exact value and semantic name -->
<!-- Example:
| Token | Value | Usage |
|-------|-------|-------|
| `primary` | `#1a1a2e` | Main background |
| `accent` | `#e84a1b` | CTAs, active states, brand moments (limit to ≤4 contexts) |
| `textPrimary` | `#e8e0d4` | Body text, headings |
| `textSecondary` | `#666` | Hints, labels, metadata |
| `success` | `#4ade80` | Confirmation, completion |
| `danger` | `#ff4444` | Errors, destructive actions |
| `surface1` | `#1e1e2e` | Card backgrounds |
| `surface2` | `#2a2a3a` | Elevated surfaces |
| `border` | `#333` | Dividers, input borders |
-->

### Typography
<!-- Define the type scale — every text style used in the app -->
<!-- Example:
| Level | Font | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|------|--------|-------------|----------------|-------|
| `heading1` | Inter | 24px | Bold | 32px | -0.5px | Screen titles |
| `heading2` | Inter | 18px | SemiBold | 24px | 0 | Section headers |
| `body` | Inter | 14px | Regular | 20px | 0 | Main content |
| `caption` | Inter | 10px | Medium | 16px | 0.5px | Labels, hints |
| `mono` | JetBrains Mono | 12px | Regular | 18px | 0 | Code, data |
-->

### Spacing
<!-- Define the spacing scale — all spacing values should come from this list -->
<!-- Example:
| Token | Value | Usage |
|-------|-------|-------|
| `xs` | 4px | Tight gaps (icon-to-label) |
| `sm` | 8px | Related elements |
| `md` | 12px | Standard padding |
| `lg` | 16px | Section gaps |
| `xl` | 24px | Major sections |
| `xxl` | 32px | Screen-level padding |
-->

### Motion
<!-- Define animation tokens — durations, easing curves, springs -->
<!-- Example:
| Token | Value | Usage |
|-------|-------|-------|
| `fast` | 150ms | Micro-interactions (button press, toggle) |
| `normal` | 250ms | Standard transitions (fade, slide) |
| `slow` | 400ms | Emphasis transitions (overlay open/close) |
| `easeOut` | cubic-bezier(0.25, 0.46, 0.45, 0.94) | State changes (color, opacity) |
| `spring` | damping: 15, stiffness: 150 | Spatial movements (slides, bounces) |
-->

### Haptics
<!-- Define haptic feedback patterns — which actions trigger which haptic response -->
<!-- Example:
| Trigger | Haptic | API | Usage |
|---------|--------|-----|-------|
| Dial position snap | Selection | `Haptics.selectionAsync()` | Discrete position changes |
| Button press | Light impact | `Haptics.impactAsync(Light)` | Taps on interactive elements |
| Destructive action | Medium impact | `Haptics.impactAsync(Medium)` | Delete confirmation |
| Error | Notification error | `Haptics.notificationAsync(Error)` | Validation failure |
-->

### Audio
<!-- If applicable — define audio design tokens for sound effects, recording, playback -->
<!-- Example:
| Token | Value | Usage |
|-------|-------|-------|
| Recording codec | AAC 44.1kHz 128kbps | Voice messages |
| Playback mode | Speaker (not earpiece) | Default audio output |
| Effects chain | BiquadFilter → Compressor | Applied at playback only |

**Philosophy:** Record clean, apply effects at playback only. Never modify the source recording.
-->

## Component Inventory
<!-- List key components with their visual specs and states -->
<!-- For each component, define: default, hover/pressed, active, disabled, loading, error, empty states -->
<!-- Example:
### Button
- Height: 48px
- Border radius: 8px
- Font: `body` weight SemiBold
- States:
  - Default: `accent` background, white text
  - Pressed: darken 15%
  - Disabled: opacity 0.4, no pointer events
  - Loading: spinner replaces text, same dimensions
-->

## Platform Conventions
<!-- Which platform conventions to follow, and any intentional deviations -->
<!-- Example:
- **iOS:** Safe area insets respected on all screens. Touch targets ≥ 44pt.
- **Deviation:** Custom tab bar instead of UITabBar — justified by the walkie-talkie radio metaphor.
-->

## Implementation Notes
<!-- Platform-specific notes for translating design specs into code -->
<!-- Example:
- **Inset shadows:** React Native doesn't support `inset box-shadow`. Approximate with layered Views + opacity gradients.
- **Scanline overlays:** Use a semi-transparent PNG or SVG pattern overlay. Can be expensive on low-end Android — test performance.
- **Libraries:** `expo-linear-gradient` for gradients, `react-native-shadow-2` for drop shadows, `react-native-reanimated` for spring physics.
- **Web CSS equivalents:** `backdrop-filter: blur()` → `@react-native-community/blur` on native, CSS on web.
-->

## Design Decisions

| Decision | Choice | Rationale | Date |
|----------|--------|-----------|------|
