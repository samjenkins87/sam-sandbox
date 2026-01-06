# Pitchback CreativeOS UI Specification

> **Version**: 1.0
> **Last Updated**: January 2025
> **Design System**: Linear Layout + Vercel Geist Colors + Crisp Azure Accent

---

## Overview

This specification defines the UI design system for Pitchback CreativeOS, combining:
- **Linear's layout patterns** - Three-panel architecture, 13px typography, tight spacing
- **Vercel's Geist colors** - Pure black/white, 8-tier gray scale
- **Crisp Azure accent** - `#3B82F6` as primary brand color
- **Theme switching** - System / Light / Dark (light default)

---

## Quick Start

### 1. Install Dependencies

```bash
npm install next-themes
```

### 2. Add CSS Variables to `globals.css`

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    /* Light Mode (Default) */
    --background: 0 0% 100%;
    --foreground: 0 0% 0%;
    --card: 0 0% 98%;
    --card-foreground: 0 0% 0%;
    --popover: 0 0% 100%;
    --popover-foreground: 0 0% 0%;
    --primary: 217 91% 60%;
    --primary-foreground: 0 0% 100%;
    --secondary: 0 0% 96%;
    --secondary-foreground: 0 0% 0%;
    --muted: 0 0% 98%;
    --muted-foreground: 0 0% 40%;
    --accent: 217 91% 60% / 0.08;
    --accent-foreground: 217 91% 60%;
    --destructive: 0 100% 47%;
    --destructive-foreground: 0 0% 100%;
    --border: 0 0% 92%;
    --input: 0 0% 92%;
    --ring: 217 91% 60% / 0.4;
    --radius: 6px;
  }

  .dark {
    /* Dark Mode */
    --background: 0 0% 0%;
    --foreground: 0 0% 100%;
    --card: 0 0% 7%;
    --card-foreground: 0 0% 100%;
    --popover: 0 0% 7%;
    --popover-foreground: 0 0% 100%;
    --primary: 217 91% 60%;
    --primary-foreground: 0 0% 100%;
    --secondary: 0 0% 10%;
    --secondary-foreground: 0 0% 100%;
    --muted: 0 0% 7%;
    --muted-foreground: 0 0% 63%;
    --accent: 217 91% 60% / 0.15;
    --accent-foreground: 213 94% 68%;
    --destructive: 0 63% 31%;
    --destructive-foreground: 0 86% 90%;
    --border: 0 0% 20%;
    --input: 0 0% 20%;
    --ring: 217 91% 60% / 0.5;
  }
}

html {
  transition: background-color 0.3s ease, color 0.3s ease;
}

.light { color-scheme: light; }
.dark { color-scheme: dark; }
```

### 3. Wrap App with ThemeProvider

```tsx
// app/layout.tsx
import { ThemeProvider } from 'next-themes'

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body>
        <ThemeProvider attribute="class" defaultTheme="light" enableSystem>
          {children}
        </ThemeProvider>
      </body>
    </html>
  )
}
```

---

## Color Palette

### Hex Values Reference

| Token | Light | Dark | Usage |
|-------|-------|------|-------|
| `--background` | `#FFFFFF` | `#000000` | Page background |
| `--card` | `#FAFAFA` | `#111111` | Sidebars, cards, panels |
| `--secondary` | `#F5F5F5` | `#1A1A1A` | Hover states |
| `--border` | `#EAEAEA` | `#333333` | All borders (1px) |
| `--foreground` | `#000000` | `#FFFFFF` | Primary text |
| `--muted-foreground` | `#666666` | `#A1A1A1` | Secondary text |
| `--primary` | `#3B82F6` | `#3B82F6` | Buttons, links, accent |
| `--accent` | `rgba(59,130,246,0.08)` | `rgba(59,130,246,0.15)` | Selected items BG |
| `--accent-foreground` | `#3B82F6` | `#60A5FA` | Active text |

### Vercel Gray Scale

```
Light: #FAFAFA → #EAEAEA → #999 → #888 → #666 → #444 → #333 → #111
Dark:  #111 → #222 → #333 → #444 → #666 → #888 → #999 → #FAFAFA
```

### Status Colors

| Status | Color | Usage |
|--------|-------|-------|
| In Progress | `#F5A623` | Yellow/amber badges |
| Complete | `#0070F3` | Blue badges |
| Error | `#EE0000` / `#FF4444` | Error states |

---

## Typography

| Element | Size | Weight | Color |
|---------|------|--------|-------|
| Page Title | 18px | 600 | foreground |
| Section Header | 13px | 600 | foreground |
| Body Text | **13px** | 400 | foreground |
| Secondary Text | 12-13px | 400 | muted-foreground |
| Nav Labels | 13px | 400/500 | muted-foreground |
| Metadata | 11px | 400 | muted-foreground |

**Font Stack:**
```css
font-family: "Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
font-family-mono: "Geist Mono", "SF Mono", monospace;
```

---

## Layout Structure

```
┌─────────────────────────────────────────────────────────────────┐
│                    HEADER (48px) - optional                      │
├──────────┬────────────────────────────────┬─────────────────────┤
│          │                                │                     │
│  LEFT    │         MAIN CONTENT           │     RIGHT           │
│  SIDEBAR │                                │     PANEL           │
│          │                                │                     │
│  200px   │        Flexible                │     300px           │
│  bg-card │        bg-background           │     bg-card         │
│          │                                │                     │
└──────────┴────────────────────────────────┴─────────────────────┘
```

### Implementation

```tsx
<div className="flex h-screen bg-background text-foreground">
  {/* Left Sidebar */}
  <aside className="w-[200px] bg-card border-r border-border flex-shrink-0 flex flex-col">
    {/* Workspace switcher + Navigation */}
  </aside>

  {/* Main Area */}
  <div className="flex-1 flex flex-col min-w-[400px]">
    <header className="h-12 border-b border-border flex items-center px-4">
      {/* Breadcrumb + Tabs + Theme Switcher */}
    </header>
    <main className="flex-1 overflow-auto">
      {/* Content */}
    </main>
  </div>

  {/* Right Panel */}
  <aside className="w-[300px] bg-card border-l border-border flex-shrink-0">
    {/* Properties */}
  </aside>
</div>
```

---

## Theme Switcher Component

```tsx
'use client'

import { useTheme } from 'next-themes'
import { useEffect, useState } from 'react'
import { Monitor, Sun, Moon } from 'lucide-react'

export function ThemeSwitcher() {
  const { theme, setTheme } = useTheme()
  const [mounted, setMounted] = useState(false)

  useEffect(() => setMounted(true), [])
  if (!mounted) return <div className="w-24 h-8" />

  const options = [
    { value: 'system', icon: Monitor },
    { value: 'light', icon: Sun },
    { value: 'dark', icon: Moon },
  ]

  return (
    <div className="flex gap-1 p-1 rounded-lg bg-secondary border border-border">
      {options.map(({ value, icon: Icon }) => (
        <button
          key={value}
          onClick={() => setTheme(value)}
          className={`p-2 rounded-md transition-all ${
            theme === value
              ? 'bg-background text-foreground shadow-sm'
              : 'text-muted-foreground hover:text-foreground'
          }`}
        >
          <Icon className="w-4 h-4" />
        </button>
      ))}
    </div>
  )
}
```

---

## Component Patterns

### Navigation Item

```tsx
<button className={cn(
  "flex items-center gap-2 w-full px-2 py-1.5 rounded-md text-[13px] transition-colors",
  active
    ? "bg-accent text-accent-foreground"
    : "text-muted-foreground hover:bg-secondary hover:text-foreground"
)}>
  <Icon className={cn("w-4 h-4", active ? "text-primary" : "opacity-60")} />
  <span>{label}</span>
</button>
```

### Buttons

```tsx
// Primary (Azure)
<button className="px-3 py-1.5 bg-primary text-primary-foreground text-[13px] font-medium rounded-md hover:bg-primary/90">
  Action
</button>

// Secondary
<button className="px-3 py-1.5 bg-secondary text-foreground text-[13px] font-medium rounded-md border border-border hover:bg-secondary/80">
  Cancel
</button>

// Ghost
<button className="px-3 py-1.5 text-muted-foreground text-[13px] rounded-md hover:bg-secondary hover:text-foreground">
  Options
</button>
```

### Card

```tsx
<div className="bg-card border border-border rounded-md p-4">
  {/* Content */}
</div>
```

### Input

```tsx
<input className="w-full px-3 py-2 text-[13px] bg-background border border-border rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring" />
```

### Status Badge

```tsx
<span className="inline-flex items-center gap-1.5 px-2 py-0.5 rounded text-[12px] font-medium bg-yellow-500/15 text-yellow-600 dark:text-yellow-500">
  <span className="w-1.5 h-1.5 rounded-full bg-current" />
  In Progress
</span>
```

---

## Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| `space-1` | 4px | Icon gaps |
| `space-2` | 8px | Between elements |
| `space-3` | 12px | Standard padding |
| `space-4` | 16px | Section spacing |
| `space-6` | 24px | Page margins |

---

## Implementation Checklist

### Phase 1: Foundation
- [ ] Add CSS variables to `globals.css`
- [ ] Install and configure `next-themes`
- [ ] Add ThemeProvider wrapper
- [ ] Create ThemeSwitcher component
- [ ] Configure Tailwind with color tokens

### Phase 2: Layout
- [ ] Build three-panel layout shell
- [ ] Implement left sidebar with navigation
- [ ] Add top header with tabs
- [ ] Create right properties panel
- [ ] Add responsive collapse behavior

### Phase 3: Components
- [ ] Style navigation items with azure active state
- [ ] Update buttons (primary, secondary, ghost)
- [ ] Style cards and panels
- [ ] Update form inputs with azure focus ring
- [ ] Add status badges

### Phase 4: Polish
- [ ] Test light/dark mode transitions
- [ ] Verify contrast ratios (WCAG AA)
- [ ] Add keyboard navigation support
- [ ] Test system theme detection

---

## Design Rules

### Do
- Use **13px** as base font size
- Use pure `#000` / `#FFF` for max contrast
- Keep borders at **1px** with `#EAEAEA` / `#333`
- Use **6px** border-radius for components
- Keep transitions under **200ms**
- Use `rgba(59,130,246,0.08-0.15)` for selections

### Don't
- Use shadows for elevation (use background color)
- Use warm grays (stick to neutral)
- Use thick borders
- Forget hydration handling for theme switcher
- Mix different accent colors

---

## Resources

### Official Documentation
- [Vercel Geist Design System](https://vercel.com/geist/introduction)
- [Vercel Geist Colors](https://vercel.com/geist/colors)
- [Vercel Theme Switcher](https://vercel.com/geist/theme-switcher)
- [Linear UI Redesign](https://linear.app/now/how-we-redesigned-the-linear-ui)

### Implementation References
- [next-themes](https://github.com/pacocoursey/next-themes)
- [Vercel CSS Variables](https://github.com/2nthony/vercel-css-vars)
- [Theme Switcher Next.js](https://github.com/thiagobarbosa/theme-switcher-nextjs)

### Design Assets
- [Linear Figma Design System](https://www.figma.com/community/file/1222872653732371433)
- [Geist Design System Figma](https://www.figma.com/community/file/1330020847221146106)
- [AlignUI Design System](https://www.alignui.com/)

---

## Tailwind Config

```javascript
// tailwind.config.ts
import type { Config } from 'tailwindcss'

const config: Config = {
  darkMode: 'class',
  content: ['./app/**/*.{ts,tsx}', './components/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        border: 'hsl(var(--border))',
        input: 'hsl(var(--input))',
        ring: 'hsl(var(--ring))',
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        primary: {
          DEFAULT: 'hsl(var(--primary))',
          foreground: 'hsl(var(--primary-foreground))',
        },
        secondary: {
          DEFAULT: 'hsl(var(--secondary))',
          foreground: 'hsl(var(--secondary-foreground))',
        },
        muted: {
          DEFAULT: 'hsl(var(--muted))',
          foreground: 'hsl(var(--muted-foreground))',
        },
        accent: {
          DEFAULT: 'hsl(var(--accent))',
          foreground: 'hsl(var(--accent-foreground))',
        },
        destructive: {
          DEFAULT: 'hsl(var(--destructive))',
          foreground: 'hsl(var(--destructive-foreground))',
        },
        card: {
          DEFAULT: 'hsl(var(--card))',
          foreground: 'hsl(var(--card-foreground))',
        },
        popover: {
          DEFAULT: 'hsl(var(--popover))',
          foreground: 'hsl(var(--popover-foreground))',
        },
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['Geist Mono', 'SF Mono', 'monospace'],
      },
      fontSize: {
        xs: '11px',
        sm: '12px',
        base: '13px',
        md: '14px',
        lg: '16px',
      },
      borderRadius: {
        DEFAULT: '6px',
        sm: '4px',
        md: '6px',
        lg: '8px',
      },
    },
  },
  plugins: [],
}

export default config
```

---

*Pitchback CreativeOS UI Specification v1.0*
