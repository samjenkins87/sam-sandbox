# Linear UI Design Review & Guidelines for Creative Studio OS

## Executive Summary

This document provides a comprehensive analysis of Linear's UI design system to inform the development of the Pitchback CreativeOS platform. Linear represents the gold standard in modern SaaS application design - clean, professional, and highly functional. This review extracts actionable design patterns and specifications that can be applied using AlignUI Pro components.

---

## 1. Core Design Philosophy

### 1.1 Design Principles

Linear's design philosophy centers on several key principles:

1. **Minimal Chrome, Maximum Content**: UI elements (borders, backgrounds, controls) are subdued to let content breathe
2. **Professional Restraint**: No unnecessary decoration, every element serves a purpose
3. **Keyboard-First**: Every action accessible via keyboard shortcuts
4. **Density Without Clutter**: High information density achieved through careful spacing and typography
5. **Consistency Over Novelty**: Predictable patterns across all screens

### 1.2 Visual Hierarchy Strategy

Linear establishes hierarchy through:
- **Typography weight** (not size variation)
- **Subtle background elevation** (not shadows)
- **Color saturation** (muted vs. accent colors)
- **Spacing rhythm** (consistent padding scale)

---

## 2. Layout Architecture

### 2.1 Three-Panel Layout

Linear uses a **three-panel layout** that is central to its UX:

```
┌─────────────────────────────────────────────────────────────────┐
│ HEADER (optional - workspace switcher, search, user)            │
├──────────┬────────────────────────────────┬─────────────────────┤
│          │                                │                     │
│  LEFT    │         MAIN CONTENT           │     RIGHT           │
│  SIDEBAR │           AREA                 │     PANEL           │
│  (nav)   │                                │   (properties/      │
│          │                                │    context)         │
│  180-    │        Flexible width          │     280-320px       │
│  220px   │        (min: 400px)            │                     │
│          │                                │                     │
└──────────┴────────────────────────────────┴─────────────────────┘
```

### 2.2 Panel Specifications

#### Left Sidebar (Navigation)
- **Width**: 180-220px (collapsible to icon-only ~48px)
- **Background**: Slightly elevated from main content
- **Contains**:
  - Workspace/team switcher at top
  - Primary navigation sections (Inbox, My Issues, Pulse)
  - Workspace navigation (Initiatives, Projects, Views)
  - Team sections with expandable sub-navigation
  - Favorites section
  - "Try" section for discovery features

#### Main Content Area
- **Width**: Flexible, fills remaining space
- **Minimum**: 400px
- **Contains**: Primary content (lists, details, editors)
- **Header**: Tab navigation (Overview, Updates, Issues) with action buttons

#### Right Panel (Properties/Context)
- **Width**: 280-320px
- **Background**: Same as main content or slightly elevated
- **Contains**:
  - Properties (Status, Priority, Assignee, Dates)
  - Progress tracking
  - Activity feed
  - Related items

### 2.3 Responsive Behavior

- Right panel collapses first on narrow viewports
- Left sidebar collapses to icon-only mode
- Main content takes priority
- Keyboard shortcut `[` toggles sidebar collapse

---

## 3. Color System

### 3.1 Light Mode Palette

```css
/* Light Mode - Primary Surfaces */
--background-primary: #FFFFFF;          /* Main content background */
--background-secondary: #FAFAFA;        /* Sidebar, elevated panels */
--background-tertiary: #F5F5F5;         /* Hover states, cards */
--background-elevated: #FFFFFF;         /* Modals, dropdowns */

/* Light Mode - Text */
--text-primary: #1A1A1A;                /* Headlines, primary text */
--text-secondary: #6B6B6B;              /* Secondary labels, descriptions */
--text-tertiary: #9B9B9B;               /* Placeholder, disabled text */
--text-on-accent: #FFFFFF;              /* Text on colored backgrounds */

/* Light Mode - Borders & Dividers */
--border-primary: #E5E5E5;              /* Main borders */
--border-secondary: #EFEFEF;            /* Subtle dividers */
--border-focus: #5E6AD2;                /* Focus rings */

/* Light Mode - Status Colors */
--status-in-progress: #F2C94C;          /* Yellow/amber for in progress */
--status-completed: #6FCF97;            /* Green for completed */
--status-cancelled: #EB5757;            /* Red for cancelled */
--status-backlog: #828282;              /* Gray for backlog */

/* Light Mode - Accent (CRISP AZURE - replaces Linear purple) */
--accent-primary: #3B82F6;              /* Primary brand color - Blue-500 */
--accent-hover: #2563EB;                /* Hover state - Blue-600 */
--accent-light: #60A5FA;                /* Light variant - Blue-400 */
--accent-subtle: rgba(59, 130, 246, 0.10);  /* Light accent background */
```

### 3.2 Dark Mode Palette

```css
/* Dark Mode - CRISP AZURE GRAPHITE THEME */
/* Primary Surfaces - Deep Graphite */
--background-primary: #0B0F14;          /* Deepest graphite - main background */
--background-secondary: #14181F;        /* Sidebars, cards, panels */
--background-tertiary: #1E293B;         /* Elevated surfaces */
--background-elevated: #14181F;         /* Modals, dropdowns */
--background-hover: #1E293B;            /* Hover states */

/* Dark Mode - Text */
--text-primary: #E5E7EB;                /* Gray-200 - High legibility */
--text-secondary: #94A3B8;              /* Slate-400 - Muted text */
--text-tertiary: #64748B;               /* Slate-500 - Placeholder, disabled */
--text-on-accent: #FFFFFF;              /* Text on colored backgrounds */

/* Dark Mode - Borders & Dividers */
--border-primary: #27272A;              /* Zinc-800 - Subtle structure */
--border-secondary: #1F1F1F;            /* Even subtler */
--border-focus: #3B82F6;                /* Focus rings - Azure */

/* Dark Mode - Status Colors */
--status-in-progress: #EAB308;          /* Yellow-500 */
--status-completed: #22C55E;            /* Green-500 */
--status-cancelled: #EF4444;            /* Red-500 */
--status-backlog: #6B6B6B;

/* Dark Mode - Accent (CRISP AZURE) */
--accent-primary: #3B82F6;              /* Blue-500 - Primary brand */
--accent-hover: #60A5FA;                /* Blue-400 - Hover/light variant */
--accent-foreground: #60A5FA;           /* Text on accent backgrounds */
--accent-subtle: rgba(59, 130, 246, 0.15);  /* Selection backgrounds */

/* Azure Glow Effects */
--azure-focus-ring: 0 0 0 3px rgba(59, 130, 246, 0.35);
--azure-glow: 0 0 24px rgba(59, 130, 246, 0.25);
```

### 3.3 Color Usage Rules

1. **Accent colors are used sparingly** - Only for interactive elements, selection states, and key actions
2. **Status colors are consistent** - Same meaning across light/dark modes
3. **Surfaces use subtle elevation** - Background colors step up slightly for layered elements
4. **Text contrast is high** - Always meet WCAG AA standards minimum

---

## 4. Typography System

### 4.1 Font Stack

```css
/* Primary Font */
--font-primary: "Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;

/* Display Font (for larger headings) */
--font-display: "Inter Display", "Inter", -apple-system, sans-serif;

/* Monospace (for code, IDs) */
--font-mono: "SF Mono", "Fira Code", "Consolas", monospace;
```

### 4.2 Type Scale

```css
/* Size Scale */
--text-xs: 11px;      /* Metadata, timestamps */
--text-sm: 12px;      /* Secondary labels, captions */
--text-base: 13px;    /* Body text, list items - LINEAR'S DEFAULT */
--text-md: 14px;      /* Emphasized body text */
--text-lg: 16px;      /* Section headers */
--text-xl: 18px;      /* Page titles */
--text-2xl: 24px;     /* Large headings */
--text-3xl: 32px;     /* Hero headings */

/* Line Heights */
--leading-tight: 1.2;
--leading-normal: 1.5;
--leading-relaxed: 1.6;

/* Font Weights */
--font-normal: 400;
--font-medium: 500;
--font-semibold: 600;
--font-bold: 700;
```

### 4.3 Typography Patterns

| Element | Size | Weight | Color |
|---------|------|--------|-------|
| Page Title | 18-20px | 600 | text-primary |
| Section Header | 13px | 600 | text-primary |
| Body Text | 13px | 400 | text-primary |
| Secondary Text | 12-13px | 400 | text-secondary |
| Labels | 11-12px | 500 | text-secondary |
| Metadata | 11px | 400 | text-tertiary |
| Button Text | 13px | 500 | varies |
| Nav Item | 13px | 400/500 | text-secondary/primary |

### 4.4 Key Typography Insight

**Linear uses 13px as their base font size**, not the typical 14px or 16px. This allows for higher information density while maintaining readability with Inter's excellent legibility at small sizes.

---

## 5. Spacing System

### 5.1 Spacing Scale

```css
/* Base unit: 4px */
--space-0: 0px;
--space-1: 4px;       /* Tight spacing, icon gaps */
--space-2: 8px;       /* Between related elements */
--space-3: 12px;      /* Standard padding */
--space-4: 16px;      /* Section spacing */
--space-5: 20px;      /* Large section gaps */
--space-6: 24px;      /* Page margins */
--space-8: 32px;      /* Major section breaks */
--space-10: 40px;     /* Large whitespace */
--space-12: 48px;     /* Page-level spacing */
```

### 5.2 Common Spacing Patterns

```css
/* Sidebar */
--sidebar-padding-x: 12px;
--sidebar-item-padding: 8px 12px;
--sidebar-section-gap: 16px;

/* Main Content */
--content-padding: 24px;
--content-max-width: 1200px;

/* Cards & Panels */
--card-padding: 16px;
--card-gap: 12px;

/* List Items */
--list-item-padding: 8px 12px;
--list-item-gap: 1px;  /* Very tight list spacing */

/* Form Elements */
--input-padding: 8px 12px;
--form-gap: 16px;
```

---

## 6. Component Specifications

### 6.1 Navigation Components

#### Sidebar Navigation Item
```css
.nav-item {
  padding: 6px 12px;
  border-radius: 6px;
  font-size: 13px;
  font-weight: 400;
  color: var(--text-secondary);
  transition: background-color 0.1s ease;
}

.nav-item:hover {
  background-color: var(--background-hover);
  color: var(--text-primary);
}

.nav-item.active {
  background-color: var(--accent-subtle);
  color: var(--text-primary);
  font-weight: 500;
}

.nav-item-icon {
  width: 16px;
  height: 16px;
  margin-right: 8px;
  opacity: 0.7;
}
```

#### Section Header
```css
.sidebar-section-header {
  padding: 8px 12px;
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  color: var(--text-tertiary);
}
```

### 6.2 Buttons

#### Primary Button
```css
.btn-primary {
  padding: 6px 12px;
  border-radius: 6px;
  font-size: 13px;
  font-weight: 500;
  background-color: var(--accent-primary);
  color: white;
  border: none;
  transition: background-color 0.15s ease;
}

.btn-primary:hover {
  background-color: var(--accent-hover);
}
```

#### Secondary Button
```css
.btn-secondary {
  padding: 6px 12px;
  border-radius: 6px;
  font-size: 13px;
  font-weight: 500;
  background-color: transparent;
  color: var(--text-primary);
  border: 1px solid var(--border-primary);
}

.btn-secondary:hover {
  background-color: var(--background-tertiary);
}
```

#### Ghost Button
```css
.btn-ghost {
  padding: 6px 12px;
  border-radius: 6px;
  font-size: 13px;
  font-weight: 500;
  background-color: transparent;
  color: var(--text-secondary);
  border: none;
}

.btn-ghost:hover {
  background-color: var(--background-tertiary);
  color: var(--text-primary);
}
```

### 6.3 Cards & Panels

#### Standard Card
```css
.card {
  background-color: var(--background-primary);
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  padding: 16px;
}

/* Dark mode adjustment */
.dark .card {
  background-color: var(--background-tertiary);
  border-color: var(--border-secondary);
}
```

#### Property Panel Item
```css
.property-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 0;
  border-bottom: 1px solid var(--border-secondary);
}

.property-label {
  font-size: 12px;
  color: var(--text-secondary);
  min-width: 100px;
}

.property-value {
  font-size: 13px;
  color: var(--text-primary);
}
```

### 6.4 Status Badges

```css
.status-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
}

.status-badge-in-progress {
  background-color: rgba(242, 201, 76, 0.15);
  color: #F2C94C;
}

.status-badge-completed {
  background-color: rgba(111, 207, 151, 0.15);
  color: #6FCF97;
}

.status-badge-on-track {
  background-color: rgba(111, 207, 151, 0.15);
  color: #6FCF97;
}
```

### 6.5 Input Fields

```css
.input {
  width: 100%;
  padding: 8px 12px;
  font-size: 13px;
  border: 1px solid var(--border-primary);
  border-radius: 6px;
  background-color: var(--background-primary);
  color: var(--text-primary);
  transition: border-color 0.15s ease, box-shadow 0.15s ease;
}

.input:focus {
  outline: none;
  border-color: var(--accent-primary);
  box-shadow: 0 0 0 3px var(--accent-subtle);
}

.input::placeholder {
  color: var(--text-tertiary);
}
```

### 6.6 Tables & Lists

#### Issue List Item
```css
.issue-row {
  display: flex;
  align-items: center;
  padding: 8px 16px;
  border-bottom: 1px solid var(--border-secondary);
  transition: background-color 0.1s ease;
}

.issue-row:hover {
  background-color: var(--background-hover);
}

.issue-priority-icon {
  width: 16px;
  height: 16px;
  margin-right: 12px;
}

.issue-id {
  font-size: 12px;
  font-family: var(--font-mono);
  color: var(--text-tertiary);
  margin-right: 12px;
  min-width: 60px;
}

.issue-title {
  font-size: 13px;
  color: var(--text-primary);
  flex: 1;
}

.issue-meta {
  font-size: 12px;
  color: var(--text-secondary);
  display: flex;
  gap: 16px;
}
```

---

## 7. Icons & Visual Elements

### 7.1 Icon Specifications

- **Size**: 16px default, 20px for emphasis, 12px for inline
- **Stroke width**: 1.5px (consistent across all icons)
- **Style**: Outlined/line icons, not filled
- **Color**: Inherits from text color, usually text-secondary
- **Opacity**: Often 0.6-0.8 for secondary icons

### 7.2 Icon Library Reference

Linear uses a custom icon set with these characteristics:
- Clean geometric shapes
- Consistent 16x16 grid
- Rounded corners (2px radius)
- Single color (no multi-color icons)

**Recommended icon sets for similar aesthetic:**
- Lucide Icons (open source, very Linear-like)
- Heroicons (outline variant)
- Tabler Icons

### 7.3 Avatars

```css
.avatar {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  object-fit: cover;
}

.avatar-sm { width: 16px; height: 16px; }
.avatar-md { width: 24px; height: 24px; }
.avatar-lg { width: 32px; height: 32px; }
```

---

## 8. Motion & Transitions

### 8.1 Timing Functions

```css
/* Standard easing */
--ease-default: cubic-bezier(0.4, 0, 0.2, 1);
--ease-in: cubic-bezier(0.4, 0, 1, 1);
--ease-out: cubic-bezier(0, 0, 0.2, 1);
--ease-spring: cubic-bezier(0.34, 1.56, 0.64, 1);
```

### 8.2 Duration Scale

```css
--duration-fast: 100ms;    /* Micro-interactions, hover states */
--duration-normal: 150ms;  /* Standard transitions */
--duration-medium: 200ms;  /* Panel transitions */
--duration-slow: 300ms;    /* Page transitions, modals */
```

### 8.3 Common Transitions

```css
/* Hover states */
transition: background-color 0.1s ease;

/* Focus states */
transition: border-color 0.15s ease, box-shadow 0.15s ease;

/* Panel expand/collapse */
transition: width 0.2s ease-out;

/* Modal/dialog appearance */
transition: opacity 0.15s ease, transform 0.2s ease-out;
```

### 8.4 Animation Principles

1. **Subtle over dramatic**: Animations should be barely noticeable
2. **Fast response**: No animation should delay user interaction
3. **Purpose-driven**: Only animate when it aids understanding
4. **Performance first**: Use transform/opacity, avoid layout shifts

---

## 9. Responsive Design

### 9.1 Breakpoints

```css
/* Linear's approximate breakpoints */
--bp-sm: 640px;   /* Mobile */
--bp-md: 768px;   /* Tablet */
--bp-lg: 1024px;  /* Desktop */
--bp-xl: 1280px;  /* Large desktop */
--bp-2xl: 1536px; /* Extra large */
```

### 9.2 Responsive Behavior

| Breakpoint | Left Sidebar | Main Content | Right Panel |
|------------|--------------|--------------|-------------|
| < 768px | Hidden (hamburger) | Full width | Hidden |
| 768-1024px | Collapsed (icons) | Expanded | Hidden or overlay |
| 1024-1280px | Full width | Flexible | Collapsible |
| > 1280px | Full width | Flexible | Always visible |

---

## 10. Dark/Light Mode Implementation

### 10.1 Mode Detection

```css
/* System preference detection */
@media (prefers-color-scheme: dark) {
  :root {
    /* Dark mode variables */
  }
}

/* Manual toggle via class */
.dark {
  /* Dark mode variables */
}
```

### 10.2 Theme Toggle Best Practices

1. **Default to light mode** (as specified by user requirement)
2. **Persist user preference** in localStorage
3. **Smooth transition** between modes (0.2s on background-color)
4. **Avoid flash** by setting theme class before paint
5. **Respect system preference** as initial default option

### 10.3 Contrast Requirements

| Element | Light Mode | Dark Mode |
|---------|------------|-----------|
| Primary text | 7:1 minimum | 7:1 minimum |
| Secondary text | 4.5:1 minimum | 4.5:1 minimum |
| Interactive elements | 3:1 minimum | 3:1 minimum |
| Focus indicators | 3:1 minimum | 3:1 minimum |

---

## 11. AlignUI Component Mapping

### 11.1 Core Component Mappings

| Linear Component | AlignUI Equivalent | Customization Needed |
|-----------------|-------------------|---------------------|
| Sidebar | SideNavigation | Adjust padding, colors |
| Navigation Item | NavItem/LinkButton | Custom active states |
| Primary Button | Button (primary) | Reduce padding, 6px border-radius |
| Card | Card | Reduce border-radius to 8px |
| Input Field | Input | Adjust sizing to 13px font |
| Badge | Badge | Custom status colors |
| Avatar | Avatar | Linear sizes (16-32px) |
| Dropdown | Select/Dropdown | Match Linear styling |
| Modal/Dialog | Dialog | Adjust backdrop, sizing |
| Table | DataTable | Custom row styling |

### 11.2 Customization Guidelines

When using AlignUI components for a Linear-like design:

1. **Reduce border-radius**: AlignUI defaults are often rounder
2. **Adjust font sizes**: Use 13px base instead of 14px
3. **Mute colors**: Desaturate accent colors slightly
4. **Tighten spacing**: Linear uses tighter spacing than most systems
5. **Simplify shadows**: Use elevation via background color, not shadows

---

## 12. Key Differentiators to Implement

### 12.1 What Makes Linear Feel "Linear"

1. **The subtle color palette** - Everything is slightly muted/desaturated
2. **Tight but balanced spacing** - Dense but not cramped
3. **Consistent 6-8px border-radius** - Not too round, not too sharp
4. **Excellent keyboard navigation** - Command palette (Cmd+K)
5. **Minimal borders** - Background color changes instead of visible borders
6. **Fast, subtle animations** - Things happen instantly
7. **Professional typography** - Inter at 13px with careful weight usage

### 12.2 Areas Where CreativeOS Can Differentiate

While maintaining Linear's cleanliness, the middle content area offers opportunities:

1. **Richer media previews** - Campaign assets can have larger thumbnails
2. **Visual progress indicators** - More graphical status displays
3. **Creative asset grids** - Gallery-style views for templates
4. **Interactive canvas areas** - For template editing/preview
5. **Color-coded campaigns** - More use of brand colors for campaigns

---

## 13. Implementation Checklist

### Phase 1: Foundation
- [ ] Set up CSS custom properties for color system
- [ ] Implement typography scale
- [ ] Configure spacing scale
- [ ] Set up light/dark mode toggle
- [ ] Configure Inter/Inter Display fonts

### Phase 2: Layout
- [ ] Implement three-panel layout structure
- [ ] Create collapsible sidebar component
- [ ] Build right properties panel
- [ ] Add responsive breakpoint handling

### Phase 3: Components
- [ ] Style navigation items
- [ ] Configure buttons (primary, secondary, ghost)
- [ ] Style cards and panels
- [ ] Implement status badges
- [ ] Style form inputs
- [ ] Build list/table components

### Phase 4: Polish
- [ ] Add transition animations
- [ ] Implement keyboard shortcuts
- [ ] Add focus states and accessibility
- [ ] Fine-tune dark mode
- [ ] Performance optimization

---

## Sources & References

- [Linear UI Redesign Blog](https://linear.app/now/how-we-redesigned-the-linear-ui)
- [Linear Custom Themes](https://linear.app/changelog/2020-12-04-themes)
- [Linear Style Themes Collection](https://linear.style/)
- [Linear Brand Guidelines](https://linear.app/brand)
- [Linear Figma Design System (Community)](https://www.figma.com/community/file/1222872653732371433/linear-design-system)
- [AlignUI Design System](https://www.alignui.com/)
- [AlignUI Code Library](https://alignui.com/welcome/code-library)

---

*Document Version: 1.0*
*Created: January 2025*
*For: Pitchback CreativeOS Platform*
