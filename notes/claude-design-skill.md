# Claude Design Skill: Linear-Style UI Implementation

## Overview

This skill document provides instructions for AI agents implementing UI/UX for the Pitchback CreativeOS platform. The design language is based on Linear's UI with customizations for a creative studio workflow.

---

## Quick Reference: Design Tokens

### Colors (Copy-Paste Ready)

```typescript
// Light Mode
const lightTheme = {
  // Backgrounds
  bgPrimary: '#FFFFFF',
  bgSecondary: '#FAFAFA',
  bgTertiary: '#F5F5F5',
  bgHover: '#F0F0F0',

  // Text
  textPrimary: '#1A1A1A',
  textSecondary: '#6B6B6B',
  textTertiary: '#9B9B9B',

  // Borders
  borderPrimary: '#E5E5E5',
  borderSecondary: '#EFEFEF',

  // Accent
  accent: '#5E6AD2',
  accentHover: '#4F5ABF',
  accentSubtle: '#EEF0FF',

  // Status
  statusProgress: '#F2C94C',
  statusComplete: '#6FCF97',
  statusError: '#EB5757',
  statusMuted: '#828282',
}

// Dark Mode
const darkTheme = {
  // Backgrounds
  bgPrimary: '#0D0D0D',
  bgSecondary: '#141414',
  bgTertiary: '#1A1A1A',
  bgHover: '#252525',

  // Text
  textPrimary: '#FAFAFA',
  textSecondary: '#A0A0A0',
  textTertiary: '#6B6B6B',

  // Borders
  borderPrimary: '#2A2A2A',
  borderSecondary: '#1F1F1F',

  // Accent (same)
  accent: '#5E6AD2',
  accentHover: '#6E7BE0',
  accentSubtle: '#1A1D3D',

  // Status (same)
  statusProgress: '#F2C94C',
  statusComplete: '#6FCF97',
  statusError: '#EB5757',
  statusMuted: '#6B6B6B',
}
```

### Typography

```typescript
const typography = {
  fontFamily: '"Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif',
  fontDisplay: '"Inter Display", "Inter", sans-serif',
  fontMono: '"SF Mono", "Fira Code", monospace',

  sizes: {
    xs: '11px',
    sm: '12px',
    base: '13px',  // DEFAULT - Linear uses 13px not 14px!
    md: '14px',
    lg: '16px',
    xl: '18px',
    '2xl': '24px',
    '3xl': '32px',
  },

  weights: {
    normal: 400,
    medium: 500,
    semibold: 600,
    bold: 700,
  },

  lineHeight: {
    tight: 1.2,
    normal: 1.5,
    relaxed: 1.6,
  },
}
```

### Spacing

```typescript
const spacing = {
  0: '0px',
  1: '4px',
  2: '8px',
  3: '12px',
  4: '16px',
  5: '20px',
  6: '24px',
  8: '32px',
  10: '40px',
  12: '48px',
}
```

### Border Radius

```typescript
const radius = {
  sm: '4px',
  md: '6px',   // DEFAULT for buttons, inputs
  lg: '8px',   // DEFAULT for cards
  xl: '12px',
  full: '9999px',
}
```

---

## Component Implementation Rules

### RULE 1: Layout Structure

Always implement a three-panel layout:

```tsx
<div className="flex h-screen">
  {/* Left Sidebar - 180-220px, collapsible */}
  <aside className="w-[200px] bg-secondary border-r border-primary flex-shrink-0">
    {/* Navigation */}
  </aside>

  {/* Main Content - Flexible */}
  <main className="flex-1 min-w-[400px] overflow-auto">
    {/* Content */}
  </main>

  {/* Right Panel - 280-320px, optional */}
  <aside className="w-[300px] bg-secondary border-l border-primary flex-shrink-0">
    {/* Properties/Context */}
  </aside>
</div>
```

### RULE 2: Navigation Items

```tsx
// Sidebar navigation item pattern
<button className="
  flex items-center gap-2 w-full
  px-3 py-1.5
  text-[13px] text-secondary
  rounded-md
  hover:bg-tertiary hover:text-primary
  transition-colors duration-100
  data-[active=true]:bg-accent-subtle data-[active=true]:text-primary data-[active=true]:font-medium
">
  <Icon className="w-4 h-4 opacity-70" />
  <span>Label</span>
</button>
```

### RULE 3: Buttons

```tsx
// Primary Button
<button className="
  px-3 py-1.5
  bg-accent text-white
  text-[13px] font-medium
  rounded-md
  hover:bg-accent-hover
  transition-colors duration-150
">
  Button
</button>

// Secondary Button
<button className="
  px-3 py-1.5
  bg-transparent text-primary
  text-[13px] font-medium
  border border-primary
  rounded-md
  hover:bg-tertiary
  transition-colors duration-150
">
  Button
</button>

// Ghost Button
<button className="
  px-3 py-1.5
  bg-transparent text-secondary
  text-[13px] font-medium
  rounded-md
  hover:bg-tertiary hover:text-primary
  transition-colors duration-150
">
  Button
</button>
```

### RULE 4: Cards

```tsx
<div className="
  bg-primary
  border border-primary
  rounded-lg
  p-4
  dark:bg-tertiary dark:border-secondary
">
  {/* Card content */}
</div>
```

### RULE 5: Status Badges

```tsx
// Status badge with dot indicator
<span className="
  inline-flex items-center gap-1.5
  px-2 py-1
  text-[12px] font-medium
  rounded
  bg-status-progress/15 text-status-progress
">
  <span className="w-1.5 h-1.5 rounded-full bg-current" />
  In Progress
</span>
```

### RULE 6: Form Inputs

```tsx
<input
  type="text"
  className="
    w-full px-3 py-2
    text-[13px] text-primary
    bg-primary
    border border-primary
    rounded-md
    placeholder:text-tertiary
    focus:outline-none focus:border-accent focus:ring-[3px] focus:ring-accent-subtle
    transition-all duration-150
  "
  placeholder="Enter value..."
/>
```

### RULE 7: List Items

```tsx
<div className="
  flex items-center gap-3
  px-4 py-2
  text-[13px]
  border-b border-secondary
  hover:bg-hover
  transition-colors duration-100
  cursor-pointer
">
  <Icon className="w-4 h-4 text-tertiary" />
  <span className="text-tertiary font-mono text-[12px]">ID-123</span>
  <span className="flex-1 text-primary">Item title</span>
  <span className="text-secondary text-[12px]">Metadata</span>
</div>
```

### RULE 8: Property Row (Right Panel)

```tsx
<div className="flex items-center justify-between py-2 border-b border-secondary">
  <span className="text-[12px] text-secondary min-w-[100px]">
    Property Label
  </span>
  <span className="text-[13px] text-primary">
    Property Value
  </span>
</div>
```

---

## Do's and Don'ts

### DO:
- Use 13px as base font size
- Use Inter font family
- Keep border-radius at 6-8px
- Use subtle background color changes for elevation (not shadows)
- Keep animations under 200ms
- Use high contrast text (7:1 for primary)
- Use opacity for icon colors (0.6-0.8)
- Use semantic color tokens, not hardcoded colors

### DON'T:
- Use large border-radius (12px+) on small elements
- Use drop shadows for elevation
- Use bright/saturated accent colors
- Use font sizes smaller than 11px
- Use thick borders (keep at 1px)
- Use slow animations (300ms+)
- Use multicolor icons
- Mix warm and cool grays

---

## Tailwind CSS Configuration

When configuring Tailwind for Linear-style design:

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        // Map to CSS variables for theme switching
        primary: 'var(--bg-primary)',
        secondary: 'var(--bg-secondary)',
        tertiary: 'var(--bg-tertiary)',
        hover: 'var(--bg-hover)',
        accent: {
          DEFAULT: 'var(--accent)',
          hover: 'var(--accent-hover)',
          subtle: 'var(--accent-subtle)',
        },
        'text-primary': 'var(--text-primary)',
        'text-secondary': 'var(--text-secondary)',
        'text-tertiary': 'var(--text-tertiary)',
        'border-primary': 'var(--border-primary)',
        'border-secondary': 'var(--border-secondary)',
        status: {
          progress: '#F2C94C',
          complete: '#6FCF97',
          error: '#EB5757',
          muted: '#828282',
        },
      },
      fontFamily: {
        sans: ['Inter', '-apple-system', 'BlinkMacSystemFont', 'sans-serif'],
        display: ['Inter Display', 'Inter', 'sans-serif'],
        mono: ['SF Mono', 'Fira Code', 'monospace'],
      },
      fontSize: {
        xs: '11px',
        sm: '12px',
        base: '13px',
        md: '14px',
        lg: '16px',
        xl: '18px',
        '2xl': '24px',
        '3xl': '32px',
      },
      borderRadius: {
        sm: '4px',
        DEFAULT: '6px',
        md: '6px',
        lg: '8px',
        xl: '12px',
      },
      spacing: {
        // Uses default Tailwind spacing (4px base)
      },
    },
  },
}
```

---

## CSS Variables Setup

```css
:root {
  /* Light Mode (Default) */
  --bg-primary: #FFFFFF;
  --bg-secondary: #FAFAFA;
  --bg-tertiary: #F5F5F5;
  --bg-hover: #F0F0F0;

  --text-primary: #1A1A1A;
  --text-secondary: #6B6B6B;
  --text-tertiary: #9B9B9B;

  --border-primary: #E5E5E5;
  --border-secondary: #EFEFEF;

  --accent: #5E6AD2;
  --accent-hover: #4F5ABF;
  --accent-subtle: #EEF0FF;
}

.dark {
  /* Dark Mode */
  --bg-primary: #0D0D0D;
  --bg-secondary: #141414;
  --bg-tertiary: #1A1A1A;
  --bg-hover: #252525;

  --text-primary: #FAFAFA;
  --text-secondary: #A0A0A0;
  --text-tertiary: #6B6B6B;

  --border-primary: #2A2A2A;
  --border-secondary: #1F1F1F;

  --accent: #5E6AD2;
  --accent-hover: #6E7BE0;
  --accent-subtle: #1A1D3D;
}
```

---

## AlignUI Integration Notes

When using AlignUI Pro components, apply these overrides:

### Button Customization
```tsx
// Override AlignUI Button for Linear style
<Button
  className="!px-3 !py-1.5 !text-[13px] !rounded-md"
  variant="primary"
>
  Action
</Button>
```

### Card Customization
```tsx
// Override AlignUI Card
<Card className="!rounded-lg !border-border-primary !shadow-none">
  Content
</Card>
```

### Input Customization
```tsx
// Override AlignUI Input
<Input
  className="!text-[13px] !py-2 !rounded-md"
  placeholder="Enter value..."
/>
```

### General Override Pattern

Create a `linear-overrides.css` file:

```css
/* AlignUI -> Linear Style Overrides */

/* Reduce border radius globally */
[class*="rounded-xl"] { border-radius: 8px !important; }
[class*="rounded-2xl"] { border-radius: 12px !important; }

/* Standardize text sizes */
.align-input, .align-select, .align-button {
  font-size: 13px !important;
}

/* Remove shadows, use border elevation */
.align-card, .align-dropdown {
  box-shadow: none !important;
  border: 1px solid var(--border-primary) !important;
}

/* Tighten padding */
.align-button {
  padding: 6px 12px !important;
}

.align-input {
  padding: 8px 12px !important;
}
```

---

## Implementation Checklist for AI Agents

When implementing UI changes, verify:

- [ ] Font size is 13px for body text
- [ ] Border radius is 6-8px for components
- [ ] Using CSS variables for colors (theme-aware)
- [ ] Hover states use background color change, not shadow
- [ ] Transitions are 100-150ms
- [ ] Icons are 16px with 0.7 opacity
- [ ] Text contrast meets WCAG AA (4.5:1 minimum)
- [ ] Three-panel layout is maintained
- [ ] Right panel uses property-row pattern
- [ ] Navigation items have correct hover/active states

---

## Common Patterns

### Page Header
```tsx
<header className="flex items-center justify-between px-6 py-4 border-b border-secondary">
  <div className="flex items-center gap-3">
    <Icon className="w-5 h-5 text-secondary" />
    <h1 className="text-lg font-semibold text-primary">Page Title</h1>
  </div>
  <div className="flex items-center gap-2">
    <Button variant="ghost">Secondary</Button>
    <Button variant="primary">Primary</Button>
  </div>
</header>
```

### Empty State
```tsx
<div className="flex flex-col items-center justify-center py-16 text-center">
  <Icon className="w-12 h-12 text-tertiary mb-4" />
  <h3 className="text-md font-medium text-primary mb-1">No items yet</h3>
  <p className="text-sm text-secondary mb-4">Get started by creating your first item.</p>
  <Button variant="primary">Create Item</Button>
</div>
```

### Loading State
```tsx
<div className="flex items-center justify-center py-8">
  <Spinner className="w-5 h-5 text-accent animate-spin" />
</div>
```

---

*This skill document is optimized for AI agents implementing UI for Pitchback CreativeOS.*
*Version: 1.0 | Based on Linear UI Design System*
