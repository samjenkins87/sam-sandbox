# Claude Design Skill: Linear-Style UI with Vercel Colors

## Overview

This skill document provides instructions for AI agents implementing UI/UX for the Pitchback CreativeOS platform. The design language combines:
- **Linear's layout patterns** (three-panel, tight spacing, 13px typography)
- **Vercel's Geist color system** (clean grays, pure black/white)
- **Crisp Azure accent** (`#3B82F6`) as the primary brand color
- **Vercel-style theme switcher** (System / Light / Dark)

**Default Mode: Light**

---

## Color System: Vercel Geist + Crisp Azure

### Light Mode (Default)

```typescript
const lightTheme = {
  // Backgrounds - Vercel's clean whites
  background: '#FFFFFF',           // Page background
  backgroundSecondary: '#FAFAFA',  // Cards, sidebars (accents-1)
  backgroundTertiary: '#F5F5F5',   // Hover states

  // Text - Pure black with gray scale
  foreground: '#000000',           // Primary text
  foregroundSecondary: '#666666',  // Secondary text (accents-5)
  foregroundTertiary: '#888888',   // Muted text (accents-4)
  foregroundQuaternary: '#999999', // Placeholder (accents-3)

  // Borders - Vercel's subtle grays
  border: '#EAEAEA',               // Primary borders (accents-2)
  borderSecondary: '#F5F5F5',      // Subtle dividers

  // Accent - CRISP AZURE
  accent: '#3B82F6',               // Blue-500 - Primary brand
  accentHover: '#2563EB',          // Blue-600 - Hover state
  accentLight: '#60A5FA',          // Blue-400 - Light variant
  accentSubtle: 'rgba(59, 130, 246, 0.08)',  // Selection backgrounds
  accentForeground: '#FFFFFF',     // Text on accent

  // Status Colors
  success: '#0070F3',              // Vercel blue (or use green #17C964)
  error: '#EE0000',                // Vercel red
  warning: '#F5A623',              // Vercel amber

  // Vercel Accent Scale (for reference)
  accents: {
    1: '#FAFAFA',
    2: '#EAEAEA',
    3: '#999999',
    4: '#888888',
    5: '#666666',
    6: '#444444',
    7: '#333333',
    8: '#111111',
  }
}
```

### Dark Mode

```typescript
const darkTheme = {
  // Backgrounds - Pure black with subtle elevation
  background: '#000000',           // Page background - TRUE BLACK
  backgroundSecondary: '#111111',  // Cards, sidebars (accents-8 inverted)
  backgroundTertiary: '#1A1A1A',   // Elevated surfaces
  backgroundHover: '#222222',      // Hover states

  // Text - Pure white with gray scale (inverted)
  foreground: '#FFFFFF',           // Primary text
  foregroundSecondary: '#A1A1A1',  // Secondary text
  foregroundTertiary: '#888888',   // Muted text
  foregroundQuaternary: '#666666', // Placeholder

  // Borders - Dark subtle grays
  border: '#333333',               // Primary borders (accents-7 inverted)
  borderSecondary: '#222222',      // Subtle dividers

  // Accent - CRISP AZURE (same hue, adjusted for dark)
  accent: '#3B82F6',               // Blue-500 - Primary brand
  accentHover: '#60A5FA',          // Blue-400 - Lighter on hover in dark
  accentLight: '#60A5FA',          // Blue-400 - Text highlights
  accentSubtle: 'rgba(59, 130, 246, 0.15)',  // Selection backgrounds
  accentForeground: '#FFFFFF',     // Text on accent

  // Status Colors (adjusted for dark)
  success: '#0070F3',
  error: '#FF4444',                // Brighter red for dark mode
  warning: '#F5A623',

  // Vercel Accent Scale - INVERTED for dark mode
  accents: {
    1: '#111111',  // Was #FAFAFA
    2: '#222222',  // Was #EAEAEA
    3: '#333333',
    4: '#444444',
    5: '#666666',
    6: '#888888',
    7: '#999999',
    8: '#FAFAFA',  // Was #111111
  }
}
```

### Azure Glow Effects

```css
/* Focus Ring - Used on inputs, buttons when focused */
.azure-focus {
  box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.4);
}

/* Selected Item Glow - Subtle for active nav items */
.azure-glow {
  box-shadow: 0 0 20px rgba(59, 130, 246, 0.15);
}

/* Active Background - Nav items, selected rows */
.azure-active {
  background-color: rgba(59, 130, 246, 0.08);
}

/* Dark mode active - Slightly more visible */
.dark .azure-active {
  background-color: rgba(59, 130, 246, 0.15);
}
```

---

## CSS Variables (Complete Theme)

```css
:root {
  /* Light Mode (Default) - Vercel Geist */
  --background: #FFFFFF;
  --foreground: #000000;

  --card: #FAFAFA;
  --card-foreground: #000000;

  --popover: #FFFFFF;
  --popover-foreground: #000000;

  --primary: #3B82F6;
  --primary-foreground: #FFFFFF;

  --secondary: #F5F5F5;
  --secondary-foreground: #000000;

  --muted: #FAFAFA;
  --muted-foreground: #666666;

  --accent: rgba(59, 130, 246, 0.08);
  --accent-foreground: #3B82F6;

  --destructive: #EE0000;
  --destructive-foreground: #FFFFFF;

  --border: #EAEAEA;
  --input: #EAEAEA;
  --ring: rgba(59, 130, 246, 0.4);

  /* Vercel Accent Scale */
  --accents-1: #FAFAFA;
  --accents-2: #EAEAEA;
  --accents-3: #999999;
  --accents-4: #888888;
  --accents-5: #666666;
  --accents-6: #444444;
  --accents-7: #333333;
  --accents-8: #111111;

  /* Radius - Vercel uses 5px standard */
  --radius: 6px;
}

.dark {
  /* Dark Mode - Vercel Geist Inverted */
  --background: #000000;
  --foreground: #FFFFFF;

  --card: #111111;
  --card-foreground: #FFFFFF;

  --popover: #111111;
  --popover-foreground: #FFFFFF;

  --primary: #3B82F6;
  --primary-foreground: #FFFFFF;

  --secondary: #1A1A1A;
  --secondary-foreground: #FFFFFF;

  --muted: #111111;
  --muted-foreground: #A1A1A1;

  --accent: rgba(59, 130, 246, 0.15);
  --accent-foreground: #60A5FA;

  --destructive: #7F1D1D;
  --destructive-foreground: #FECACA;

  --border: #333333;
  --input: #333333;
  --ring: rgba(59, 130, 246, 0.5);

  /* Vercel Accent Scale - INVERTED */
  --accents-1: #111111;
  --accents-2: #222222;
  --accents-3: #333333;
  --accents-4: #444444;
  --accents-5: #666666;
  --accents-6: #888888;
  --accents-7: #999999;
  --accents-8: #FAFAFA;
}
```

---

## Theme Switcher Implementation (Vercel Style)

### Dependencies

```bash
npm install next-themes
```

### ThemeProvider Setup (layout.tsx)

```tsx
// app/layout.tsx
import { ThemeProvider } from 'next-themes'

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body>
        <ThemeProvider
          attribute="class"
          defaultTheme="light"
          enableSystem
          disableTransitionOnChange={false}
        >
          {children}
        </ThemeProvider>
      </body>
    </html>
  )
}
```

### Theme Switcher Component (Vercel Style)

```tsx
'use client'

import { useTheme } from 'next-themes'
import { useEffect, useState } from 'react'
import { Monitor, Sun, Moon } from 'lucide-react'

export function ThemeSwitcher() {
  const { theme, setTheme } = useTheme()
  const [mounted, setMounted] = useState(false)

  // Prevent hydration mismatch
  useEffect(() => {
    setMounted(true)
  }, [])

  if (!mounted) {
    return (
      <div className="flex items-center gap-1 p-1 rounded-lg bg-secondary">
        <div className="w-8 h-8" />
        <div className="w-8 h-8" />
        <div className="w-8 h-8" />
      </div>
    )
  }

  const options = [
    { value: 'system', icon: Monitor, label: 'System' },
    { value: 'light', icon: Sun, label: 'Light' },
    { value: 'dark', icon: Moon, label: 'Dark' },
  ]

  return (
    <div className="flex items-center gap-1 p-1 rounded-lg bg-secondary border border-border">
      {options.map(({ value, icon: Icon, label }) => (
        <button
          key={value}
          onClick={() => setTheme(value)}
          className={`
            relative p-2 rounded-md transition-all duration-200
            ${theme === value
              ? 'bg-background text-foreground shadow-sm'
              : 'text-muted-foreground hover:text-foreground hover:bg-background/50'
            }
          `}
          title={label}
        >
          <Icon className="w-4 h-4" />
          {theme === value && (
            <span className="sr-only">{label} (active)</span>
          )}
        </button>
      ))}
    </div>
  )
}
```

### Alternative: Dropdown Style (Like Vercel Dashboard)

```tsx
'use client'

import { useTheme } from 'next-themes'
import { useEffect, useState } from 'react'
import { Monitor, Sun, Moon, ChevronDown } from 'lucide-react'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'

export function ThemeDropdown() {
  const { theme, setTheme, resolvedTheme } = useTheme()
  const [mounted, setMounted] = useState(false)

  useEffect(() => {
    setMounted(true)
  }, [])

  if (!mounted) return null

  const currentIcon = {
    light: Sun,
    dark: Moon,
    system: Monitor,
  }[theme ?? 'system']

  const Icon = currentIcon ?? Monitor

  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <button className="flex items-center gap-2 px-3 py-1.5 rounded-md text-[13px] text-muted-foreground hover:text-foreground hover:bg-secondary transition-colors">
          <Icon className="w-4 h-4" />
          <span className="capitalize">{theme}</span>
          <ChevronDown className="w-3 h-3 opacity-50" />
        </button>
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end" className="w-32">
        <DropdownMenuItem onClick={() => setTheme('system')}>
          <Monitor className="w-4 h-4 mr-2" />
          System
        </DropdownMenuItem>
        <DropdownMenuItem onClick={() => setTheme('light')}>
          <Sun className="w-4 h-4 mr-2" />
          Light
        </DropdownMenuItem>
        <DropdownMenuItem onClick={() => setTheme('dark')}>
          <Moon className="w-4 h-4 mr-2" />
          Dark
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  )
}
```

### CSS for Smooth Theme Transitions

```css
/* Add to globals.css */
html {
  transition: background-color 0.3s ease, color 0.3s ease;
}

/* Prevent transition on initial load */
html.no-transition,
html.no-transition * {
  transition: none !important;
}

/* Color scheme for native elements */
.light {
  color-scheme: light;
}

.dark {
  color-scheme: dark;
}
```

---

## Typography System

```typescript
const typography = {
  fontFamily: '"Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif',
  fontDisplay: '"Inter Display", "Inter", sans-serif',
  fontMono: '"Geist Mono", "SF Mono", "Fira Code", monospace',

  sizes: {
    xs: '11px',
    sm: '12px',
    base: '13px',  // DEFAULT - Linear uses 13px
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
}
```

---

## Layout: Three-Panel Structure

```tsx
<div className="flex h-screen bg-background text-foreground">
  {/* Left Sidebar - 200px */}
  <aside className="w-[200px] bg-card border-r border-border flex-shrink-0 flex flex-col">
    {/* Navigation */}
  </aside>

  {/* Main Content Area */}
  <div className="flex-1 flex flex-col min-w-[400px]">
    {/* Top Nav/Header - 48px */}
    <header className="h-12 border-b border-border flex items-center px-4 bg-background">
      {/* Header with theme switcher */}
      <div className="flex-1" />
      <ThemeSwitcher />
    </header>

    {/* Content */}
    <main className="flex-1 overflow-auto bg-background">
      {/* Page content */}
    </main>
  </div>

  {/* Right Panel - 300px */}
  <aside className="w-[300px] bg-card border-l border-border flex-shrink-0">
    {/* Properties panel */}
  </aside>
</div>
```

---

## Component Patterns

### Navigation Item

```tsx
function NavItem({ icon: Icon, label, active }: NavItemProps) {
  return (
    <button
      className={cn(
        "flex items-center gap-2 w-full px-2 py-1.5 rounded-md",
        "text-[13px] transition-colors duration-150",
        active
          ? "bg-[rgba(59,130,246,0.08)] text-accent-foreground dark:bg-[rgba(59,130,246,0.15)]"
          : "text-muted-foreground hover:bg-secondary hover:text-foreground"
      )}
    >
      <Icon className={cn("w-4 h-4", active ? "text-primary" : "opacity-60")} />
      <span>{label}</span>
    </button>
  );
}
```

### Card

```tsx
<div className="bg-card border border-border rounded-md p-4">
  {/* Card content */}
</div>
```

### Button

```tsx
// Primary
<button className="px-3 py-1.5 bg-primary text-primary-foreground text-[13px] font-medium rounded-md hover:bg-primary/90 transition-colors">
  Button
</button>

// Secondary
<button className="px-3 py-1.5 bg-secondary text-foreground text-[13px] font-medium rounded-md border border-border hover:bg-secondary/80 transition-colors">
  Button
</button>

// Ghost
<button className="px-3 py-1.5 text-muted-foreground text-[13px] font-medium rounded-md hover:bg-secondary hover:text-foreground transition-colors">
  Button
</button>
```

### Input

```tsx
<input
  type="text"
  className="w-full px-3 py-2 text-[13px] bg-background border border-border rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring transition-all"
  placeholder="Enter value..."
/>
```

---

## Do's and Don'ts

### DO:
- Use pure `#000` / `#FFF` for max contrast (Vercel style)
- Use `#EAEAEA` for borders in light mode, `#333` in dark
- Keep border-radius at 5-6px (Vercel uses 5px)
- Use the 8-tier accent scale for grays
- Implement system theme detection
- Add smooth transitions between themes (0.3s)
- Use Inter + Geist Mono fonts

### DON'T:
- Use warm grays - stick to neutral/cool
- Use thick borders (1px max)
- Use shadows for elevation in dark mode
- Forget to handle hydration for theme switcher
- Use different accent colors between modes (keep Azure consistent)

---

## Tailwind Configuration

```javascript
// tailwind.config.js
module.exports = {
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        border: 'var(--border)',
        input: 'var(--input)',
        ring: 'var(--ring)',
        background: 'var(--background)',
        foreground: 'var(--foreground)',
        primary: {
          DEFAULT: 'var(--primary)',
          foreground: 'var(--primary-foreground)',
        },
        secondary: {
          DEFAULT: 'var(--secondary)',
          foreground: 'var(--secondary-foreground)',
        },
        destructive: {
          DEFAULT: 'var(--destructive)',
          foreground: 'var(--destructive-foreground)',
        },
        muted: {
          DEFAULT: 'var(--muted)',
          foreground: 'var(--muted-foreground)',
        },
        accent: {
          DEFAULT: 'var(--accent)',
          foreground: 'var(--accent-foreground)',
        },
        popover: {
          DEFAULT: 'var(--popover)',
          foreground: 'var(--popover-foreground)',
        },
        card: {
          DEFAULT: 'var(--card)',
          foreground: 'var(--card-foreground)',
        },
        // Vercel accent scale
        'accents-1': 'var(--accents-1)',
        'accents-2': 'var(--accents-2)',
        'accents-3': 'var(--accents-3)',
        'accents-4': 'var(--accents-4)',
        'accents-5': 'var(--accents-5)',
        'accents-6': 'var(--accents-6)',
        'accents-7': 'var(--accents-7)',
        'accents-8': 'var(--accents-8)',
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
}
```

---

## Implementation Checklist

### Theme System
- [ ] Install `next-themes`
- [ ] Add ThemeProvider to root layout
- [ ] Create ThemeSwitcher component
- [ ] Add CSS variables for light/dark modes
- [ ] Add transition styles for smooth switching
- [ ] Test system preference detection

### Colors
- [ ] Pure black (#000) background in dark mode
- [ ] Pure white (#FFF) background in light mode
- [ ] Vercel gray scale (8 accents)
- [ ] Crisp Azure (#3B82F6) accent throughout
- [ ] Proper contrast ratios (WCAG AA)

### Components
- [ ] Navigation items with azure highlight
- [ ] Cards with subtle borders
- [ ] Buttons (primary azure, secondary, ghost)
- [ ] Inputs with azure focus ring
- [ ] Status badges

---

## Quick Reference: Key Colors

| Token | Light | Dark |
|-------|-------|------|
| Background | `#FFFFFF` | `#000000` |
| Card/Sidebar | `#FAFAFA` | `#111111` |
| Border | `#EAEAEA` | `#333333` |
| Text Primary | `#000000` | `#FFFFFF` |
| Text Muted | `#666666` | `#A1A1A1` |
| Accent | `#3B82F6` | `#3B82F6` |
| Accent Hover | `#2563EB` | `#60A5FA` |
| Selection BG | `rgba(59,130,246,0.08)` | `rgba(59,130,246,0.15)` |

---

*Version: 3.0 | Vercel Geist Colors + Crisp Azure Accent*
*For: Pitchback CreativeOS Platform*
